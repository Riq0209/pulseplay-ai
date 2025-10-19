# Vercel Environment Variables Setup Script
# This script helps you add all required environment variables to Vercel

Write-Host "🚀 Vercel Environment Variables Setup" -ForegroundColor Cyan
Write-Host "======================================`n" -ForegroundColor Cyan

Write-Host "This script will guide you through adding environment variables to Vercel.`n" -ForegroundColor Yellow

# Prompt for values
Write-Host "📝 Please enter your configuration values:`n" -ForegroundColor Green

$AUTH0_DOMAIN = Read-Host "Auth0 Domain (e.g., dev-abc123.us.auth0.com)"
$AUTH0_CLIENT_ID = Read-Host "Auth0 Client ID"
$AUTH0_CLIENT_SECRET = Read-Host "Auth0 Client Secret" -MaskInput
$AUTH0_AUDIENCE = Read-Host "Auth0 Audience (e.g., https://api.pulseplay.ai)"
$MONGODB_URI = Read-Host "MongoDB URI" -MaskInput
$GEMINI_API_KEY = Read-Host "Gemini API Key" -MaskInput
$VERCEL_URL = Read-Host "Your Vercel URL (e.g., pulseplay-9dfet3xr4-riqs-projects-b33d2584.vercel.app)"

Write-Host "`n🔧 Setting environment variables in Vercel..." -ForegroundColor Cyan

# Frontend variables (build-time)
Write-Host "`n📦 Adding Frontend Variables..." -ForegroundColor Yellow
vercel env add VITE_AUTH0_DOMAIN production --force
Write-Output $AUTH0_DOMAIN | vercel env add VITE_AUTH0_DOMAIN production

vercel env add VITE_AUTH0_CLIENT_ID production --force
Write-Output $AUTH0_CLIENT_ID | vercel env add VITE_AUTH0_CLIENT_ID production

vercel env add VITE_AUTH0_AUDIENCE production --force
Write-Output $AUTH0_AUDIENCE | vercel env add VITE_AUTH0_AUDIENCE production

vercel env add VITE_API_URL production --force
Write-Output "/api" | vercel env add VITE_API_URL production

# Backend variables (runtime)
Write-Host "`n🔐 Adding Backend Variables..." -ForegroundColor Yellow
vercel env add MONGODB_URI production --force
Write-Output $MONGODB_URI | vercel env add MONGODB_URI production

vercel env add AUTH0_DOMAIN production --force
Write-Output $AUTH0_DOMAIN | vercel env add AUTH0_DOMAIN production

vercel env add AUTH0_CLIENT_ID production --force
Write-Output $AUTH0_CLIENT_ID | vercel env add AUTH0_CLIENT_ID production

vercel env add AUTH0_CLIENT_SECRET production --force
Write-Output $AUTH0_CLIENT_SECRET | vercel env add AUTH0_CLIENT_SECRET production

vercel env add AUTH0_AUDIENCE production --force
Write-Output $AUTH0_AUDIENCE | vercel env add AUTH0_AUDIENCE production

vercel env add AUTH0_ISSUER_BASE_URL production --force
Write-Output "https://$AUTH0_DOMAIN" | vercel env add AUTH0_ISSUER_BASE_URL production

vercel env add GEMINI_API_KEY production --force
Write-Output $GEMINI_API_KEY | vercel env add GEMINI_API_KEY production

vercel env add NODE_ENV production --force
Write-Output "production" | vercel env add NODE_ENV production

vercel env add FRONTEND_URL production --force
Write-Output "https://$VERCEL_URL" | vercel env add FRONTEND_URL production

Write-Host "`n✅ Environment variables added successfully!" -ForegroundColor Green
Write-Host "`n🔄 Now redeploying your app..." -ForegroundColor Cyan
vercel --prod

Write-Host "`n✨ Done! Your app should now work correctly." -ForegroundColor Green
Write-Host "`n⚠️  Don't forget to update Auth0 URLs!" -ForegroundColor Yellow
Write-Host "   Add this to Auth0 Allowed Callback URLs:" -ForegroundColor White
Write-Host "   https://$VERCEL_URL, https://$VERCEL_URL/callback" -ForegroundColor Cyan
