//
//  ATAdPictureView.m
//  ATAdPictureView
//
//  Created by lianglibao on 18/8/2.
//  Copyright © 2018年 梁立保. All rights reserved.
//

#import "ATAdPictureView.h"

static NSInteger const radio = 3;

@interface ATAdPictureView ()<UIScrollViewDelegate>
{
    NSInteger _currentPage;
}

/**
 *  记录着根据模型数组, 添加的imageView控件
 */
@property (nonatomic, strong) NSMutableArray <UIImageView *>*adPics;
/**
 *  存放图片的内容视图
 */
@property (nonatomic, strong) UIScrollView *contentView;
/**
 *  页码指示
 */
@property (nonatomic, strong) UIPageControl *pageControl;
/**
 *  自动滚动的timer
 */
@property (nonatomic, strong) NSTimer *scrollTimer;

/**
 *  用于加载图片的代码块, 必须赋值
 */
@property (nonatomic, copy) LoadImageBlock loadBlock;

@end


@implementation ATAdPictureView

+ (instancetype)picViewWithLoadImageBlock: (LoadImageBlock)loadBlock {
    ATAdPictureView *adView = [[[self class] alloc] init];
    adView.loadBlock = loadBlock;
    return adView;
}

- (NSTimer *)scrollTimer {
    if (_scrollTimer == nil) {
        _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval?:3 target:self selector:@selector(autoScrollNextPage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_scrollTimer forMode:NSRunLoopCommonModes];
    }
    return _scrollTimer;
}

- (void)autoScrollNextPage {
    NSInteger page = _currentPage + 1;
    [self.contentView setContentOffset:CGPointMake(self.contentView.frame.size.width * page, 0) animated:YES];
}


- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.hidden = self.isHiddenPageControl;
        pageControl.pageIndicatorTintColor = self.pageControlNormalColor ?: [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = self.pageControlHightlightColor ?: [UIColor orangeColor];
        pageControl.hidesForSinglePage = YES;
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (UIScrollView *)contentView {
    if (_contentView == nil) {
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.pagingEnabled = YES;
        contentView.showsHorizontalScrollIndicator = NO;
        _contentView = contentView;
        _contentView.delegate = self;
        contentView.bounces = NO;
        [self addSubview:contentView];
    }
    return _contentView;
}

- (NSMutableArray<UIImageView *> *)adPics
{
    if (_adPics == nil) {
        _adPics = [NSMutableArray array];
    }
    return _adPics;
}


- (void)setPicModels:(NSArray<id <ATAdPictureViewProtocol>> *)picModels
{
    _picModels = picModels;

    // 1. 移除之前控件
    [self.adPics makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.adPics = nil;

    // 2. 根据模型添加新的控件
    NSInteger baseCount = picModels.count;
    NSInteger count = baseCount;
    if (baseCount > 1) {
        count = baseCount * radio;
    }
    for (int i = 0; i< count; i++) {

        id<ATAdPictureViewProtocol> picM = picModels[i % baseCount];
        // 1. 创建控件
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = self.adPics.count;
        
        // 2. 设置图片(SDWebImage),外置图片加载.
        if (self.loadBlock) {
            self.loadBlock(imageView, picM.adImgURL);
        }

        // 3. 添加手势, 点击图片跳转
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToLink:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];

        // 4. 添加到父控件, 以及使用数组保存
        [self.contentView addSubview:imageView];
        [self.adPics addObject:imageView];

    }


    self.pageControl.numberOfPages = picModels.count;

    [self setNeedsLayout];

    if (picModels.count > 1) {
        [self.scrollTimer fire];
    } else {
        [self.scrollTimer invalidate];
        self.scrollTimer = nil;
    }
}

- (void)jumpToLink:(UITapGestureRecognizer *)gester {
    UIView *imageView = gester.view;
    NSInteger tag = imageView.tag % self.picModels.count;
    id<ATAdPictureViewProtocol> adM = self.picModels[tag];

    if ([self.delegate respondsToSelector:@selector(adPicViewDidSelectedPicModel:)]) {
        [self.delegate adPicViewDidSelectedPicModel:adM];
    }
    
    /*
    if (adM.clickBlock) {
        adM.clickBlock();
    }
    */
}


- (void)layoutSubviews {
    [super layoutSubviews];

    self.contentView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20);

    NSInteger count = self.adPics.count;
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    for(int i = 0;i < count;i++) {
        UIImageView *imageView = self.adPics[i];
        imageView.frame = CGRectMake(i * width, 0, width, height);

    }

    self.contentView.contentSize = CGSizeMake(width * count, 0);
    [self scrollViewDidEndDecelerating:self.contentView];
}



// MARK: - UISCrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.adPics.count > 1) {
        [self scrollTimer];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self caculateCurrentPage:scrollView];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self caculateCurrentPage:scrollView];

}

- (void)caculateCurrentPage: (UIScrollView *)scrollView {

    if (self.picModels.count == 0) {
        return;
    }
    if (self.picModels.count == 1) {
        _currentPage = 1;
        return;
    }
    // 确认中间区域
    NSInteger min = self.picModels.count * (radio / 2);
    NSInteger max = self.picModels.count * (radio / 2 + 1);

    NSInteger page = round(scrollView.contentOffset.x / scrollView.frame.size.width);
    self.pageControl.currentPage = page % self.picModels.count;

    if (page < min || page > max) {
        page = min + page % self.picModels.count;
        [scrollView setContentOffset:CGPointMake(page * scrollView.frame.size.width, 0)];
    }

    _currentPage = page;
}


@end
