import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    self.contentViewController = flutterViewController
    
    // Set default window size and position
    let screenFrame = NSScreen.main?.frame ?? NSRect.zero
    let windowWidth: CGFloat = 500
    let windowHeight: CGFloat = 800
    let windowX = (screenFrame.width - windowWidth) / 2
    let windowY = (screenFrame.height - windowHeight) / 2
    
    let newFrame = NSRect(x: windowX, y: windowY, width: windowWidth, height: windowHeight)
    self.setFrame(newFrame, display: true)
    
    // Set minimum window size
    self.minSize = NSSize(width: 450, height: 600)
    
    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
