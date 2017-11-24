Pod::Spec.new do |s|
  s.name     = 'PMFlatButton'
  s.version  = '1.0.1'
  s.license  = 'MIT'
  s.summary  = 'swift based simple flat button'
  s.homepage = 'https://github.com/peromasamune/PMFlatButton_demo_swift'
  s.author   = { "Peromasamune" => "peromasamune00375421@gmail.com" }
  s.source   = { :git => "https://github.com/peromasamune/PMFlatButton_demo_swift.git", :tag => "#{s.version}" }
  s.platform = :ios
  s.source_files = 'PMFlatButton/*.{h,m,swift}'
  s.framework = 'UIKit' , 'QuartzCore'
end
