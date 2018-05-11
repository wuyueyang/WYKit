
Pod::Spec.new do |s|

  s.name          = "WYKit"
  s.version       = "0.0.1"
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

  s.source_files  = 'Source/**/*.swift'

  s.requires_arc  = true

end
