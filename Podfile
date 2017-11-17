# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'FriendShare' do
  use_frameworks!
  pod 'SnapKit', '~> 4.0.0'
  pod 'SwiftyJSON'
  pod 'RealmSwift'
  pod 'GooglePlacePicker', '= 2.5.0'
  pod 'GooglePlaces', '= 2.5.0'
  pod 'GoogleMaps', '= 2.5.0'
  pod 'DeepLinkKit', :git => 'git@github.com:button/DeepLinkKit.git', :tag => '1.5.0'
  pod 'CryptoSwift'
  
  # We're using Facebook to maintain and share unique Friend IDs
  # As theres no easy way to have a single unified unique ID system
  # that also shares user names without a webservice of some kind...
  pod 'FacebookCore'
  pod 'FacebookLogin'

  target 'FriendShareTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick', '~> 1.2.0'
    pod 'Nimble', '~> 7.0.2'
  end

end
