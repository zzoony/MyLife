#!/bin/bash

# Create app bundle script for IncidentApp

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Creating IncidentApp bundles...${NC}"

# Function to create app bundle
create_app_bundle() {
    local ARCH=$1
    local BINARY_PATH=$2
    local APP_NAME="IncidentApp-${ARCH}.app"
    local APP_PATH="Release/${APP_NAME}"
    
    echo -e "${YELLOW}Creating ${APP_NAME}...${NC}"
    
    # Remove existing app bundle if exists
    rm -rf "${APP_PATH}"
    
    # Create app bundle structure
    mkdir -p "${APP_PATH}/Contents/MacOS"
    mkdir -p "${APP_PATH}/Contents/Resources"
    
    # Copy binary
    cp "${BINARY_PATH}" "${APP_PATH}/Contents/MacOS/IncidentApp"
    chmod +x "${APP_PATH}/Contents/MacOS/IncidentApp"
    
    # Create Info.plist
    cat > "${APP_PATH}/Contents/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>IncidentApp</string>
    <key>CFBundleIdentifier</key>
    <string>com.gsretail.incidentapp</string>
    <key>CFBundleName</key>
    <string>IncidentApp</string>
    <key>CFBundleDisplayName</key>
    <string>Incident App</string>
    <key>CFBundleVersion</key>
    <string>1.0.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>LSMinimumSystemVersion</key>
    <string>12.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>NSSupportsAutomaticGraphicsSwitching</key>
    <true/>
    <key>CFBundleIconFile</key>
    <string>AppIcon</string>
    <key>NSMainNibFile</key>
    <string>MainMenu</string>
    <key>NSPrincipalClass</key>
    <string>NSApplication</string>
</dict>
</plist>
EOF
    
    # Create PkgInfo file
    echo "APPL????" > "${APP_PATH}/Contents/PkgInfo"
    
    # Copy icon if exists
    if [ -f "Resources/AppIcon.icns" ]; then
        cp "Resources/AppIcon.icns" "${APP_PATH}/Contents/Resources/"
    fi
    
    echo -e "${GREEN}✓ Created ${APP_NAME}${NC}"
    
    # Get file size
    SIZE=$(du -sh "${APP_PATH}" | cut -f1)
    echo -e "  Size: ${SIZE}"
    
    # Verify architecture
    echo -e "  Architecture: $(file "${APP_PATH}/Contents/MacOS/IncidentApp" | cut -d: -f2)"
}

# Build and create ARM64 (Apple Silicon) version
echo -e "\n${YELLOW}Building ARM64 (Apple Silicon) version...${NC}"
swift build -c release --arch arm64
if [ $? -eq 0 ]; then
    create_app_bundle "arm64" ".build/arm64-apple-macosx/release/IncidentApp"
else
    echo -e "${RED}Failed to build ARM64 version${NC}"
fi

# Build and create x86_64 (Intel) version
echo -e "\n${YELLOW}Building x86_64 (Intel) version...${NC}"
swift build -c release --arch x86_64
if [ $? -eq 0 ]; then
    create_app_bundle "x86_64" ".build/x86_64-apple-macosx/release/IncidentApp"
else
    echo -e "${RED}Failed to build x86_64 version${NC}"
fi

# Create universal binary version
echo -e "\n${YELLOW}Creating Universal (ARM64 + x86_64) version...${NC}"
if [ -f ".build/arm64-apple-macosx/release/IncidentApp" ] && [ -f ".build/x86_64-apple-macosx/release/IncidentApp" ]; then
    mkdir -p ".build/universal"
    lipo -create \
        ".build/arm64-apple-macosx/release/IncidentApp" \
        ".build/x86_64-apple-macosx/release/IncidentApp" \
        -output ".build/universal/IncidentApp"
    
    if [ $? -eq 0 ]; then
        create_app_bundle "Universal" ".build/universal/IncidentApp"
    else
        echo -e "${RED}Failed to create universal binary${NC}"
    fi
fi

echo -e "\n${GREEN}Build complete!${NC}"
echo -e "Applications created in Release/ directory:"
ls -la Release/*.app 2>/dev/null | awk '{print "  - " $9 " (" $5 " bytes)"}'

echo -e "\n${YELLOW}To run an app:${NC}"
echo "  open Release/IncidentApp-arm64.app    # For Apple Silicon Macs"
echo "  open Release/IncidentApp-x86_64.app   # For Intel Macs"
echo "  open Release/IncidentApp-Universal.app # Works on both"