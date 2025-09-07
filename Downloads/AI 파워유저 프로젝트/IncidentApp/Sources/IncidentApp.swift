import SwiftUI
import AppKit

@main
struct IncidentApp: App {
    init() {
        // 앱 시작 시 포커스 설정
        DispatchQueue.main.async {
            NSApp.setActivationPolicy(.regular)
            NSApp.activate(ignoringOtherApps: true)
            
            // 앱 창을 최전면으로
            if let window = NSApp.windows.first {
                window.makeKeyAndOrderFront(nil)
                window.level = .floating
                
                // 0.5초 후 일반 레벨로 복원
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    window.level = .normal
                }
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 500, idealWidth: 500, maxWidth: 600,
                       minHeight: 450, idealHeight: 450, maxHeight: 500)
                .onAppear {
                    // 창이 나타날 때 포커스 설정
                    NSApp.activate(ignoringOtherApps: true)
                    if let window = NSApp.windows.first {
                        window.makeKeyAndOrderFront(nil)
                    }
                }
        }
        .windowStyle(.hiddenTitleBar)
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button("장애 처리 앱 정보") {
                    showAboutPanel()
                }
            }
        }
    }
    
    private func showAboutPanel() {
        let alert = NSAlert()
        alert.messageText = "장애 처리 MVP 앱"
        alert.informativeText = "버전 1.0.0\n\n장애 등록 및 처리를 위한 macOS 앱"
        alert.alertStyle = .informational
        alert.addButton(withTitle: "확인")
        alert.runModal()
    }
}