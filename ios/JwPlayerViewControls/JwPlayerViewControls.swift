//
//  JwplayerView.swift
//  react-native-impresa-jwplayer
//
//  Created by Rodrigo Matos on 14/07/2021.
//

import Foundation
import UIKit

class JwPlayerViewControls : ImpresaJwplayerViewBase {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initPlayer()
        creatButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initPlayer(){
        self.player?.config.controls = false
        self.player?.config.autostart = false
    }
    
    private func creatButtons(){
        let viewTeste = ControlsView.instanceFromNib()
        
        let frame = CGRect(x: 0, y: self.viewPlayer.bounds.height - viewTeste.bounds.height, width: self.bounds.width, height: viewTeste.bounds.height)
        viewTeste.frame = frame
        self.addSubview(viewTeste)
        self.bringSubviewToFront(viewTeste)
        
        NSLog("\(self.bounds.height)/")
        NSLog("\(self.viewPlayer.bounds.height)/")
    }
}

class ControlsView: UIView {
    class func instanceFromNib() -> UIView {
        let view = UINib(nibName: "ControlsView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        return view
    }
}
