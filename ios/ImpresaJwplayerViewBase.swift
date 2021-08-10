//
//  ImpresaJwplayerViewBase.swift
//  react-native-impresa-jwplayer
//
//  Created by Rodrigo Matos on 11/07/2021.
//

//class ImpresaJwplayerViewBase : UIView, JWPlayerDelegate {
//    var player: JWPlayerController?
//    var viewPlayer : UIView!
//    var config = JWConfig()
//
//    @objc var onFullScreen: RCTBubblingEventBlock?
//    @objc var onFullScreenExit: RCTBubblingEventBlock?
//    @objc var onPlay: RCTBubblingEventBlock?
//    @objc var onPause: RCTBubblingEventBlock?
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        createConfig()
//        enableBackgroundAudio()
//    }
//
//    override func removeFromSuperview() {
//        super.removeFromSuperview()
//        self.player?.stop()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func reactSetFrame(_ frame: CGRect) {
//        let height = frame.size.height
//        let width = frame.size.width
//        config.size = CGSize(width: width, height: height);
//
//        createPlayer(config: config)
//        super.reactSetFrame(frame)
//    }
//
//    func createConfig(){
//        config.stretching = JWStretching.uniform
//        config.displayTitle = true
//        config.size = CGSize(width: self.bounds.width, height: self.bounds.height);
//    }
//
//    func createPlayer(config : JWConfig) {
//        player = JWPlayerController(config: config)
//        player?.forceLandscapeOnFullScreen = true
//        player?.forceFullScreenOnLandscape = true
//        player?.delegate = self
//
//        if let playerView = player?.view {
//            viewPlayer = playerView
//            self.addSubview(playerView)
//            self.bringSubviewToFront(playerView)
//        }
//    }
//
//    func enableBackgroundAudio() -> Void {
//        let audioSession = AVAudioSession.sharedInstance()
//        try? audioSession.setCategory(.playback)
//        do {
//            try audioSession.setCategory(.playback)
//        } catch {
//            print("failure")
//        }
//        try? audioSession.setActive(true)
//        do {
//            try audioSession.setActive(true)
//        } catch {
//            print("failure")
//        }
//    }
//
//    func setupADSchedule(schedules:Array<Dictionary<String, String>>){
//        var ads = Array<JWAdBreak>()
//        for schedule in schedules {
//            let adBreak = JWAdBreak(tag:schedule["tag"] ?? "", offset: schedule["offset"] ?? "")
//            ads.append(adBreak)
//        }
//
//        // Create the AdConfig
//        let adConfig = JWAdConfig()
//        adConfig.client = .vast
//        adConfig.schedule = ads
//
//        // Initialize the JWConfig and create the JWPlayerController
//        config.advertising = adConfig
//    }
//
//    // external params
//
//    @objc var adSchedule: Array = Array<Dictionary<String, String>>() {
//        didSet {
//            setupADSchedule(schedules: adSchedule)
//        }
//    }
//
//    @objc var mediaId: String = "" {
//        didSet {
//            config.mediaId = mediaId
//        }
//    }
//
//    @objc var desc: String = "" {
//        didSet {
//            config.desc = desc
//        }
//    }
//
//    @objc var title: String = "" {
//        didSet {
//            config.title = title
//        }
//    }
//
//    @objc var licenseKey: String = "" {
//        didSet {
//
//        }
//    }
//
//    @objc var file: String = "" {
//        didSet {
//            config.file = file
//        }
//    }
//
//    @objc var imageFile: String = "" {
//        didSet {
//            config.image = imageFile
//        }
//    }
//
//    @objc var volume: Float = 100 {
//        didSet {
//            player?.volume = CGFloat(volume)
//        }
//    }
//
//    @objc var autostart: Bool = false {
//        didSet {
//            config.autostart = autostart
//        }
//    }
//
//    @objc var repeatVideo: Bool = false {
//        didSet {
//            config.repeat = repeatVideo
//        }
//    }
//
//    @objc var controls: Bool = true {
//        didSet {
//            config.controls = controls
//        }
//    }
//
//    func onFullscreen(_ event: JWEvent & JWFullscreenEvent) {
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
//    }
//
//    func onPlay(_ event: JWEvent & JWStateChangeEvent) {
//        if self.onPlay != nil{
//            let event = ["_play": Bool()]
//            self.onPlay!(event)
//        }
//    }
//
//    func onPause(_ event: JWEvent & JWStateChangeEvent) {
//        if self.onPause != nil{
//            let event = ["_pause": Bool()]
//            self.onPause!(event)
//        }
//    }
//
//    public func toggleFullScreen(){
//       self.player?.fullscreen = !(self.player?.fullscreen ?? false)
//    }
//
//    public func play(){
//        self.player?.play()
//    }
//
//    public func pause(){
//        self.player?.pause()
//    }
//
//    public func destroy(){
//        self.player?.stop()
//        self.player = nil
//        self.viewPlayer = nil
//    }
//}

