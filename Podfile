# Uncomment the next line to define a global platform for your project
# platform :ios, ‘8.0’

target 'Telugu Churches' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
pod 'youtube-ios-player-helper', :git=>'https://github.com/youtube/youtube-ios-player-helper', :commit=>'head'

pod "TextFieldEffects"
pod 'IQKeyboardManagerSwift'
pod 'Localize' , '~> 1.5.2'
pod 'FSCalendar'
#pod 'SDWebImage', '~> 4.0'
pod 'SDWebImage/WebP'

#pod 'Firebase/Core'
#pod 'Firebase/Messaging'

 use_frameworks!

  # Pods for Telugu Churches
 use_frameworks!
pod 'Fabric'
pod 'Crashlytics'

end
post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
