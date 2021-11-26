Pod::Spec.new do |s|
  s.name             = 'LHypothesis'
  s.version          = '1.1.0'
  s.summary          = 'Analytics abstraction layer for Swift.'

  s.homepage         = 'https://github.com/leklef/LHypothesis'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lenar Gilyazov' => 'lenar8553@gmail.com' }
  s.source           = { :git => 'https://github.com/leklef/LHypothesis.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/lenar_gilyazov'

  s.swift_version    = "5.0"
  s.static_framework = true

  s.ios.deployment_target = '11.0'
  s.tvos.deployment_target = '12.0'
  s.osx.deployment_target = '10.15'

  s.default_subspec = 'Core'

  s.subspec 'Core' do |ss|
    ss.source_files = 'LHypothesis/Classes/Core/*.swift'
    
    ss.frameworks = 'Foundation'
  end

  s.subspec 'Firebase' do |ss|
    ss.source_files = 'LHypothesis/Classes/Providers/FirebaseProvider.swift'

    ss.dependency 'LHypothesis/Core'
    ss.dependency 'Firebase/Analytics'
  end

  s.subspec 'AppsFlyer' do |ss|
    ss.source_files = 'LHypothesis/Classes/Providers/AppsFlyerProvider.swift'

    ss.dependency 'LHypothesis/Core'
    ss.dependency 'AppsFlyerFramework'
  end
  
end
