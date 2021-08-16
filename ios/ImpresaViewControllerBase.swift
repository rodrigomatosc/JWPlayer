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
}

