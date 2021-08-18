import JWPlayerKit

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
    
    @objc func pause(_ node: NSNumber) -> Void {
        DispatchQueue.main.async {
            let component = self.bridge.uiManager.view(
                forReactTag: node
            ) as! ImpresaJwplayerViewBase
            component.pause()
        }
    }
    
    @objc public func toggleFullScreen(_ node:NSNumber){
        DispatchQueue.main.async {
            let component = self.bridge.uiManager.view(
                forReactTag: node
            ) as! ImpresaJwplayerViewBase
            component.toggleFullScreen()
        }
    }
    
    @objc public func play(_ node:NSNumber){
        DispatchQueue.main.async {
            let component = self.bridge.uiManager.view(
                forReactTag: node
            ) as! ImpresaJwplayerViewBase
            component.play()
        }
    }
    
    @objc public func destroy(_ node:NSNumber){
        DispatchQueue.main.async {
            let component = self.bridge.uiManager.view(
                forReactTag: node
            ) as! ImpresaJwplayerViewBase
            component.destroy()
        }
    }
}
