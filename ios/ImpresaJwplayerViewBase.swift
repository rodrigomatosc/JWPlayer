//
//  ImpresaJwplayerViewBase.swift
//  react-native-impresa-jwplayer
//
//  Created by Rodrigo Matos on 11/07/2021.
//

class ImpresaJwplayerViewBase : UIView, JWPlayerDelegate {
    var player: JWPlayerController?
    var viewPlayer : UIView!
    var config = JWConfig()
    
    @objc var onFullScreen: RCTBubblingEventBlock?
    @objc var onFullScreenExit: RCTBubblingEventBlock?
    @objc var onPlay: RCTBubblingEventBlock?
    @objc var onPause: RCTBubblingEventBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reactSetFrame(_ frame: CGRect) {
        let height = frame.size.height
        let width = frame.size.width
        config.size = CGSize(width: width, height: height);

        createPlayer(config: config)
        super.reactSetFrame(frame)
    }
        
    func createConfig(){
        config.stretching = JWStretching.exactFit
        config.displayTitle = true
        config.size = CGSize(width: self.bounds.width, height: self.bounds.height);
    }
    
    func createPlayer(config : JWConfig) {
        player = JWPlayerController(config: config)
        player?.forceLandscapeOnFullScreen = true
        player?.forceFullScreenOnLandscape = true
        player?.delegate = self
        
        if let playerView = player?.view {
            viewPlayer = playerView
            self.addSubview(playerView)
            self.bringSubviewToFront(playerView)
        }
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
    
    // external params
    
    @objc var color: String = "" {
        didSet {
        }
    }
    
    @objc var file: String = "" {
        didSet {
            config.file = file
        }
    }
    
    @objc var imageFile: String = "" {
        didSet {
            config.image = imageFile
        }
    }
    
    @objc var volume: Float = 100 {
        didSet {
            player?.volume = CGFloat(volume)
        }
    }
    
    @objc var autostart: Bool = false {
        didSet {
            config.autostart = autostart
        }
    }
    
    @objc var repeatVideo: Bool = false {
        didSet {
            config.repeat = repeatVideo
        }
    }
    
    @objc var controls: Bool = true {
        didSet {
            config.controls = controls
        }
    }

    func onFullscreen(_ event: JWEvent & JWFullscreenEvent) {
        if event.fullscreen {
            if self.onFullScreen != nil{
                let event = ["_fullscreen": Bool()]
                self.onFullScreen!(event)
            }
        }else {
            if self.onFullScreenExit != nil{
                let event = ["_fullscreen": Bool()]
                self.onFullScreenExit!(event)
            }
        }
    }
    
    func onPlay(_ event: JWEvent & JWStateChangeEvent) {
        if self.onPlay != nil{
            let event = ["_play": Bool()]
            self.onPlay!(event)
        }
    }
    
    func onPause(_ event: JWEvent & JWStateChangeEvent) {
        if self.onPause != nil{
            let event = ["_pause": Bool()]
            self.onPause!(event)
        }
    }
    
    public func toggleFullScreen(){
       self.player?.fullscreen = !(self.player?.fullscreen ?? false)
    }
    
    public func play(){
        self.player?.play()
    }
    
    public func pause(){
        self.player?.pause()
    }
}

