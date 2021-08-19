import UIKit
import JWPlayerKit

class ImpresaJwplayerViewBase : UIView {

    weak var viewController: VastViewController?
    var configBuilder: JWPlayerConfigurationBuilder = JWPlayerConfigurationBuilder()
    
    @objc var onFullScreen: RCTBubblingEventBlock?
    @objc var onFullScreenExit: RCTBubblingEventBlock?
    @objc var onPlay: RCTBubblingEventBlock?
    @objc var onPause: RCTBubblingEventBlock?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configBuilder = JWPlayerConfigurationBuilder()
        enableBackgroundAudio()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if viewController == nil {
               embed()
           } else {
            viewController?.view.frame = bounds
        }
    }
    
    private func embed() {
        destroy();
        
        guard
            let parentVC = parentViewController
            else {
            return
        }
        
        let itemBuilder = instanceItemBuilder()
        
        var item: JWPlayerItem? = nil
        do {
            item = try itemBuilder.build()
           
        } catch {
            print(error.localizedDescription)
        }
        
        configBuilder.playlist([item!]).repeatContent(true)
        
       
        
        let vcImpresa = VastViewController()
        parentVC.addChild(vcImpresa)
        addSubview(vcImpresa.view)
        vcImpresa.view.frame = bounds
        vcImpresa.didMove(toParent: parentVC)
        vcImpresa.forceLandscapeOnFullScreen = true
        vcImpresa.forceFullScreenOnLandscape = true
        vcImpresa.setup(configBuilder: configBuilder, view: self)
        self.viewController = vcImpresa
    }
    
    func setPlaylist(itemBuilder: JWPlayerItemBuilder){
       
    }
    
    override func reactSetFrame(_ frame: CGRect) {
        super.reactSetFrame(frame)
    }
    
    func enableBackgroundAudio() -> Void {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playback)
        do {
            try audioSession.setCategory(.playback)
        } catch {
            print("failure")
        }
        try? audioSession.setActive(true)
        do {
            try audioSession.setActive(true)
        } catch {
            print("failure")
        }
    }
    
    func setupADSchedule(schedules:Array<Dictionary<String, String>>){
        do {
            var ads = Array<JWAdBreak>()
            for schedule in schedules {
                
                var tags = Array<URL>()
                let tag = schedule["tag"] ?? ""
                let offset = schedule["offset"] ?? ""
                tags.append(URL(string: tag)!)
                            
                let adBreak = try JWAdBreakBuilder()
                    .tags(tags)
                    .offset(JWAdOffset.from(string: offset)!)
                    .build()
                
                ads.append(adBreak)
            }
            
            // Create a JW Player VAST ad.
            let adConfig = try JWAdsAdvertisingConfigBuilder()
                .schedule(ads)
                .build()
            
            configBuilder.advertising(adConfig)
        }
        catch {NSLog(error.localizedDescription)
            NSLog("ERROOOOOO")
            NSLog(error.localizedDescription)
        }
    }
    
    func instanceItemBuilder() -> JWPlayerItemBuilder{
        let itemBuilder = JWPlayerItemBuilder()
        itemBuilder.file(URL(string:self.file)!)
        itemBuilder.mediaId(self.mediaId)
        itemBuilder.posterImage(URL(string:self.imageFile)!)
        itemBuilder.description(self.desc)
        itemBuilder.title(self.title)
        return itemBuilder;
    }
    
    // external params
    
    @objc var adSchedule: Array = Array<Dictionary<String, String>>() {
        didSet {
            setupADSchedule(schedules: adSchedule)
        }
    }
    
    @objc var mediaId: String = "" {
        didSet {
            if( self.viewController != nil){
                embed()
            }
        }
    }
    
    @objc var desc: String = "" {
        didSet {
            if( self.viewController != nil){
                embed()
            }
        }
    }
    
    @objc var title: String = "" {
        didSet {
            if( self.viewController != nil){
                embed()
            }
        }
    }
    
    @objc var licenseKey: String = "" {
        didSet {
            JWPlayerKitLicense.setLicenseKey(licenseKey)
        }
    }
    
    @objc var file: String = "" {
        didSet {
            if( self.viewController != nil){
                embed()
            }
        }
    }
    
    @objc var imageFile: String = "" {
        didSet {
            if( self.viewController != nil){
                embed()
            }
        }
    }
    
    @objc var volume: Float = 100 {
        didSet {
            self.viewController?.player.volume = Double(volume)
        }
    }
    
    @objc var autostart: Bool = false {
        didSet {
            configBuilder.autostart(autostart)
        }
    }
    
    @objc var repeatVideo: Bool = false {
        didSet {
            configBuilder.repeatContent(repeatVideo)
        }
    }
    
    @objc var controls: Bool = true {
        didSet {
            
        }
    }
    
    public func localOnPause(){
       if self.onPause != nil{
          let event = ["_pause": Bool()]
          self.onPause!(event)
       }
    }
    
    public func localOnPlay(){
      if self.onPlay != nil{
        let event = ["_play": Bool()]
        self.onPlay!(event)
      }
    }
    
    func onFullscreen() {
        // TODO NEW
//        if event.fullscreen {
//            if self.onFullScreen != nil{
//                let event = ["_fullscreen": Bool()]
//                self.onFullScreen!(event)
//            }
//        }else {
//            if self.onFullScreenExit != nil{
//                let event = ["_fullscreen": Bool()]
//                self.onFullScreenExit!(event)
//            }
//        }
    }

    public func toggleFullScreen(){
        
//        self.player?.fullscreen = !(self.player?.fullscreen ?? false)
    }
    
    public func play(){
        self.viewController?.player.play();
    }
    
    public func pause(){
        self.viewController?.player.pause();
    }
    
    public func destroy(){
        self.viewController?.removeFromParent()
        self.viewController = nil
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
