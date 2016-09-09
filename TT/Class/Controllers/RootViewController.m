//
//  RootViewController.m
//  TT
//
//  Created by wanggang on 16/9/9.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "RootViewController.h"
#import "EaseConversationListViewController.h"
#import "EaseUsersListViewController.h"
#import "FoundViewController.h"
#import "MineViewController.h"
#import "BaseNavViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //改变状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

    //自身的UI
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    self.tabBar.tintColor = WGColor(0, 190, 12);

    [self setAllControllers];
}

- (void)setAllControllers
{
    EaseConversationListViewController *converVC = [[EaseConversationListViewController alloc] init];
    EaseUsersListViewController *listVC = [[EaseUsersListViewController alloc] init];
    FoundViewController *fVC = [[FoundViewController alloc] init];
    MineViewController *mineVC = [[MineViewController alloc] init];

    NSArray *vcArray = @[converVC,listVC,fVC,mineVC];
    NSArray *disSele = @[@"tabbar_mainframe",@"tabbar_contacts",@"tabbar_discover",@"tabbar_me"];
    NSArray *Select = @[@"tabbar_mainframeHL",@"tabbar_contactsHL",@"tabbar_discoverHL",@"tabbar_meHL"];
    NSArray *titleArray = @[@"消息",@"好友",@"发现",@"个人"];

    NSMutableArray *mArray = [NSMutableArray array];
    [vcArray enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.title = titleArray[idx];
        obj.tabBarItem.image = [[UIImage imageNamed:disSele[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        obj.tabBarItem.selectedImage = [[UIImage imageNamed:Select[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:obj];
        [mArray addObject:nav];
    }];

    self.viewControllers = mArray;
}

@end
