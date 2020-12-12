#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_kepler.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_kepler'
  s.version          = '0.0.1'
  s.summary          = '京东开普勒插件'
  s.description      = <<-DESC
京东开普勒插件
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.vendored_frameworks ="JDKepler/*.framework"
  #s.resource = "JDKepler/*.bundle"
  s.platform = :ios, '8.0'
  s.frameworks = "UIKit","Foundation","SystemConfiguration","JavaScriptCore"
  s.libraries = "z","sqlite3.0","c++"
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
