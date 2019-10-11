Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '10.0'
s.name = "GPSMaskTextField"
s.summary = "GPSMaskTextField lets a user select an ice cream flavor."
s.requires_arc = true

# 2
s.version = "2.0.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Gilson Santos" => "gilsonsantosti@gmail.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/GilsonPSantos/GPSMaskTextField"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/GilsonPSantos/GPSMaskTextField.git",
:tag => "#{s.version}" }

# 7
s.framework = "UIKit"

# 8
s.source_files = "GPSMaskTextField/**/*.{swift}"

# 9
#s.resources = "GPSMaskTextField/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "5.0"

end
