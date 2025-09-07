#!/bin/bash

# 장애 처리 앱 빌드 스크립트

echo "🚀 장애 처리 앱 빌드 시작..."

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 프로젝트 루트 디렉토리
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$PROJECT_DIR/build"
APP_NAME="IncidentApp"

# 빌드 디렉토리 생성
echo "📁 빌드 디렉토리 준비..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# 릴리즈 빌드
echo "🔨 릴리즈 빌드 진행 중..."
swift build -c release --arch arm64

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ 빌드 실패${NC}"
    exit 1
fi

echo -e "${GREEN}✅ 빌드 성공${NC}"

# 앱 번들 생성
echo "📦 앱 번들 생성 중..."

APP_BUNDLE="$BUILD_DIR/$APP_NAME.app"
CONTENTS_DIR="$APP_BUNDLE/Contents"
MACOS_DIR="$CONTENTS_DIR/MacOS"
RESOURCES_DIR="$CONTENTS_DIR/Resources"

mkdir -p "$MACOS_DIR"
mkdir -p "$RESOURCES_DIR"

# 실행 파일 복사
cp ".build/arm64-apple-macosx/release/$APP_NAME" "$MACOS_DIR/"

# Info.plist 생성
cat > "$CONTENTS_DIR/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>$APP_NAME</string>
    <key>CFBundleIdentifier</key>
    <string>com.gsretail.incidentapp</string>
    <key>CFBundleName</key>
    <string>장애 처리</string>
    <key>CFBundleDisplayName</key>
    <string>장애 처리 앱</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSMinimumSystemVersion</key>
    <string>12.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>NSSupportsAutomaticGraphicsSwitching</key>
    <true/>
    <key>LSApplicationCategoryType</key>
    <string>public.app-category.productivity</string>
</dict>
</plist>
EOF

# 아이콘 생성 (간단한 기본 아이콘)
echo "🎨 기본 아이콘 생성 중..."
cat > "$RESOURCES_DIR/AppIcon.icns" << EOF
# 실제 아이콘 파일이 필요합니다
# 임시로 빈 파일 생성
EOF

# 실행 권한 설정
chmod +x "$MACOS_DIR/$APP_NAME"

echo -e "${GREEN}✨ 앱 번들 생성 완료!${NC}"
echo -e "${YELLOW}📍 앱 위치: $APP_BUNDLE${NC}"

# 앱 실행 옵션
echo ""
echo "앱을 실행하려면:"
echo "  1. Finder에서: open $APP_BUNDLE"
echo "  2. 터미널에서: $MACOS_DIR/$APP_NAME"
echo ""

# 앱 실행 여부 확인
read -p "지금 앱을 실행하시겠습니까? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🚀 앱 실행 중..."
    open "$APP_BUNDLE"
fi