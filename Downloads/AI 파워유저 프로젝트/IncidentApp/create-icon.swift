#!/usr/bin/env swift

import AppKit
import CoreGraphics

// 간단한 아이콘 생성 스크립트
func createAppIcon() {
    let iconSize = CGSize(width: 1024, height: 1024)
    
    // 이미지 생성
    let image = NSImage(size: iconSize)
    image.lockFocus()
    
    // 배경 그라데이션
    let gradient = NSGradient(colors: [
        NSColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0),
        NSColor(red: 0.1, green: 0.2, blue: 0.6, alpha: 1.0)
    ])!
    
    let rect = NSRect(origin: .zero, size: iconSize)
    gradient.draw(in: rect, angle: -45)
    
    // 경고 삼각형 그리기
    let trianglePath = NSBezierPath()
    let centerX = iconSize.width / 2
    let centerY = iconSize.height / 2
    let triangleSize: CGFloat = 400
    
    // 삼각형 좌표
    trianglePath.move(to: NSPoint(x: centerX, y: centerY + triangleSize/2))
    trianglePath.line(to: NSPoint(x: centerX - triangleSize/2, y: centerY - triangleSize/2))
    trianglePath.line(to: NSPoint(x: centerX + triangleSize/2, y: centerY - triangleSize/2))
    trianglePath.close()
    
    // 삼각형 채우기
    NSColor.white.setFill()
    trianglePath.fill()
    
    // 삼각형 테두리
    NSColor(white: 0.9, alpha: 1.0).setStroke()
    trianglePath.lineWidth = 20
    trianglePath.stroke()
    
    // 느낌표 그리기
    let exclamationColor = NSColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0)
    exclamationColor.setFill()
    
    // 느낌표 막대
    let exclamationRect = NSRect(
        x: centerX - 40,
        y: centerY - 120,
        width: 80,
        height: 180
    )
    NSBezierPath(roundedRect: exclamationRect, xRadius: 40, yRadius: 40).fill()
    
    // 느낌표 점
    let dotRect = NSRect(
        x: centerX - 40,
        y: centerY - 220,
        width: 80,
        height: 80
    )
    NSBezierPath(ovalIn: dotRect).fill()
    
    image.unlockFocus()
    
    // 아이콘셋 디렉토리 생성
    let iconsetPath = "AppIcon.iconset"
    try? FileManager.default.createDirectory(atPath: iconsetPath, withIntermediateDirectories: true)
    
    // 각 크기별 아이콘 생성
    let sizes = [16, 32, 64, 128, 256, 512, 1024]
    for size in sizes {
        // 일반 해상도
        if let resizedImage = resize(image: image, to: CGSize(width: size, height: size)) {
            let filename = size == 1024 ? "icon_512x512@2x.png" : "icon_\(size)x\(size).png"
            save(image: resizedImage, to: "\(iconsetPath)/\(filename)")
        }
        
        // 레티나 해상도 (512 이하만)
        if size <= 512 && size != 1024 {
            if let resizedImage = resize(image: image, to: CGSize(width: size * 2, height: size * 2)) {
                let filename = "icon_\(size)x\(size)@2x.png"
                save(image: resizedImage, to: "\(iconsetPath)/\(filename)")
            }
        }
    }
    
    print("✅ 아이콘셋 생성 완료: \(iconsetPath)")
    
    // iconutil을 사용하여 .icns 파일 생성
    let task = Process()
    task.launchPath = "/usr/bin/iconutil"
    task.arguments = ["-c", "icns", iconsetPath]
    task.launch()
    task.waitUntilExit()
    
    if task.terminationStatus == 0 {
        print("✅ AppIcon.icns 생성 완료")
        
        // 빌드 디렉토리가 있으면 복사
        let buildResourcesPath = "build/IncidentApp.app/Contents/Resources"
        if FileManager.default.fileExists(atPath: buildResourcesPath) {
            try? FileManager.default.copyItem(atPath: "AppIcon.icns", toPath: "\(buildResourcesPath)/AppIcon.icns")
            print("✅ 아이콘을 앱 번들에 복사했습니다")
        }
    } else {
        print("⚠️ iconutil 실행 실패")
    }
}

func resize(image: NSImage, to targetSize: CGSize) -> NSImage? {
    let newImage = NSImage(size: targetSize)
    newImage.lockFocus()
    
    image.draw(in: NSRect(origin: .zero, size: targetSize),
               from: NSRect(origin: .zero, size: image.size),
               operation: .copy,
               fraction: 1.0)
    
    newImage.unlockFocus()
    return newImage
}

func save(image: NSImage, to path: String) {
    guard let tiffData = image.tiffRepresentation,
          let bitmapRep = NSBitmapImageRep(data: tiffData),
          let pngData = bitmapRep.representation(using: .png, properties: [:]) else {
        return
    }
    
    try? pngData.write(to: URL(fileURLWithPath: path))
}

// 실행
createAppIcon()