import UIKit
import JWPlayerKit

class ImpresaJwplayerViewBase : UIView {

    weak var viewController: VastViewController?
    var configBuilder: JWPlayerConfigurationBuilder = JWPlayerConfigurationBuilder()
    var itemBuilder: JWPlayerItemBuilder = JWPlayerItemBuilder()

    
    @objc var onFullScreen: RCTBubblingEventBlock?
    @objc var onFullScreenExit: RCTBubblingEventBlock?
    @objc var onPlay: RCTBubblingEventBlock?
    @objc var onPause: RCTBubblingEventBlock?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configBuilder = JWPlayerConfigurationBuilder()
        itemBuilder = JWPlayerItemBuilder()
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
        guard
            let parentVC = parentViewController
            else {
            return
        }
            
        let vcImpresa = VastViewController()
        parentVC.addChild(vcImpresa)
        addSubview(vcImpresa.view)
        vcImpresa.view.frame = bounds
        vcImpresa.didMove(toParent: parentVC)
        vcImpresa.forceLandscapeOnFullScreen = true
        vcImpresa.forceFullScreenOnLandscape = true
        
        var item: JWPlayerItem? = nil
        do {
            item = try itemBuilder.build()
        } catch {
            print(error.localizedDescription)
        }
        
        vcImpresa.setup(configBuilder: configBuilder, item: item!)
        self.viewController = vcImpresa
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
    
    // external params
    
    @objc var adSchedule: Array = Array<Dictionary<String, String>>() {
        didSet {
            setupADSchedule(schedules: adSchedule)
        }
    }
    
    @objc var mediaId: String = "" {
        didSet {
            itemBuilder.mediaId(mediaId)
        }
    }
    
    @objc var desc: String = "" {
        didSet {
            itemBuilder.description(desc)
        }
    }
    
    @objc var title: String = "" {
        didSet {
            itemBuilder.title(title)
        }
    }
    
    @objc var licenseKey: String = "" {
        didSet {
            JWPlayerKitLicense.setLicenseKey("S0rXXMtyuPqRWFL0tL+eYS+KzTazkNQJH5eed+1+gtxuHb2U")
        }
    }
    
    @objc var file: String = "" {
        didSet {
            itemBuilder.file(URL(string:file)!)
        }
    }
    
    @objc var imageFile: String = "" {
        didSet {
            itemBuilder.posterImage(URL(string:imageFile)!)
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
    
    
//    func onFullscreen(_ event: JWEvent & JWFullscreenEvent) {
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
//    }
//
//    func onPlay(_ event: JWEvent & JWStateChangeEvent) {
//        if self.onPlay != nil{
//            let event = ["_play": Bool()]
//            self.onPlay!(event)
//        }
//    }
//
//    func onPause(_ event: JWEvent & JWStateChangeEvent) {
//        if self.onPause != nil{
//            let event = ["_pause": Bool()]
//            self.onPause!(event)
//        }
//    }
//
//    public func toggleFullScreen(){
//        configBuilder.full;
//
//
//        self.player?.fullscreen = !(self.player?.fullscreen ?? false)
//    }
    
    public func play(){
        self.viewController?.player.play();
    }
    
    public func pause(){
        self.viewController?.player.pause();
    }
    
    public func destroy(){
        self.viewController?.player.stop();
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
