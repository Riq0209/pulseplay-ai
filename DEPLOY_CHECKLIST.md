# 🚀 Quick Vercel Deployment Checklist

Copy this checklist and mark off items as you complete them!

## Pre-Deployment Setup

### MongoDB Atlas
- [ ] Create free M0 cluster
- [ ] Create database user (username + password)
- [ ] Whitelist IP: `0.0.0.0/0` (all IPs)
- [ ] Get connection string
- [ ] Add database name `pulseplay` to connection string

### Auth0
- [ ] Create Single Page Application
- [ ] Create API (identifier: `https://api.pulseplay.ai`)
- [ ] Get Domain, Client ID, Client Secret, Audience
- [ ] Set callback URLs: `http://localhost:5173/callback,https://YOUR_DOMAIN.vercel.app/callback`
- [ ] Set logout URLs: `http://localhost:5173,https://YOUR_DOMAIN.vercel.app`
- [ ] Set web origins: `http://localhost:5173,https://YOUR_DOMAIN.vercel.app`

### Google Gemini
- [ ] Get API key from [Google AI Studio](https://makersuite.google.com/app/apikey)

## Deployment Steps

### 1. Push to GitHub
```bash
git add .
git commit -m "Configure Vercel deployment"
git push origin main
```
- [ ] Code pushed to GitHub

### 2. Create Vercel Project
- [ ] Go to [vercel.com/new](https://vercel.com/new)
- [ ] Import your GitHub repository
- [ ] Vercel auto-detects settings (don't change!)

### 3. Add Environment Variables
Go to project Settings → Environment Variables:

#### Frontend Variables (Build-time)
- [ ] `VITE_AUTH0_DOMAIN` = `dev-xxx.us.auth0.com`
- [ ] `VITE_AUTH0_CLIENT_ID` = `your_client_id`
- [ ] `VITE_AUTH0_AUDIENCE` = `https://api.pulseplay.ai`
- [ ] `VITE_API_URL` = `/api` (relative path)

#### Backend Variables (Runtime)
- [ ] `MONGODB_URI` = `mongodb+srv://...`
- [ ] `AUTH0_DOMAIN` = `dev-xxx.us.auth0.com`
- [ ] `AUTH0_CLIENT_ID` = `your_client_id`
- [ ] `AUTH0_CLIENT_SECRET` = `your_client_secret`
- [ ] `AUTH0_AUDIENCE` = `https://api.pulseplay.ai`
- [ ] `AUTH0_ISSUER_BASE_URL` = `https://dev-xxx.us.auth0.com`
- [ ] `GEMINI_API_KEY` = `your_gemini_key`
- [ ] `NODE_ENV` = `production`
- [ ] `FRONTEND_URL` = `https://YOUR_DOMAIN.vercel.app`

**Set all for: Production, Preview, Development**

### 4. Deploy
- [ ] Click "Deploy" button
- [ ] Wait for build to complete (~2-3 minutes)
- [ ] Copy your Vercel URL

### 5. Update Auth0 (IMPORTANT!)
- [ ] Go to Auth0 Dashboard → Your App → Settings
- [ ] Update Allowed Callback URLs with Vercel URL
- [ ] Update Allowed Logout URLs with Vercel URL
- [ ] Update Allowed Web Origins with Vercel URL
- [ ] Save Changes

### 6. Update Environment Variables
- [ ] Go back to Vercel → Settings → Environment Variables
- [ ] Update `FRONTEND_URL` with actual Vercel URL
- [ ] Redeploy (Deployments → Click ⋯ → Redeploy)

## Testing

### Health Check
```bash
curl https://YOUR_DOMAIN.vercel.app/api/health
```
- [ ] Returns `{"status":"healthy"}`

### Frontend
- [ ] Visit `https://YOUR_DOMAIN.vercel.app`
- [ ] App loads without errors
- [ ] No console errors in browser

### Authentication
- [ ] Click "Sign In" button
- [ ] Auth0 login page appears
- [ ] Can log in successfully
- [ ] Redirected back to app
- [ ] User profile shows

### API
- [ ] Try creating a focus session
- [ ] Session saves to database
- [ ] Can view session history

## Troubleshooting

### Build Fails
- [ ] Check build logs in Vercel
- [ ] Run `npm run build` locally
- [ ] Check all dependencies in package.json

### 500 Error
- [ ] Check Function Logs in Vercel
- [ ] Verify all environment variables set
- [ ] Check MongoDB connection string

### Auth Error
- [ ] Verify Auth0 URLs include Vercel domain
- [ ] Check AUTH0_AUDIENCE matches API identifier
- [ ] Ensure callback URLs are correct

### CORS Error
- [ ] Update FRONTEND_URL in Vercel
- [ ] Check Auth0 web origins
- [ ] Verify API routes in vercel.json

## Post-Deployment (Optional)

- [ ] Set up custom domain
- [ ] Enable automatic deployments
- [ ] Set up preview deployments for PRs
- [ ] Configure MongoDB backups
- [ ] Add error tracking (Sentry)
- [ ] Set up monitoring

## Quick Commands

```bash
# Install Vercel CLI
npm i -g vercel

# Login
vercel login

# Deploy
vercel --prod

# View logs
vercel logs YOUR_DOMAIN.vercel.app

# Pull env vars locally
vercel env pull
```

## Important URLs

- **Vercel Dashboard**: https://vercel.com/dashboard
- **MongoDB Atlas**: https://cloud.mongodb.com/
- **Auth0 Dashboard**: https://manage.auth0.com/
- **Google AI Studio**: https://makersuite.google.com/

## Need Help?

See detailed guides:
- **VERCEL_SETUP.md** - Step-by-step deployment
- **VERCEL_ENV_VARS.md** - Environment variables
- **VERCEL_CHANGES.md** - What was changed

---

**Total Time**: ~15-20 minutes

✅ All done? Congratulations! Your app is live! 🎉
