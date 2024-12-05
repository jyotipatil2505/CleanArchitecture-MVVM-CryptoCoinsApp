# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'CryptoCoin' do
  use_frameworks!
  pod 'RealmSwift'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if target.name == 'Realm' || target.name == 'RealmSwift'
        target.build_configurations.each do |config|
          config.build_settings['CODE_SIGN_IDENTITY'] = ''
          config.build_settings['CODE_SIGNING_REQUIRED'] = 'NO'
          config.build_settings['CODE_SIGN_ENTITLEMENTS'] = ''
        end
      end
    end
  end
end

