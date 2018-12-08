# ATAdPictureView

[![CI Status](https://img.shields.io/travis/Spaino/ATAdPictureView.svg?style=flat)](https://travis-ci.org/Spaino/ATAdPictureView)
[![Version](https://img.shields.io/cocoapods/v/ATAdPictureView.svg?style=flat)](https://cocoapods.org/pods/ATAdPictureView)
[![License](https://img.shields.io/cocoapods/l/ATAdPictureView.svg?style=flat)](https://cocoapods.org/pods/ATAdPictureView)
[![Platform](https://img.shields.io/cocoapods/p/ATAdPictureView.svg?style=flat)](https://cocoapods.org/pods/ATAdPictureView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ATAdPictureView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ATAdPictureView'
```

- 1. 在宿主工程中创建modle class,遵循ATAdPictureViewProtocol协议,在.m文件中

  ```@synthesize adImgURL, routerUrl;```等属性;

- 2. 只能以picViewWithLoadImageBlock方法来初始化ATAdPictureView,loadBlock为轮播器图片的下载设置block.

- 3. 初始化ATAdPictureView的数据源要在其他属性(时间间隔,pagecontrol颜色)设置完毕后设置.

## Author

Spaino, captain_spaino@163.com

## License

ATAdPictureView is available under the MIT license. See the LICENSE file for more info.
