#!/bin/bash

# 장애 처리 앱 실행 스크립트

echo "🚀 장애 처리 앱 실행 준비..."

# 빌드 확인
if [ ! -f ".build/debug/IncidentApp" ]; then
    echo "🔨 앱을 먼저 빌드합니다..."
    swift build
    
    if [ $? -ne 0 ]; then
        echo "❌ 빌드 실패"
        exit 1
    fi
fi

echo "✅ 앱 실행 중..."
swift run