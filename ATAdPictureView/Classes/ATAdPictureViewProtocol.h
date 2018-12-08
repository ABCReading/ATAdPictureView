//
//  ATAdPictureViewProtocol.h
//  ATAdPictureView
//
//  Created by lianglibao on 18/9/10.
//  Copyright © 2018年 梁立保. All rights reserved.
//

@protocol ATAdPictureViewProtocol <NSObject>

/**
 *  广告图片URL
 */
@property (nonatomic, copy) NSURL *adImgURL;

/**
 *  router字符串
 */
@property (nonatomic, copy) NSString *routerUrl;

/**
 *  点击执行的代码块(优先级高于adLinkURL)
 */
@property (nonatomic, copy) void(^clickBlock)(void);

@end
