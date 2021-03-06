//
//  RewardVideoViewController.m
//  VLionADSDKDemo
//
//  Created by 1 on 2019/6/10.
//  Copyright © 2019 zhulin. All rights reserved.
//

#import "RewardVideoViewController.h"
#import <VLionADSDK/VLNADSDK.h>

@interface RewardVideoViewController ()<VLNRewardedVideoAdDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) VLNRewardedVideoAd *rewardVideoAdAd;

@property (nonatomic, strong) UIButton *loadButton;
@property (nonatomic, strong) UIButton *showButton;

@end

@implementation RewardVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.rewardVideoAdAd = [[VLNRewardedVideoAd alloc] initWithSceneName:self.tagId];
    self.rewardVideoAdAd.delegate = self;
    [self.rewardVideoAdAd loadAd];
    
    self.showButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.showButton.frame = CGRectMake(0, 0, 200, 40);
    [self.showButton setBackgroundColor:[UIColor grayColor]];
    self.showButton.center = self.view.center;
    [self.showButton setTitle:@"展示广告" forState:UIControlStateNormal];
    [self.showButton addTarget:self action:@selector(showAd) forControlEvents:UIControlEventTouchUpInside];
    self.showButton.enabled = NO;
    [self.view addSubview:self.showButton];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)loadAd {
    self.rewardVideoAdAd = [[VLNRewardedVideoAd alloc] initWithSceneName:self.tagId];
    self.rewardVideoAdAd.delegate = self;
    [self.rewardVideoAdAd loadAd];
}

- (void)showAd {
    [self.rewardVideoAdAd showAdFromRootViewController:self];
}

- (void)vl_rewardVideoAdDidLoad:(VLNRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"数据加载成功");
    self.showButton.enabled = YES;
    self.showButton.backgroundColor = [UIColor blueColor];
}

- (void)vl_rewardVideoAdVideoDidLoad:(VLNRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"视频加载成功");
}

- (void)vl_rewardVideoAdWillVisible:(VLNRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"视频将要展示");
}

- (void)vl_rewardVideoAdDidExposed:(VLNRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"视频曝光");
}

- (void)vl_rewardVideoAdDidClose:(VLNRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"视频关闭");
}

- (void)vl_rewardVideoAdDidClicked:(VLNRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"视频点击");
}


- (void)vl_rewardVideoAd:(VLNRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    NSLog(@"出错");
}

- (void)vl_rewardVideoAdDidRewardEffective:(VLNRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"达到激励条件");
}

- (void)vl_rewardVideoAdDidPlayFinish:(VLNRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"播放完成");
}

-(BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
