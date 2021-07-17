//
//  ImpresaJwplayerViewBase.swift
//  react-native-impresa-jwplayer
//
//  Created by Rodrigo Matos on 14/07/2021.
//


class ImpresaJwplayerViewBase : UIView {
    var player: JWPlayerController?
    var config = JWConfig()
    
    func createPlayer(config : JWConfig) -> Void {
        player = JWPlayerController(config: config)
        player?.forceLandscapeOnFullScreen = true
        player?.forceFullScreenOnLandscape = true
        player?.volume = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        config = JWConfig()
        config.autostart = true
        config.repeat = true
        config.controls = true
        
        config.size = CGSize(width: self.frame.size.width, height: self.frame.size.width);
        createPlayer(config: config)
        
        if let playerView = player?.view {
            self.addSubview(playerView)
            self.bringSubviewToFront(playerView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc var color: String = "" {
        didSet {
        }
    }
    
    @objc var file: String = "" {
        didSet {
            config.file = file
        }
    }
}

