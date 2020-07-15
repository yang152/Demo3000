//
//  NewsOutAdViewController.m
//  VlionAdSDK_3000
//
//  Created by yangting on 2020/7/8.
//  Copyright © 2020 杨挺. All rights reserved.
//

#import "NewsOutAdViewController.h"
#import <VLionNewsSDK/VLionNewsSDK.h>
#import <VLionAdSDK/VLNAdSDK.h>

@interface NewsOutAdViewController ()<UIGestureRecognizerDelegate, VlionAdPageViewDelegate, VLNNativeAdDelegate>
@property (nonatomic, strong) NSMutableDictionary <NSString *, VLNNativeAd *>*ads;
@property (nonatomic, strong) NSMutableDictionary <NSString *, VLNewsAdInfoModel *>*pageMs;

@property (nonatomic, strong) VlionAdPageView *pageView;
@end

@implementation NewsOutAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ads = [NSMutableDictionary dictionary];
    self.pageMs = [NSMutableDictionary dictionary];
    
    VlionAdPageView *view = [[VlionAdPageView alloc] initWithFrame:self.view.bounds sceneName:@"scene" currentVC:self];
    view.delegate = self;
    [self.view addSubview:view];
    self.pageView = view;
    
    self.title = @"自己在外部调用瑞狮的广告";

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.pageView.frame = self.view.bounds;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}
#pragma mark --VlionAdPageViewDelegate
- (BOOL)vlionAdPageView:(VlionAdPageView *_Nullable)pageView didLoadAdInfo:(VLNewsAdInfoModel *_Nullable)adInfoModel titleIndex:(NSInteger)titleIndex {
//    BOOL allowUserDefine = arc4random()%100%2;
//    if (allowUserDefine) {
        VLNNativeAd *ad = [[VLNNativeAd alloc] initWithSceneName:@"scene"];
        ad.delegate = self;
        ad.viewController = self;
        [self.ads setObject:ad forKey:adInfoModel.adUniqueId];
        [self.pageMs setObject:adInfoModel forKey:adInfoModel.adUniqueId];

        [ad loadAdData];
//    }
//
//    return allowUserDefine;
    return YES;
}
#pragma mark --VLNNativeAdDelegate
/**
 *  原生广告加载广告数据成功回调，返回为VLionNativeAdModel对象
 */
- (void)nativeAd:(VLNNativeAd *)nativeAd successToLoad:(VLNNativeAdModel *)nativeAdModel {
    __block VLNewsAdInfoModel *info;
    [self.ads enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, VLNNativeAd * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj == nativeAd) {
            info = [self.pageMs objectForKey:key];
            *stop = YES;
        }
    }];
    
    UIView *adView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 0.5)];
    info.adView = adView;
    
    [VLNNativeAd registerAdModel:nativeAdModel toView:info.adView];
    [self.pageView updateView];
}

/**
 *  原生广告加载广告数据失败回调
 */
- (void)nativeAd:(VLNNativeAd *)nativeAd didFailWithError:(NSError *)error {
    NSLog(@"-------error-----%@", error);
}

/**
 广告曝光回调
 */
- (void)nativeAdExposured:(VLNNativeAd *)nativeAd {
    
    __block VLNewsAdInfoModel *info;
    [self.ads enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, VLNNativeAd * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj == nativeAd) {
            info = [self.pageMs objectForKey:key];
            *stop = YES;
        }
    }];
    
    info.adHeight = nativeAd.adSize.height;
    
    [self.pageView updateView];
}

- (void)nativeAdDidClickClose:(VLNNativeAd *)nativeAd {
    __block VLNewsAdInfoModel *info;
    [self.ads enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, VLNNativeAd * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj == nativeAd) {
            info = [self.pageMs objectForKey:key];
            *stop = YES;
        }
    }];
    [self.pageView deleteAdInfoModel:info];
}

@end
