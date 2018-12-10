Pod::Spec.new do |s|
  s.name             = 'ElementaryCyclesSearch'
  s.version          = '0.2.0'
  s.summary          = 'Elementary Circuits of a Directed Graph'
  s.description      = <<-DESC
The implementation is pretty much generic, all it needs is a adjacency-matrix of your graph and the objects of your nodes. Then you get back the sets of node-objects which build a cycle.
  DESC
  s.homepage         = 'https://github.com/hectr/swift-elementary-cycles'
  s.license          = { :type => 'BSD-2', :file => 'LICENSE' }
  s.author           = 'Hèctor Marquès'
  s.social_media_url = 'https://twitter.com/elnetus'
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.13'
  s.source           = { :git => 'https://github.com/hectr/swift-elementary-cycles.git', :tag => s.version.to_s }
  s.source_files     = 'Sources/ElementaryCyclesSearch/**/*'
  s.swift_version    = '4.2'
end
