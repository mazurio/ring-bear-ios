# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Ring Bear' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Ring Bear
  pod 'RealmSwift'
  pod 'Eureka', '~> 4.0.1'

  target 'Ring BearTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Ring BearUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
  	if ['Eureka'].include? target.name
  		target.build_configurations.each do |config|
  			config.build_settings['SWIFT_VERSION'] = '4.0'
  		end
  	end
  end
end
