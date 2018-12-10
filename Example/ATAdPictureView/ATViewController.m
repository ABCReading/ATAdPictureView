//
//  ATViewController.m
//  ATAdPictureView
//
//  Created by Spaino on 12/05/2018.
//  Copyright (c) 2018 Spaino. All rights reserved.
//

#import "ATViewController.h"
#import <ATAdPictureView/ATAdPictureView.h>
#import <ATAdPictureView/ATAdPictureViewProtocol.h>
#import "ATPicModel.h"
#import <UIImageView+WebCache.h>
//#import <ATAdPictureView/ATInfiniteScrollView.h> ATInfiniteScrollViewDelegate
@interface ATViewController ()<ATAdPictureViewDelegate>

@end

@implementation ATViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *picSource = @[
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544023872250&di=f3ceda95a005ab766047f6fb9edc7198&imgtype=0&src=http%3A%2F%2Fphotocdn.sohu.com%2F20151014%2FImg423240118.jpg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544023872250&di=cdb68ea2dff0cfc8baf25b7472e941a3&imgtype=0&src=http%3A%2F%2Fimg5.pcpop.com%2FArticleImages%2F730x547%2F3%2F3432%2F003432464.jpg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544023872250&di=f3ceda95a005ab766047f6fb9edc7198&imgtype=0&src=http%3A%2F%2Fphotocdn.sohu.com%2F20151014%2FImg423240118.jpg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544023872250&di=cdb68ea2dff0cfc8baf25b7472e941a3&imgtype=0&src=http%3A%2F%2Fimg5.pcpop.com%2FArticleImages%2F730x547%2F3%2F3432%2F003432464.jpg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544023872250&di=f3ceda95a005ab766047f6fb9edc7198&imgtype=0&src=http%3A%2F%2Fphotocdn.sohu.com%2F20151014%2FImg423240118.jpg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544023872250&di=cdb68ea2dff0cfc8baf25b7472e941a3&imgtype=0&src=http%3A%2F%2Fimg5.pcpop.com%2FArticleImages%2F730x547%2F3%2F3432%2F003432464.jpg"
                           ];
    NSMutableArray *picModels = [NSMutableArray array];
    [picSource enumerateObjectsUsingBlock:^(NSString *obj,
                                            NSUInteger idx,
                                            BOOL * _Nonnull stop) {
        ATPicModel *model = [ATPicModel new];
        model.routerUrl = @"/two/";
        model.adImgURL = [NSURL URLWithString:obj];
        [picModels addObject:model];
    }];
	// Do any additional setup after loading the view, typically from a nib.
    CGFloat w = self.view.bounds.size.width;
    CGFloat h = 200;
    [self.view addSubview:({
        ATAdPictureView *picView = [ATAdPictureView picViewWithLoadImageBlock:^(UIImageView *imageView,
                                                                                NSURL *url) {
            [imageView sd_setImageWithURL:url];
        }];
        picView.bounds = CGRectMake(0, 0, w, h);
        picView.center = self.view.center;
        picView.delegate = self;
        picView.pageControlNormalColor = [UIColor blueColor];
        picView.pageControlHightlightColor = [UIColor blackColor];
        picView.timeInterval = 5;
        picView.picModels = picModels;
        picView;
    })];
}

- (void)adPicViewDidSelectedPicModel:(id<ATAdPictureViewProtocol>)picM {
    NSLog(@"%@---%@", picM.adImgURL, picM.routerUrl);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
