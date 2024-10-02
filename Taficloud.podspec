Pod::Spec.new do |s|
  s.name             = 'Taficloud'
  s.version          = '0.0.4'
  s.summary          = 'Swift-based library for interacting with Taficloud services'
  s.description      = 'Swift-based library for interacting with Taficloud services.'
  s.homepage         = 'https://github.com/magnavisio/taficloud-ios-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Taficloud' => 'hello@taficloud.com' }
  s.source           = { :git => 'https://github.com/magnavisio/taficloud-ios-sdk.git', :tag => '0.0.4'}
  s.platform        = :ios, '13.0'
  s.swift_versions    = '5.0'
  s.source_files     = 'Sources/**/*.{h,m,swift}'  # Adjust this to point to your source files
  s.requires_arc     = true
  
end

