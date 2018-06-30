Pod::Spec.new do |s|
  s.name         = "ABCFramework"
  s.version      = "0.0.1"
  s.summary      = "a simple iOS view router framework"
  s.homepage     = "https://github.com/AKACoder/ABCFramework/"
  s.license      = "MIT"
  s.author       = { "AKACoder" => "akacoder@outlook.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/AKACoder/ABCFramework.git", :tag => "v0.0.1" }
  s.source_files = "ABCFramework/SourceCode/**/*.{swift}"
  s.requires_arc = true
  s.dependency "Neon", "~> 0.4.0"
end
