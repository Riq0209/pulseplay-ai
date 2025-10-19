# 🔍 Find Your Credentials Checklist

Follow this guide step-by-step to gather all the values you need.

## ✅ STEP 1: Get Auth0 Credentials

### 1.1 Go to Auth0 Dashboard
👉 Open: https://manage.auth0.com/

### 1.2 Navigate to Your Application
- Click **"Applications"** in the left sidebar
- Click **"Applications"** again
- Find and click **"PulsePlay AI"** (or whatever you named it)

### 1.3 Copy These Values from the Settings Tab:

| What to Find | Where | Write Value Here |
|-------------|--------|------------------|
| **Domain** | Near the top, labeled "Domain" | _________________________ |
| **Client ID** | Below Domain, labeled "Client ID" | _________________________ |
| **Client Secret** | Below Client ID, click "Show" | _________________________ |

### 1.4 Get Your API Audience
- Click **"Applications"** in left sidebar
- Click **"APIs"** 
- Click your API (e.g., "PulsePlay AI API")
- Copy the **"Identifier"**

| What to Find | Write Value Here |
|-------------|------------------|
| **API Identifier (Audience)** | _________________________ |

---

## ✅ STEP 2: Get MongoDB Connection String

### 2.1 Go to MongoDB Atlas
👉 Open: https://cloud.mongodb.com/

### 2.2 Get Connection String
- Click **"Database"** in left sidebar
- Click **"Connect"** button on your cluster
- Choose **"Connect your application"**
- Select **Driver: Node.js** and **Version: 5.5 or later**
- Copy the connection string
- Replace `<username>` with your database username
- Replace `<password>` with your database password
- Add `/pulseplay` before the `?` 

| What to Find | Write Value Here |
|-------------|------------------|
| **MongoDB URI** | mongodb+srv://_________________________ |

**Example format:**
```
mongodb+srv://myuser:mypassword@cluster0.xxxxx.mongodb.net/pulseplay?retryWrites=true&w=majority
```

---

## ✅ STEP 3: Get Google Gemini API Key

### 3.1 Go to Google AI Studio
👉 Open: https://makersuite.google.com/app/apikey

### 3.2 Create/Copy API Key
- Click **"Create API Key"** (or copy existing one)
- Copy the key (starts with `AIza...`)

| What to Find | Write Value Here |
|-------------|------------------|
| **Gemini API Key** | AIza_________________________ |

---

## 📋 COMPLETE LIST - Ready to Enter in Vercel

Once you've gathered all values above, enter them in Vercel:

### Frontend Variables:
```
KEY: VITE_AUTH0_DOMAIN
VALUE: [Paste Domain from Step 1.3]

KEY: VITE_AUTH0_CLIENT_ID
VALUE: [Paste Client ID from Step 1.3]

KEY: VITE_AUTH0_AUDIENCE
VALUE: [Paste API Identifier from Step 1.4]

KEY: VITE_API_URL
VALUE: /api
```

### Backend Variables:
```
KEY: MONGODB_URI
VALUE: [Paste MongoDB URI from Step 2.2]

KEY: AUTH0_DOMAIN
VALUE: [Same as VITE_AUTH0_DOMAIN]

KEY: AUTH0_CLIENT_ID
VALUE: [Same as VITE_AUTH0_CLIENT_ID]

KEY: AUTH0_CLIENT_SECRET
VALUE: [Paste Client Secret from Step 1.3]

KEY: AUTH0_AUDIENCE
VALUE: [Same as VITE_AUTH0_AUDIENCE]

KEY: AUTH0_ISSUER_BASE_URL
VALUE: https://[Paste Domain from Step 1.3]

KEY: GEMINI_API_KEY
VALUE: [Paste Gemini API Key from Step 3.2]

KEY: NODE_ENV
VALUE: production

KEY: FRONTEND_URL
VALUE: https://pulseplay-9dfet3xr4-riqs-projects-b33d2584.vercel.app
```

---

## 🎯 After You Have All Values:

1. ✅ Go back to Vercel environment variables page
2. ✅ Enter each KEY and VALUE pair
3. ✅ Keep "All Environments" selected
4. ✅ Click "Save" when done
5. ✅ Redeploy your app

---

## ⚠️ Troubleshooting:

**Can't find Auth0 Application?**
- You might need to create one: Applications → Create Application → Single Page Web App

**Can't find MongoDB cluster?**
- You might need to create one: Database → Build a Database → FREE M0 tier

**Don't have Gemini API Key?**
- Sign in with Google account at: https://makersuite.google.com/app/apikey

---

**Need help with any specific step? Let me know which one!**
