//
//  NativeInfosDemoController.m
//  VLionADSDKDemo
//
//  Created by 张旭 on 2017/12/5.
//  Copyright © 2017年 zhulin. All rights reserved.
//

#import "NativeInfosDemoController.h"
#import <VLionADSDK/VLNADSDK.h>

@interface NativeInfosDemoController () <VLNNativeAdDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray<VLNativeAdInfo *> *datasource;

@property (nonatomic, strong) VLNNativeAd  *ad;

@property (nonatomic, strong) UIView *testView;

@property (nonatomic, assign) CGFloat h;

@end

@implementation NativeInfosDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.datasource = [NSMutableArray array];
    self.testView.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    
    self.h = 100;
    if (!self.nativeAd) {
        self.testView.hidden = YES;
    }
    
    [self addObserver:self forKeyPath:@"ad.adSize" options:(NSKeyValueObservingOptionNew) context:nil];

}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"ad.adSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"ad.adSize"]) {
        if (self.nativeAd) {
            CGSize size = [[change objectForKey:@"new"] CGSizeValue];
            CGRect frame = self.testView.frame;
            
            frame.size = size;
            self.testView.frame = frame;
        }
        else {
            CGSize size = [[change objectForKey:@"new"] CGSizeValue];
            self.h = size.height;
            [self.tableView reloadData];
        }
    }
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)loadData
{
    VLNNativeAd *ad = [[VLNNativeAd alloc] initWithSceneName:self.tagId
                                                      adSize:self.testView.bounds.size
                                                    delegate:self viewController:self];
    [ad loadAd];
    
    self.ad = ad;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *adIdentifier = @"ADCell";
    UITableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:adIdentifier];
    
    if (!tableCell) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adIdentifier];
    }

    
    return tableCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.h;
}

- (void)vl_nativeAdDidLoadSuccess:(VLNNativeAd *)nativeAd nativeAdModels:(NSArray<VLNativeAdInfo *> *)nativeAdModels {
    NSLog(@"nativeAd successToLoad");
    if (self.nativeAd) {
        [nativeAdModels.firstObject renderToView:self.testView];
        
    }
    else {
        [self.datasource addObject:nativeAdModels.firstObject];
        [self.tableView reloadData];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
}
- (void)vl_nativeAdDidClick:(VLNNativeAd *)nativeAd {
    NSLog(@"nativeAd click");
}

- (void)vl_nativeAdExposured:(VLNNativeAd *)nativeAd {
    NSLog(@"nativeAd exposured");
}

- (void)vl_nativeAd:(VLNNativeAd *)nativeAd didFailWithError:(NSError *)error {
    NSLog(@"nativeAd fail %@", error.userInfo[@"NSLocalizedFailureReason"]);
}

- (void)vl_nativeAdDidClickClose:(VLNNativeAd *)nativeAd {
    if (self.testView.subviews.count) {
        [self.testView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    if (self.datasource.count) {
        [self.datasource removeAllObjects];
        [self.tableView reloadData];
    }
}

- (UIView *)testView {
    if (!_testView) {
        _testView = [[UIView alloc] initWithFrame:CGRectMake(50, 200, 300, 400)];
        _testView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_testView];
    }
    return _testView;
}

@end


