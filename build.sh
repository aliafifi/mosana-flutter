#!/bin/bash
set -e

echo "🚀 Installing Flutter..."

# Install Flutter
if [ ! -d "flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable --depth 1
fi

export PATH="$PATH:`pwd`/flutter/bin"

# Enable web
flutter config --enable-web

# Get dependencies
cd mosana_flutter
flutter pub get

# Build web
flutter build web --release --web-renderer canvaskit

echo "✅ Flutter web build complete!"
