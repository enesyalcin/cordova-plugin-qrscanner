
  Pod::Spec.new do |s|
    s.name = 'CapacitorQrscanner'
    s.version = '0.0.1'
    s.summary = 'QR-Scanner with native camera'
    s.license = 'MIT'
    s.homepage = 'https://github.com/enesyalcin/cordova-plugin-qrscanner'
    s.author = 'Enes Yalcin'
    s.source = { :git => 'https://github.com/enesyalcin/cordova-plugin-qrscanner', :tag => s.version.to_s }
    s.source_files = 'ios/Plugin/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
    s.ios.deployment_target  = '11.0'
    s.dependency 'Capacitor'
  end