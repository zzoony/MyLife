#!/bin/bash

# 장애 처리 앱 - macOS 앱 번들 생성 스크립트

set -e  # 오류 발생 시 즉시 중단

echo "🚀 장애 처리 앱 번들 생성 시작..."

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 프로젝트 설정
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$PROJECT_DIR/build"
APP_NAME="IncidentApp"
APP_DISPLAY_NAME="장애 처리"
BUNDLE_ID="com.gsretail.incidentapp"
VERSION="1.0.0"
BUILD_NUMBER="1"

# 아키텍처 감지
ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
    SWIFT_ARCH="arm64-apple-macosx"
    echo -e "${BLUE}ℹ️  Apple Silicon (M1/M2) 감지됨${NC}"
else
    SWIFT_ARCH="x86_64-apple-macosx"
    echo -e "${BLUE}ℹ️  Intel Mac 감지됨${NC}"
fi

# 클린 빌드
echo -e "${YELLOW}🧹 이전 빌드 정리...${NC}"
rm -rf "$BUILD_DIR"
rm -rf .build
mkdir -p "$BUILD_DIR"

# 릴리즈 빌드
echo -e "${YELLOW}🔨 릴리즈 빌드 진행 중...${NC}"
swift build -c release --arch $ARCH

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ 빌드 실패${NC}"
    exit 1
fi

echo -e "${GREEN}✅ 빌드 성공${NC}"

# 앱 번들 구조 생성
echo -e "${YELLOW}📦 앱 번들 생성 중...${NC}"

APP_BUNDLE="$BUILD_DIR/$APP_NAME.app"
CONTENTS_DIR="$APP_BUNDLE/Contents"
MACOS_DIR="$CONTENTS_DIR/MacOS"
RESOURCES_DIR="$CONTENTS_DIR/Resources"

mkdir -p "$MACOS_DIR"
mkdir -p "$RESOURCES_DIR"

# 실행 파일 복사
echo "  실행 파일 복사..."
cp ".build/$SWIFT_ARCH/release/$APP_NAME" "$MACOS_DIR/"

# 실행 권한 설정
chmod +x "$MACOS_DIR/$APP_NAME"

# Info.plist 생성
echo "  Info.plist 생성..."
cat > "$CONTENTS_DIR/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>$APP_NAME</string>
    <key>CFBundleIdentifier</key>
    <string>$BUNDLE_ID</string>
    <key>CFBundleName</key>
    <string>$APP_DISPLAY_NAME</string>
    <key>CFBundleDisplayName</key>
    <string>$APP_DISPLAY_NAME</string>
    <key>CFBundleShortVersionString</key>
    <string>$VERSION</string>
    <key>CFBundleVersion</key>
    <string>$BUILD_NUMBER</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleSignature</key>
    <string>????</string>
    <key>LSMinimumSystemVersion</key>
    <string>12.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>NSSupportsAutomaticGraphicsSwitching</key>
    <true/>
    <key>LSApplicationCategoryType</key>
    <string>public.app-category.productivity</string>
    <key>NSHumanReadableCopyright</key>
    <string>Copyright © 2024 GS Retail. All rights reserved.</string>
    <key>CFBundleIconFile</key>
    <string>AppIcon</string>
    <key>NSMainNibFile</key>
    <string>MainMenu</string>
    <key>NSPrincipalClass</key>
    <string>NSApplication</string>
    <key>LSUIElement</key>
    <false/>
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
</dict>
</plist>
EOF

# PkgInfo 파일 생성
echo "APPL????" > "$CONTENTS_DIR/PkgInfo"

# 코드 서명 (가능한 경우)
if command -v codesign &> /dev/null; then
    echo -e "${YELLOW}🔏 코드 서명 중...${NC}"
    codesign --force --deep --sign - "$APP_BUNDLE"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ 코드 서명 완료${NC}"
    else
        echo -e "${YELLOW}⚠️  코드 서명 실패 (앱은 실행 가능)${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  codesign 도구를 찾을 수 없음 (서명 건너뜀)${NC}"
fi

# 앱 번들 검증
echo -e "${YELLOW}🔍 앱 번들 검증...${NC}"
if [ -f "$MACOS_DIR/$APP_NAME" ]; then
    echo -e "${GREEN}✅ 실행 파일 확인${NC}"
else
    echo -e "${RED}❌ 실행 파일 없음${NC}"
    exit 1
fi

# 완료 메시지
echo ""
echo -e "${GREEN}🎉 앱 번들 생성 완료!${NC}"
echo -e "${BLUE}📍 앱 위치: $APP_BUNDLE${NC}"
echo ""
echo "사용 방법:"
echo "  1. Finder에서 Applications 폴더로 드래그"
echo "  2. 또는 바로 실행: open \"$APP_BUNDLE\""
echo ""

# Applications 폴더로 복사 옵션
read -p "Applications 폴더로 설치하시겠습니까? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}📋 Applications 폴더로 복사 중...${NC}"
    
    # 기존 앱이 있으면 백업
    if [ -d "/Applications/$APP_NAME.app" ]; then
        echo "  기존 앱을 백업합니다..."
        mv "/Applications/$APP_NAME.app" "/Applications/$APP_NAME.app.backup"
    fi
    
    # 앱 복사
    cp -R "$APP_BUNDLE" "/Applications/"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ 설치 완료!${NC}"
        echo ""
        
        # 앱 실행 옵션
        read -p "지금 앱을 실행하시겠습니까? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${BLUE}🚀 앱 실행 중...${NC}"
            open "/Applications/$APP_NAME.app"
        fi
    else
        echo -e "${RED}❌ 설치 실패 (관리자 권한이 필요할 수 있습니다)${NC}"
        echo "수동으로 설치하려면:"
        echo "  sudo cp -R \"$APP_BUNDLE\" /Applications/"
    fi
else
    echo ""
    echo "수동 설치 방법:"
    echo "  1. Finder에서: open \"$BUILD_DIR\""
    echo "  2. $APP_NAME.app을 Applications 폴더로 드래그"
fi