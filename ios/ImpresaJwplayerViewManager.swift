@objc(ImpresaJwplayerViewManager)
class ImpresaJwplayerViewManager: RCTViewManager {
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    override func view() -> UIView! {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        return ImpresaJwplayerViewBase(frame: frame)
    }
}
