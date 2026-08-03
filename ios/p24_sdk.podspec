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
  s.source_files = 'p24_sdk/Sources/p24_sdk/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'
  s.swift_versions = ['5.0']

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }

  s.preserve_paths = 'p24_sdk/Lib/**/*'
  s.vendored_frameworks = "p24_sdk/Lib/P24.xcframework"



end
