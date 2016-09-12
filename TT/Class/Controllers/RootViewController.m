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

@interface RootViewController () <EMContactManagerDelegate,EMChatManagerDelegate>

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

    //好友添加相关delegat
    [[EMClient sharedClient].contactManager addDelegate:self];
    //收到消息的代理
    [[EMClient sharedClient].chatManager addDelegate:self];
    //主动调用获取未读的消息,添加角标
    [self getUnreadMessageCount];
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

#pragma mark - EMChatManagerDelegate 收到消息相关的bage提示
- (void)messagesDidReceive:(NSArray *)aMessages{
    [self getUnreadMessageCount];
}

- (void)getUnreadMessageCount{
    NSArray *conver = [[EMClient sharedClient].chatManager getAllConversations];
    NSInteger unread = 0;
    for (EMConversation *con in conver) {
        unread += con.unreadMessagesCount;
    }

    UITabBarItem *item = [self.tabBar.items objectAtIndex:0];
    item.badgeValue = [NSString stringWithFormat:@"%ld",(long)unread];
}

#pragma mark - EMContactManagerDelegate  好友相关操作
//收到好友添加 进行同意||拒绝的操作
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername message:(NSString *)aMessage{
    UIAlertController *avc = [UIAlertController alertControllerWithTitle:@"好友添加提示" message:[NSString
                                                                                          stringWithFormat:@"%@ 想添加您为好友并说:%@",aUsername,aMessage] preferredStyle:
                              UIAlertControllerStyleAlert];
    UIAlertAction *at1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:aUsername];
        if (!error) {
            [MBProgressHUD showSuccess:@"已添加" toView:self.view];
        }
    }];
    UIAlertAction *at2 = [UIAlertAction actionWithTitle:@"算了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:aUsername];
        if (!error) {
            [MBProgressHUD showSuccess:@"拒绝了对方的好友申请" toView:self.view];
        }
    }];
    [avc addAction:at1];
    [avc addAction:at2];
    [self presentViewController:avc animated:YES completion:^{
        
    }];
}

//收到了同意添加
- (void)friendRequestDidApproveByUser:(NSString *)aUsername{
    [MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@ 同意了您的好友申请",aUsername] toView:self.view];
}

//收到了拒绝添加
- (void)friendRequestDidDeclineByUser:(NSString *)aUsername{
    [MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@ 拒绝了您的好友申请😀",aUsername] toView:self.view];
}

@end
