# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'automationCucumberish' do

  use_frameworks!

  target 'automationCucumberishCucumberTests' do
    # Pods for testing
	pod 'Cucumberish'
  end
  
  post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end

end
