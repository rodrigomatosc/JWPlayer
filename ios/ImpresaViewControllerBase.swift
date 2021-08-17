import UIKit
import JWPlayerKit

class VastViewController: JWPlayerViewController{
    
    var viewBase: ImpresaJwplayerViewBase? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setup(configBuilder: JWPlayerConfigurationBuilder, item: JWPlayerItem, view: ImpresaJwplayerViewBase){
    
        self.viewBase = view;
        let _ = configBuilder.playlist([item]).preload(.auto).repeatContent(false)

        do{
            let config = try configBuilder.build()
            player.configurePlayer(with: config)
     
        } catch {
            print("Error building configuration:", error.localizedDescription)
        }
    }
    
    override func jwplayer(_ player: JWPlayer, didPauseWithReason reason: JWPauseReason) {
        super.jwplayer(player, didPauseWithReason: reason)
        if self.viewBase != nil{
            self.viewBase?.localOnPause();
        }
    }
    
    override func jwplayer(_ player: JWPlayer, isPlayingWithReason reason: JWPlayReason){
        super.jwplayer(player, isPlayingWithReason: reason)
        if self.viewBase != nil{
            self.viewBase?.localOnPlay();
        }

    }
}
