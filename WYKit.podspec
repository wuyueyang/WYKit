
Pod::Spec.new do |s|

  s.name          = "WYKit"
  s.version       = "1.0"
  s.swift_version = "4.1"
  s.summary       = "An easy to integrate switch framework."

  s.description   = <<-DESC
                      An easy to integrate switch framework, Is an interesting thing.
                      DESC

  s.homepage      = "https://github.com/wuyueyang/WYKit"
  s.license       = { :type => "MIT", :file => "LICENSE" }

  s.author        = { "武月洋" => "wu1993sora@outlook.com" }
  s.platform      = :ios, "9.0"

  s.source        = { :git => "https://github.com/wuyueyang/WYKit.git", :tag => "#{s.version}" }

  s.source_files  = 'SwiftDemo/SwiftDemo/Sources/**/*.swift'

  s.requires_arc  = true

  s.dependency 'Moya', '~> 11.0'
  s.dependency 'SwiftyJSON', '~> 4.0'
  s.dependency 'SnapKit', '~> 4.0.0'
  s.dependency 'ESTabBarController-swift'
  s.dependency 'DeviceKit', '~> 1.3'

end
