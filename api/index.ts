import type { VercelRequest, VercelResponse } from '@vercel/node';
import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { connectDatabase } from '../backend/src/config/database.js';
import sessionsRouter from '../backend/src/routes/sessions.js';
import aiRouter from '../backend/src/routes/ai.js';
import { errorHandler } from '../backend/src/middleware/errorHandler.js';
import { apiLimiter } from '../backend/src/middleware/rateLimiter.js';

dotenv.config();

const app = express();

// Middleware
app.use(cors({
  origin: process.env.FRONTEND_URL || '*',
  credentials: true,
}));
app.use(express.json());
app.use(apiLimiter);

// Connect to MongoDB (with connection pooling for serverless)
let isConnected = false;
const connectToDatabase = async () => {
  if (!isConnected) {
    await connectDatabase();
    isConnected = true;
  }
};

// Health check
app.get('/api/health', async (_req, res) => {
  try {
    await connectToDatabase();
    res.json({ 
      status: 'healthy',
      timestamp: new Date().toISOString(),
      environment: process.env.NODE_ENV || 'development'
    });
  } catch (error) {
    res.status(503).json({ 
      status: 'unhealthy',
      error: error instanceof Error ? error.message : 'Unknown error'
    });
  }
});

// API Routes
app.use('/api/sessions', sessionsRouter);
app.use('/api/ai', aiRouter);

// Error handling
app.use(errorHandler);

// Export the Express app as a serverless function
export default async (req: VercelRequest, res: VercelResponse) => {
  try {
    await connectToDatabase();
    return app(req, res);
  } catch (error) {
    console.error('Error connecting to database:', error);
    return res.status(500).json({ 
      error: 'Internal server error',
      message: error instanceof Error ? error.message : 'Unknown error'
    });
  }
};
