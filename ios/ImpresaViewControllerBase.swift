import UIKit
import JWPlayerKit

class VastViewController: JWPlayerViewController, JWDRMContentKeyDataSource {
    func contentIdentifierForURL(_ url: URL, completionHandler handler: @escaping (Data?) -> Void) {
        let uuid = "whwbL3Sx"
        let uuidData = uuid.data(using: .utf8)
        handler(uuidData)
    }
    
    func appIdentifierForURL(_ url: URL, completionHandler handler: @escaping (Data?) -> Void) {
        guard let certUrl = Bundle.main.url(forResource: "fps", withExtension: "cer"),
                 let appIdData = try? Data(contentsOf: certUrl) else {
               handler(nil)
               return
           }
           handler(appIdData)
    }
    
    func contentKeyWithSPCData(_ spcData: Data, completionHandler handler: @escaping (Data?, Date?, String?) -> Void) {
        let currentTime = Date().timeIntervalSince1970
           let spcProcessURL = "SPC-PROCESS-URL".appendingFormat("/%@?p1=%li", "content-uuid", currentTime)
           var ckcRequest = URLRequest(url: URL(string: spcProcessURL)!)
           ckcRequest.httpMethod = "POST"
           ckcRequest.httpBody = spcData
           ckcRequest.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        
        
           URLSession.shared.dataTask(with: ckcRequest) { (data, response, error) in
               guard error == nil, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                   handler(nil, nil, nil)
                   return
               }
               handler(data, nil, nil)
           }.resume()
    }
    
        
    private let adUrlString = "https://pubads.g.doubleclick.net/gampad/ads?sz=640x480&iu=/124319096/external/single_ad_samples&ciu_szs=300x250&impl=s&gdfp_req=1&env=vp&output=vast&unviewed_position_start=1&cust_params=deployment%3Ddevsite%26sample_ct%3Dskippablelinear&correlator="
    private let videoUrlString = "https://playertest.longtailvideo.com/adaptive/oceans/oceans.m3u8"
    private let posterUrlString = "https://d3el35u4qe4frz.cloudfront.net/bkaovAYt-480.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setup(configBuilder: JWPlayerConfigurationBuilder, item: JWPlayerItem){
    
        let _ = configBuilder.playlist([item]).preload(.auto).repeatContent(false)

        do{
            let config = try configBuilder.build()
            player.contentKeyDataSource = self

            player.configurePlayer(with: config)
        } catch {
            print("Error building configuration:", error.localizedDescription)
        }
    }
    
    // Build a JWAdvertisingConfig to setup the advertising for your media.
    private func buildAdvertising() -> JWAdvertisingConfig? {
        var adConfig : JWAdvertisingConfig? = nil
        // Initialize the ad URL, in this case from a String
        let adURL = URL(string: adUrlString)!

        // Initialize the builder.
        let adConfigBuilder = JWAdsAdvertisingConfigBuilder()
            // Set the VAST tag for the builder to use.
            // If tag AND schedule are set, this will throw an error.
            // Only set one of these.
            .tag(adURL)

        do {
            adConfig = try adConfigBuilder.build()
        } catch {
            print(error.localizedDescription)
        }

        return adConfig
    }
    
    // As with the configuration for the player we need to create a JWPlayerItem, using our JWPlayerItemBuilder().
    // This requires a file or sources.
    // Since the build method can throw, you need to handle errors if any are thrown.
    public func buildPlayerItem() -> JWPlayerItem? {
        var item: JWPlayerItem? = nil
        let videoUrl = URL(string:videoUrlString)!
        let posterUrl = URL(string:posterUrlString)!

        // To create a new JWPlayerItem, use the builder.
        let builder =  JWPlayerItemBuilder() // Initialize the builder.
            .file(videoUrl) // Set the file, which takes in a URL for the media.
            .posterImage(posterUrl) // You can set a poster image for the media.
        do {
            item = try builder.build() // Build the item. This method can throw so be sure to handle the error.
        } catch {
            print(error.localizedDescription)
        }
        
        return item
    }
}

