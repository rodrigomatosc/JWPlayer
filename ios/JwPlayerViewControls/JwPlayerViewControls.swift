//
//  JwplayerView.swift
//  react-native-impresa-jwplayer
//
//  Created by Rodrigo Matos on 14/07/2021.
//

import Foundation


class JwPlayerViewControls : ImpresaJwplayerViewBase {
    
    var controlsView: UIView!
    var rewindButton: UIButton!
    var playbackButton: UIButton!
    var forwardButton: UIButton!
    var audioButton: UIButton!
    var fullscreenButton: UIButton!
    var timeLabel: UILabel!
    var timeSlider: UISlider!
    let indicatorView = UIActivityIndicatorView(style: .whiteLarge)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initPlayer()
        creatButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initPlayer(){
        
        // Verify instance of JWPlayerController
        if let player = self.player {
//            player.config.controls = false
    
            if let playerView = player.view {
                indicatorView.color = UIColor(red: 234/255, green: 52/255, blue: 76/255, alpha: 1)
                playerView.addSubview(indicatorView)
                playerView.bringSubviewToFront(indicatorView)
//                indicatorView.constraintToCenter()
            }
        }
    }
    
    private func creatButtons(){
        
        controlsView = UIView()
        
//        rewindButton.setImage(UIImage.init(named: "icons8-rewind-10-100"), for: .normal)
//        forwardButton.setImage(UIImage.init(named: "icons8-forward-10-100"), for: .normal)
//        audioButton.setImage(UIImage.init(named: "icons8-audio-100"), for: .normal)
//        audioButton.setImage(UIImage.init(named: "icons8-mute-100"), for: .selected)
//        fullscreenButton.setImage(UIImage.init(named: "icons8-full-screen-100"), for: .normal)
//        fullscreenButton.setImage(UIImage.init(named: "icons8-normal-screen-100"), for: .selected)
        let buttonX = 150
        let buttonY = 0
        let buttonWidth = 100
        let buttonHeight = 50

        let button = UIButton(type: .system)
        button.setTitle("Click here", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red

        button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)

        self.addSubview(button)
        self.bringSubviewToFront(button)

    }
}

