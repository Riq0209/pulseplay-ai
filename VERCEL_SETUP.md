# Vercel Deployment Setup

This guide helps you deploy PulsePlay AI to Vercel with the updated configuration.

## Project Structure

```
pulseplay-ai/
├── api/              # Vercel serverless functions
│   └── index.ts      # Main API handler
├── backend/          # Backend source code
│   └── src/          # Shared with serverless functions
├── src/              # Frontend React app
├── dist/             # Build output (generated)
└── vercel.json       # Vercel configuration
```

## Quick Deployment Steps

### 1. Prerequisites

Make sure you have:
- ✅ MongoDB Atlas account and connection string
- ✅ Auth0 account and credentials
- ✅ Gemini API key
- ✅ GitHub repository with your code

### 2. Push to GitHub

```bash
git add .
git commit -m "Configure for Vercel deployment"
git push origin main
```

### 3. Deploy to Vercel

#### Option A: Via Vercel Dashboard (Recommended)

1. Go to [vercel.com](https://vercel.com)
2. Click **"Add New Project"**
3. Import your GitHub repository
4. Vercel will auto-detect the configuration from `vercel.json`
5. Add environment variables (see below)
6. Click **"Deploy"**

#### Option B: Via Vercel CLI

```bash
# Install Vercel CLI
npm i -g vercel

# Login
vercel login

# Deploy
vercel --prod
```

### 4. Configure Environment Variables

In your Vercel project dashboard, go to **Settings** → **Environment Variables** and add:

| Variable Name | Value | Notes |
|--------------|-------|-------|
| `MONGODB_URI` | `mongodb+srv://...` | Your MongoDB Atlas connection string |
| `AUTH0_DOMAIN` | `dev-xxx.us.auth0.com` | From Auth0 dashboard |
| `AUTH0_CLIENT_ID` | `your_client_id` | From Auth0 application |
| `AUTH0_CLIENT_SECRET` | `your_client_secret` | From Auth0 application (keep secret!) |
| `AUTH0_AUDIENCE` | `https://api.pulseplay.ai` | Your Auth0 API identifier |
| `AUTH0_ISSUER_BASE_URL` | `https://dev-xxx.us.auth0.com` | Same as AUTH0_DOMAIN with https:// |
| `GEMINI_API_KEY` | `your_gemini_key` | Get from Google AI Studio |
| `NODE_ENV` | `production` | For production environment |
| `FRONTEND_URL` | `https://your-app.vercel.app` | Your Vercel deployment URL |

**Important:** Set these for **Production**, **Preview**, and **Development** environments.

### 5. Update Auth0 Settings

After your first deployment:

1. Copy your Vercel deployment URL (e.g., `https://pulseplay-ai.vercel.app`)
2. Go to [Auth0 Dashboard](https://manage.auth0.com/)
3. Navigate to **Applications** → Your App → **Settings**
4. Update these fields:

   - **Allowed Callback URLs**: 
     ```
     http://localhost:5173/callback,https://pulseplay-ai.vercel.app/callback
     ```
   
   - **Allowed Logout URLs**: 
     ```
     http://localhost:5173,https://pulseplay-ai.vercel.app
     ```
   
   - **Allowed Web Origins**: 
     ```
     http://localhost:5173,https://pulseplay-ai.vercel.app
     ```

5. Click **Save Changes**

### 6. Update FRONTEND_URL

After deployment:
1. Go to Vercel Dashboard → Your Project → **Settings** → **Environment Variables**
2. Update `FRONTEND_URL` to your actual deployment URL
3. Redeploy to apply changes

## Vercel Configuration Explained

The `vercel.json` file configures:

- **Frontend**: Vite React app builds to `dist/`
- **Backend**: Serverless function in `api/index.ts`
- **Routes**: `/api/*` goes to serverless function, everything else to frontend
- **CORS**: Configured for cross-origin requests

## Testing Your Deployment

### 1. Health Check
```bash
curl https://your-app.vercel.app/api/health
```

Expected response:
```json
{
  "status": "healthy",
  "timestamp": "2025-10-19T...",
  "environment": "production"
}
```

### 2. Frontend
Visit: `https://your-app.vercel.app`

### 3. Check Logs
- Go to Vercel Dashboard → Your Project → **Deployments** → Click latest deployment
- View **Function Logs** for any errors

## Common Issues & Solutions

### Issue: 500 Internal Server Error

**Solution:** Check environment variables are set correctly in Vercel dashboard.

```bash
# Verify locally first
npm run build
```

### Issue: MongoDB Connection Timeout

**Solutions:**
1. Verify MongoDB Atlas IP whitelist includes `0.0.0.0/0`
2. Check `MONGODB_URI` is correctly set in Vercel
3. Ensure MongoDB credentials are URL-encoded

### Issue: Auth0 Authentication Fails

**Solutions:**
1. Verify all Auth0 URLs include your Vercel domain
2. Check `AUTH0_AUDIENCE` matches your API identifier
3. Ensure `AUTH0_ISSUER_BASE_URL` includes `https://`

### Issue: CORS Errors

**Solution:** 
1. Update `FRONTEND_URL` environment variable in Vercel
2. Check Auth0 **Allowed Web Origins** includes your Vercel URL

### Issue: Build Fails

**Solutions:**
1. Check build logs in Vercel dashboard
2. Ensure TypeScript compiles locally: `npm run build`
3. Verify all dependencies are in `package.json`

## Local Development

To test before deploying:

```bash
# Install dependencies
npm install

# Build frontend
npm run build

# Test the build locally
npm run preview
```

## Monitoring & Logs

### View Logs
1. Vercel Dashboard → Your Project → **Deployments**
2. Click on a deployment
3. View **Function Logs** and **Build Logs**

### Performance
- Check **Analytics** tab in Vercel dashboard
- Monitor response times and error rates

## Next Steps

- [ ] Set up custom domain
- [ ] Configure automatic deployments on push
- [ ] Set up preview deployments for PRs
- [ ] Add error tracking (Sentry)
- [ ] Configure MongoDB backups
- [ ] Set up monitoring alerts

## Rollback

If something goes wrong:
1. Go to Vercel Dashboard → **Deployments**
2. Find a working deployment
3. Click **⋯** → **Promote to Production**

## Support

- **Vercel Docs**: https://vercel.com/docs
- **MongoDB Atlas**: https://www.mongodb.com/docs/atlas/
- **Auth0**: https://auth0.com/docs

---

**Deployment Checklist:**
- [ ] Code pushed to GitHub
- [ ] Vercel project created
- [ ] Environment variables configured
- [ ] Auth0 URLs updated
- [ ] Health check passes
- [ ] Frontend loads correctly
- [ ] Authentication works
- [ ] API endpoints respond
