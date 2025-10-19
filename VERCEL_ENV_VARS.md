# Vercel Environment Variables Setup

This file documents all environment variables needed for Vercel deployment.

## Frontend Environment Variables

These are **build-time** variables prefixed with `VITE_` for Vite:

| Variable | Example | Description |
|----------|---------|-------------|
| `VITE_AUTH0_DOMAIN` | `dev-abc123.us.auth0.com` | Your Auth0 domain |
| `VITE_AUTH0_CLIENT_ID` | `abcdefghij1234567890` | Your Auth0 client ID |
| `VITE_AUTH0_AUDIENCE` | `https://api.pulseplay.ai` | Your Auth0 API identifier |
| `VITE_API_URL` | `https://your-app.vercel.app/api` | Your backend API URL |

### Setting Frontend Variables in Vercel

1. Go to your Vercel project → **Settings** → **Environment Variables**
2. Add each variable for **Production**, **Preview**, and **Development**
3. After deployment, update `VITE_API_URL` to: `https://your-actual-domain.vercel.app/api`

**⚠️ Important:** Frontend environment variables are **publicly visible** in the browser bundle. Never put secrets here!

## Backend Environment Variables

These are **runtime** variables for the serverless API:

| Variable | Example | Description |
|----------|---------|-------------|
| `MONGODB_URI` | `mongodb+srv://user:pass@...` | MongoDB connection string |
| `AUTH0_DOMAIN` | `dev-abc123.us.auth0.com` | Auth0 domain (backend) |
| `AUTH0_CLIENT_ID` | `abcdefghij1234567890` | Auth0 client ID |
| `AUTH0_CLIENT_SECRET` | `secret_key_here` | Auth0 client secret (keep secure!) |
| `AUTH0_AUDIENCE` | `https://api.pulseplay.ai` | Auth0 API identifier |
| `AUTH0_ISSUER_BASE_URL` | `https://dev-abc123.us.auth0.com` | Full Auth0 issuer URL |
| `GEMINI_API_KEY` | `AIza...` | Google Gemini API key |
| `NODE_ENV` | `production` | Environment mode |
| `FRONTEND_URL` | `https://your-app.vercel.app` | Frontend URL for CORS |

### Setting Backend Variables in Vercel

1. Go to your Vercel project → **Settings** → **Environment Variables**
2. Add each variable
3. Set for **Production**, **Preview**, and **Development** environments
4. Click **Save**

**🔒 Security:** Backend variables are encrypted and never exposed to the client.

## Quick Setup Commands

### For Production Deployment

After creating your Vercel project, set all variables at once using Vercel CLI:

```bash
# Install Vercel CLI
npm i -g vercel

# Login
vercel login

# Link to your project
vercel link

# Set environment variables
vercel env add VITE_AUTH0_DOMAIN production
vercel env add VITE_AUTH0_CLIENT_ID production
vercel env add VITE_AUTH0_AUDIENCE production
vercel env add VITE_API_URL production
vercel env add MONGODB_URI production
vercel env add AUTH0_DOMAIN production
vercel env add AUTH0_CLIENT_ID production
vercel env add AUTH0_CLIENT_SECRET production
vercel env add AUTH0_AUDIENCE production
vercel env add AUTH0_ISSUER_BASE_URL production
vercel env add GEMINI_API_KEY production
vercel env add NODE_ENV production
vercel env add FRONTEND_URL production
```

Enter the value when prompted for each variable.

## Environment-Specific Values

### Local Development
- `VITE_API_URL`: `http://localhost:3000/api`
- `FRONTEND_URL`: `http://localhost:5173`
- `NODE_ENV`: `development`

### Vercel Production
- `VITE_API_URL`: `https://your-app.vercel.app/api`
- `FRONTEND_URL`: `https://your-app.vercel.app`
- `NODE_ENV`: `production`

### Vercel Preview (PR deployments)
- `VITE_API_URL`: Use production API or separate staging API
- `FRONTEND_URL`: Auto-generated preview URL
- `NODE_ENV`: `production`

## Updating Environment Variables

### Method 1: Vercel Dashboard
1. Go to **Settings** → **Environment Variables**
2. Click the variable to edit
3. Update the value
4. Click **Save**
5. **Redeploy** to apply changes

### Method 2: Vercel CLI
```bash
# Update a variable
vercel env rm VARIABLE_NAME production
vercel env add VARIABLE_NAME production

# Pull environment variables to local
vercel env pull .env.local
```

## Verification

After setting all variables:

1. **Check Build**: Ensure build succeeds in Vercel deployment logs
2. **Test API**: Visit `https://your-app.vercel.app/api/health`
3. **Test Frontend**: Open your app and check browser console for errors
4. **Test Auth**: Try logging in

## Common Mistakes

❌ **Forgetting `VITE_` prefix for frontend variables**
- ✅ Solution: Frontend vars MUST start with `VITE_`

❌ **Using wrong API URL**
- ✅ Solution: `VITE_API_URL` should be `/api` (relative) or full domain

❌ **Not setting variables for all environments**
- ✅ Solution: Set for Production, Preview, AND Development

❌ **Exposing secrets in frontend variables**
- ✅ Solution: Never put API keys, secrets, or passwords in `VITE_*` vars

❌ **Forgetting to redeploy after changing variables**
- ✅ Solution: Always redeploy after updating env vars

## Security Best Practices

1. **Never commit `.env` files** - Use `.env.example` as template
2. **Rotate secrets regularly** - Update API keys and secrets periodically
3. **Use different values per environment** - Don't reuse production secrets in development
4. **Restrict MongoDB IP whitelist** - For production, limit to Vercel IPs
5. **Enable Auth0 MFA** - Add extra security layer
6. **Monitor usage** - Check Vercel logs for suspicious activity

## Troubleshooting

### Frontend can't connect to API
- Check `VITE_API_URL` is set correctly
- Verify CORS configuration in backend
- Check browser console for CORS errors

### MongoDB connection fails
- Verify `MONGODB_URI` is correct and URL-encoded
- Check MongoDB Atlas IP whitelist
- Test connection string locally first

### Auth0 authentication fails
- Verify all Auth0 URLs are updated with Vercel domain
- Check `AUTH0_AUDIENCE` matches your API identifier
- Ensure callback URLs are whitelisted in Auth0

### Build fails with "Cannot find module"
- Check all dependencies are in `package.json`
- Verify `node_modules` isn't in `.vercelignore`
- Try `npm install` locally to test

---

**Next:** See [VERCEL_SETUP.md](./VERCEL_SETUP.md) for deployment instructions.
