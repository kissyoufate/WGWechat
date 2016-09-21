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

@interface RootViewController () <EMContactManagerDelegate,EMChatManagerDelegate,EMCallManagerDelegate>
{
    EMCallSession *ase;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //改变状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

    //自身的UI
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = WGColor(0, 190, 12);

    [self setAllControllers];

    //好友添加相关delegat
    [[EMClient sharedClient].contactManager addDelegate:self];
    //收到消息的代理
    [[EMClient sharedClient].chatManager addDelegate:self];
    //收到即时视频/语音的代理
    [[EMClient sharedClient].callManager addDelegate:self];
    //主动调用获取未读的消息,添加角标
    [self getUnreadMessageCount];
}

- (void)setAllControllers{
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

#pragma mark - EMCallManagerDelegate 收到即时视频,语音相关
- (void)callDidReceive:(EMCallSession *)aSession{
    NSLog(@"我收到了一个即时的视频邀请");
    //默认逻辑为接受
    [[EMClient sharedClient].callManager answerIncomingCall:aSession.sessionId];
}

- (void)callDidConnect:(EMCallSession *)aSession{
    ase = aSession;
    [MBProgressHUD showSuccess:@"通讯建立完成" toView:self.view];

    aSession.videoBitrate = 150;
    //1.对方窗口
    aSession.remoteVideoView = [[EMCallRemoteView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:aSession.remoteVideoView];

    //2.自己窗口
    CGFloat width  = 150;
    CGFloat height = 200;
    aSession.localVideoView = [[EMCallLocalView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 150, self.view.frame.size.height - 200, width, height)];
    [self.view addSubview:aSession.localVideoView];

    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    b.backgroundColor = [UIColor redColor];
    [b setTitle:@"结束通话" forState:UIControlStateNormal];
    [b addTarget:self action:@selector(endCallLLL:) forControlEvents:UIControlEventTouchUpInside];
    [aSession.remoteVideoView addSubview:b];
}

- (void)endCallLLL:(UIButton *)b{
    [[EMClient sharedClient].callManager endCall:ase.sessionId reason:EMCallEndReasonHangup];
    [self cancelCallView];

    [b removeFromSuperview];
}

- (void)callDidEnd:(EMCallSession *)aSession reason:(EMCallEndReason)aReason error:(EMError *)aError{
    [self cancelCallView];
}

- (void)cancelCallView{
    [ase.remoteVideoView removeFromSuperview];
    [ase.localVideoView removeFromSuperview];
    ase.remoteVideoView  = nil;
    ase.localVideoView = nil;
    ase = nil;
}


#pragma mark - EMChatManagerDelegate 收到消息相关的bage提示
- (void)messagesDidReceive:(NSArray *)aMessages{
    [self getUnreadMessageCount];

    UIApplication *app = [UIApplication sharedApplication];
    if (app.applicationState == UIApplicationStateBackground) {
        //当程序在后台最小化的时候就收到此本地通知
        [self sendLocal];
    }
}

- (void)sendLocal{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate date];
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    //重复次数
    notification.repeatInterval = 0;
    // 通知内容
    notification.alertBody =  @"您收到了一条新的消息";
    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"一个最帅的程序员" forKey:@"key"];
    notification.userInfo = userDict;

    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
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
