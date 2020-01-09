#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_paldesk.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_paldesk'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin to use Paldesk.'
  s.description      = <<-DESC
A new Flutter plugin to use Paldesk.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Sungazer OÜ' => 'saverio@sungazer.io' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'Paldesk', '0.0.6'
  s.platform = :ios, '11.0'
  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
