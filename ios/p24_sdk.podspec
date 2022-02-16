#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint p24_sdk.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'p24_sdk'
  s.version          = '0.0.1'
  s.summary          = 'Flutter wrapper for P24 native libraries.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://przelewy24.pl'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Przelewy24' => 'serwis@przelewy24.pl' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }

  s.preserve_paths = 'Lib/**/*'
  s.vendored_frameworks = "Lib/P24.xcframework"



end
