Pod::Spec.new do |s|
  s.name         = 'ElementaryCycles'
  s.version          = '0.3.0'
  s.summary          = 'Find all elementary cycles in a directed graph'
  s.description      = <<-DESC
Swift port of an algorythm by Donald B. Johnson to find all the cycles in a directed graph.
  DESC
  s.homepage         = 'https://github.com/hectr/swift-elementary-cycles'
  s.license          = { :type => 'BSD-2', :file => 'LICENSE' }
  s.author           = 'Hèctor Marquès'
  s.social_media_url = 'https://twitter.com/elnetus'
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.13'
  s.source           = { :git => 'https://github.com/hectr/swift-elementary-cycles.git', :tag => s.version.to_s }
  s.source_files     = 'Sources/ElementaryCycles/**/*'
  s.dependency       'ElementaryCyclesSearch'
  s.swift_version    = '5.0'
end
