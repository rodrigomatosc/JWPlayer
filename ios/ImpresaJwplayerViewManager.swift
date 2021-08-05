@objc(ImpresaJwplayerViewManager)
class ImpresaJwplayerViewManager: RCTViewManager {
    
    var currentView: ImpresaJwplayerViewBase?
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    override func view() -> UIView! {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        currentView = ImpresaJwplayerViewBase(frame: frame)
        return currentView
    }
    
    @objc public func toggleFullScreen(_ node:NSNumber){
        currentView?.toggleFullScreen()
    }
    
    @objc public func play(_ node:NSNumber){
        currentView?.play()
    }
    
    @objc public func pause(_ node:NSNumber){
        currentView?.pause()
    }
    
    @objc public func destroy(_ node:NSNumber){
        currentView?.destroy()
    }
}
