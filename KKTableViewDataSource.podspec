#
#  Be sure to run `pod spec lint KKTableViewDataSource.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "KKTableViewDataSource"
  spec.version      = "0.0.1"
  spec.platform     = :ios, "8.0"
  spec.summary      = "解耦`tableView`的数据源方法和代理方法"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.requires_arc = true

  spec.description  = <<-DESC
  解耦`tableView`的数据源方法和代理方法，不再需要每次都设置代理和数据源方法，`KKTableViewDataSource`可以帮助我们管理`tableView`的代理方法、数据源方法。
                   DESC

  spec.homepage     = "https://github.com/kk-laoguo/KKTableViewDataSource.git"

  spec.author       = { "zainguo" => "572249347@qq.com" }


  spec.source       = { :git => "https://github.com/kk-laoguo/KKTableViewDataSource.git", :tag => "#{spec.version}" }

  spec.frameworks   = 'Foundation', 'UIKit'

  spec.source_files  = "KKTableViewDataSource", "KKTableViewDataSource/**/*.{h,m}"

  spec.public_header_files = "KKTableViewDataSource/**/*.h"
  # spec.exclude_files = "Classes/Exclude"


end
