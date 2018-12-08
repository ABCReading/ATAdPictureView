//
//  ATAdPictureView.h
//  ATAdPictureView
//
//  Created by lianglibao on 18/8/2.
//  Copyright © 2018年 梁立保. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATAdPictureViewProtocol.h"

typedef void(^LoadImageBlock)(UIImageView *imageView, NSURL *url);

@protocol ATAdPictureViewDelegate <NSObject>
@optional;
- (void)adPicViewDidSelectedPicModel: (id <ATAdPictureViewProtocol>)picM;

@end



@interface ATAdPictureView : UIView
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

// 只能用本初始化方法创建.
+ (instancetype)picViewWithLoadImageBlock:(LoadImageBlock)loadBlock;

/**
 *  外界决定的轮播翻页时间间隔,默认3秒.
 *  需要大于0,若小于0使用默认值3秒.
 */
@property (nonatomic, assign) NSTimeInterval timeInterval;

/**
 *  外界决定是否隐藏pageControl,默认不隐藏.
 */
@property (nonatomic, assign) BOOL isHiddenPageControl;

/**
 *  外界决定pageControl的默认颜色,默认grayColor
 */
@property (nonatomic, strong) UIColor *pageControlNormalColor;

/**
 *  外界决定pageControl的当前页高亮颜色,默认orangeColor
 */
@property (nonatomic, strong) UIColor *pageControlHightlightColor;

/**
 *  用来展示图片的数据源,在以上配置设置完后再设置!(以上配置在数据源setter里面懒加载.)
 */
@property (nonatomic, strong) NSArray <id <ATAdPictureViewProtocol>>*picModels;

/**
 *  用于告知外界,当前点击的是哪个广告数据模型
 */
@property (nonatomic, strong) id<ATAdPictureViewDelegate> delegate;

@end
