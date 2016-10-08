//
//  MyCallViewController.m
//  TT
//
//  Created by wanggang on 2016/9/22.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "MyCallViewController.h"

@interface MyCallViewController () <EMCallManagerDelegate>

@end

@implementation MyCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];

    [[EMClient sharedClient].callManager addDelegate:self];
}

- (void)setUI{
    //⬇️创建通话UI
    _mySession.videoBitrate = 200;
    //1.对方窗口
    _mySession.remoteVideoView = [[EMCallRemoteView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60)];
    [self.view addSubview:_mySession.remoteVideoView];
    //2.自己窗口
    CGFloat width  = 150;
    CGFloat height = 200;
    _mySession.localVideoView = [[EMCallLocalView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 150, self.view.frame.size.height - 200, width, height)];
    [self.view addSubview:_mySession.localVideoView];
    //取消按钮
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.frame = CGRectMake(0, 20, self.view.frame.size.width, 40);
    b.backgroundColor = [UIColor redColor];
    [b setTitle:@"结束通话" forState:UIControlStateNormal];
    [b addTarget:self action:@selector(endCallLLL:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
}

- (void)endCallLLL:(UIButton *)b{
    [[EMClient sharedClient].callManager endCall:_mySession.sessionId reason:EMCallEndReasonHangup];
    [self cancelCallView];
}

- (void)cancelCallView{
    [MBProgressHUD showSuccess:@"视频结束" toView:self.view];
    [self dismissViewControllerAnimated:YES completion:^{
        [[EMClient sharedClient].callManager removeDelegate:self];
    }];
}

- (void)callDidConnect:(EMCallSession *)aSession{
    [MBProgressHUD showSuccess:@"callDidConnect" toView:self.view];
    [[EMClient sharedClient].callManager resumeVideoWithSession:aSession.sessionId error:nil];
}

- (void)callDidAccept:(EMCallSession *)aSession{

}

- (void)callDidEnd:(EMCallSession *)aSession reason:(EMCallEndReason)aReason error:(EMError *)aError{
    [self cancelCallView];
}

@end
