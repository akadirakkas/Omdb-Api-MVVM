platform :ios, '13.0'

use_frameworks!
inhibit_all_warnings!

install! 'cocoapods', :deterministic_uuids => false, :warn_for_multiple_pod_sources => false, :warn_for_unused_master_specs_repo => false

target 'Omdb-Api' do

	pod 'Alamofire'
	pod 'SDWebImage', '~> 5.0'
	pod 'Loaf'
	pod 'Firebase/Analytics'
	pod 'FirebaseMessaging'
	pod 'FirebaseRemoteConfig'
	pod 'NVActivityIndicatorView'

 post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
  end
end