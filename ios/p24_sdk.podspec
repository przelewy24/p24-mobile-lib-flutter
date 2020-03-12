#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint p24_sdk.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'p24_sdk'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*', 'Lib/P24.h', 'Lib/P24ExtraFeaturesConfig.h'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }

  s.preserve_paths = 'Lib/**/*'
  s.vendored_library = "Lib/libP24.a"

  s.xcconfig = { "OTHER_LINK_FLAG" => '-ObjC -lstdc++' }

  s.framework = 'WebKit', 'PassKit', 'Foundation', 'UIKit', 'Security'

  s.libraries = 'z', 'c++'
  s.static_framework = true

end
