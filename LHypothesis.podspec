Pod::Spec.new do |s|
  s.name             = 'LHypothesis'
  s.version          = '1.1.1'
  s.summary          = 'Analytics abstraction layer for Swift.'

  s.homepage         = 'https://github.com/lgilyazov/LHypothesis'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lenar Gilyazov' => 'l.gilyazov@ya.ru' }
  s.source           = { :git => 'https://github.com/lgilyazov/LHypothesis.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/lenar_gilyazov'

  s.swift_version    = "5.0"
  s.static_framework = true

  s.ios.deployment_target = '13.0'
  s.tvos.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'

  s.default_subspec = 'Core'

  s.subspec 'Core' do |ss|
    ss.source_files = 'Sources/Core/*.swift'
    
    ss.frameworks = 'Foundation'
  end

  s.subspec 'Firebase' do |ss|
    ss.source_files = 'Sources/Providers/FirebaseProvider.swift'

    ss.dependency 'LHypothesis/Core'
    ss.dependency 'FirebaseAnalytics'
  end

   s.subspec 'AppsFlyer' do |ss|
     ss.source_files = 'Sources/Providers/AppsFlyerProvider.swift'

     ss.dependency 'LHypothesis/Core'
     ss.dependency 'AppsFlyerFramework'
   end

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*.swift'
  end
end
