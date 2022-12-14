require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-impresa-jwplayer"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "12.0" }
  s.source       = { :git => "https://impresa.pt.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm,swift}"
  
  s.dependency "React-Core"
  s.dependency 'JWPlayerKit', '~> 4.0.0'
  s.dependency 'google-cast-sdk'
  s.dependency 'GoogleAds-IMA-iOS-SDK', '~> 3.14.3'
  
  s.resource = ['ios/*.js', "ios/**/*.xib"]
  s.resource_bundles = { 'ImpresaJwplayer_bundle' => ['ios/*.ttf', 'ios/*.storyboard','ios/*.xcassets'] }
  
end
