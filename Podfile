source 'https://github.com/CocoaPods/Specs.git'
platform :ios, ‘9.0’
inhibit_all_warnings!
use_frameworks!

def default_pods
    pod 'Alamofire', '~> 4.4'
    pod 'MBProgressHUD', '~> 0.9.2'
    pod 'FFGlobalAlertController', '~> 1.0.2'
    pod 'ReachabilitySwift', '~> 3'
    pod 'SwiftyJSON', '~> 3.1.4'
end

def test_pods
    pod 'SwiftyJSON', '~> 3.1.4'
    pod 'Alamofire', '~> 4.4'
end

target 'Test' do
    default_pods
end

target ‘TestTests' do
    test_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
