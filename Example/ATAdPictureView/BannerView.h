//
//  BannerView.h
//  ATAdPictureView_Example
//
//  Created by lianglibao on 2018/12/17.
//  Copyright © 2018年 Spaino. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BannerView;
@protocol BannerViewDelegate <NSObject>

- (void) carouselTouch:(BannerView*)carousel atIndex:(NSUInteger)index;

@end

@interface BannerView : UIView

@property (nonatomic, copy) void(^bannerTouchBlock)(NSUInteger index);

@property (nonatomic, weak) id<BannerViewDelegate> delegate;

- (void)setupWithArray:(NSArray *)array;
/**
 *  类初始化方法；
 *
 */
+ (instancetype)initWithFrame:(CGRect)frame
                    withArray:(NSArray*)array
                     hasTimer:(BOOL)hastimer
                     interval:(NSUInteger)inter;

+ (instancetype)initWithFrame:(CGRect)frame
                     hasTimer:(BOOL)hastimer
                     interval:(NSUInteger)inter
                  placeHolder:(UIImage*)image;

@end
NS_ASSUME_NONNULL_END
