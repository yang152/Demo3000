//
//  NativeAdListsController.m
//  VLionADSDKDemo
//
//  Created by 张旭 on 2017/10/16.
//  Copyright © 2017年 zhulin. All rights reserved.
//

#import "NativeAdListsController.h"
#import "NativeInfosDemoController.h"
#import "NativeDemoTableViewListVC.h"

#define IPHONEX  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define H_SPACE     (self.view.bounds.size.height-250)/2

@interface NativeAdListsController ()<UIGestureRecognizerDelegate>
{
    NSString *_imgUrl;
    id currentMdl;
}

@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIButton *xuanRanBtn;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation NativeAdListsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];


    self.dataSource = @[
                        @{
                                @"title": @"信息流tableview模式demo",
                                @"tagId": @"scene",
                            },
                            @{
                                @"title": @"nativeAd",
                                @"tagId": @"scene",
                            },
                        ];
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *adCell = @"adCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adCell];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:adCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row][@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        NSDictionary *data = self.dataSource[indexPath.row];
        NativeInfosDemoController *demoVc = [[NativeInfosDemoController alloc] init];
        demoVc.tagId = data[@"tagId"];
        demoVc.nativeAd = YES;
        [self.navigationController pushViewController:demoVc animated:YES];
    }
    else if (indexPath.row == 0) {
        NativeDemoTableViewListVC *vc = [NativeDemoTableViewListVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
@end
