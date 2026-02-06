# 🚀 Mosana Flutter - Vercel Deployment Guide

## Automatic Deployment Setup

This repository is configured for automatic deployment to Vercel.

### Quick Start

1. **Connect to Vercel** (if not already connected):
   - Go to https://vercel.com
   - Import project: `aliafifi/mosana-flutter`
   - Vercel will auto-detect `vercel.json` configuration

2. **Automatic Deployments**:
   - Every push to `main` → Production deployment
   - Every PR → Preview deployment
   - Build time: ~5-7 minutes

3. **Preview URLs**:
   - Production: `https://mosana-flutter.vercel.app`
   - Or custom domain: `https://app.mosana.xyz`

### Build Configuration

The `vercel.json` is already configured with:
- ✅ Flutter web build command
- ✅ CanvasKit renderer (better performance)
- ✅ CORS headers
- ✅ SPA routing (all routes → index.html)
- ✅ Automatic Flutter SDK installation

### Manual Deployment

If you want to deploy manually:

```bash
# Install Vercel CLI
npm install -g vercel

# Login
vercel login

# Deploy
vercel --prod
```

### Environment Variables

Add these in Vercel dashboard (Settings → Environment Variables):

```
API_BASE_URL=https://api.mosana.xyz
WS_URL=wss://api.mosana.xyz/notifications
FIREBASE_PROJECT_ID=mosana-9586f
```

### Troubleshooting

**Build fails?**
- Check Vercel build logs
- Ensure all dependencies are in `pubspec.yaml`
- Verify Flutter version compatibility

**404 on routes?**
- Check `vercel.json` rewrites are configured
- Ensure using hash or browser router

**Slow loading?**
- Using CanvasKit renderer (best quality)
- First load is ~3MB (cached after)
- Consider adding loading screen

### Development

```bash
# Run locally
cd mosana_flutter
flutter run -d chrome
```

### Notes

- This is for **preview/testing** only (not production)
- Mock data is used (no real API calls yet)
- All screens are UI-only for design review
- Once design approved, we'll connect real API

---

**Status**: ✅ Configured for auto-deployment  
**Next**: Push to GitHub → Vercel builds automatically  
**Preview**: Available in ~5 minutes after push
