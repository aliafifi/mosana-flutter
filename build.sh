#!/bin/bash
set -e

echo "🚀 Starting Flutter build for Cloudflare Pages..."

# Clone Flutter stable branch
if [ ! -d "flutter" ]; then
  echo "📦 Downloading Flutter SDK (this takes a few minutes)..."
  git clone https://github.com/flutter/flutter.git -b stable --depth 1
fi

# Add Flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Disable analytics and telemetry
flutter config --no-analytics 2>&1 | head -1

# Check Flutter version
echo ""
echo "🔍 Flutter version:"
flutter --version

# Enable web platform
echo ""
echo "🌐 Enabling Flutter web..."
flutter config --enable-web

# Navigate to Flutter project
cd mosana_flutter

# Clean previous builds
echo ""
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies (with --no-pub flag to avoid warnings)
echo ""
echo "📦 Getting dependencies..."
flutter pub get

# Build for web (using auto renderer for compatibility)
echo ""
echo "🔨 Building Flutter web app..."
echo "⏱️  This will take 3-5 minutes..."
flutter build web --release

echo ""
echo "✅ Build complete!"
echo "📁 Output directory: mosana_flutter/build/web"
echo "🎉 Your app is ready to deploy!"
