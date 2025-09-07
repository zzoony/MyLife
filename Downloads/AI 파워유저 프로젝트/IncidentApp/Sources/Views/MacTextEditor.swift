import SwiftUI
import AppKit

// NSTextView를 래핑한 커스텀 텍스트 에디터 (한글 입력 지원)
struct MacTextEditor: NSViewRepresentable {
    @Binding var text: String
    var isEditable: Bool = true
    var font: NSFont = .systemFont(ofSize: NSFont.systemFontSize)
    
    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSTextView.scrollableTextView()
        let textView = scrollView.documentView as! NSTextView
        
        textView.delegate = context.coordinator
        textView.isEditable = isEditable
        textView.isSelectable = true
        textView.isRichText = false
        textView.importsGraphics = false
        textView.allowsUndo = true
        textView.font = font
        textView.textColor = NSColor.labelColor
        textView.backgroundColor = NSColor.textBackgroundColor
        textView.drawsBackground = true
        textView.isAutomaticQuoteSubstitutionEnabled = false
        textView.isAutomaticTextReplacementEnabled = false
        textView.isAutomaticSpellingCorrectionEnabled = false
        
        // 한글 입력 설정
        textView.isAutomaticTextCompletionEnabled = false
        textView.isContinuousSpellCheckingEnabled = false
        
        // 초기 텍스트 설정
        textView.string = text
        
        // 자동으로 포커스 설정
        DispatchQueue.main.async {
            textView.window?.makeFirstResponder(textView)
        }
        
        return scrollView
    }
    
    func updateNSView(_ nsView: NSScrollView, context: Context) {
        guard let textView = nsView.documentView as? NSTextView else { return }
        
        // 텍스트가 다를 때만 업데이트
        if textView.string != text {
            textView.string = text
        }
        
        textView.isEditable = isEditable
        textView.font = font
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: MacTextEditor
        
        init(_ parent: MacTextEditor) {
            self.parent = parent
        }
        
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }
            parent.text = textView.string
        }
        
        // 한글 입력 처리를 위한 메서드
        func textView(_ textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
            // Return false to allow default text input handling
            return false
        }
    }
}