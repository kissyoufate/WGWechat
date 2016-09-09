//
//  RegistViewController.m
//  TT
//
//  Created by wanggang on 16/9/9.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "RegistViewController.h"
#import "RootViewController.h"

@interface RegistViewController ()

@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passwordRepeat;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)putTheRegist:(id)sender {
    if ([_account.text isEqualToString:@""] || [_password.text isEqualToString:@""] || [_passwordRepeat.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"注册信息不完整" toView:self.view];
        return;
    }

    if (![_password.text isEqualToString:_passwordRepeat.text]) {
        [MBProgressHUD showError:@"两次输入的密码不一致" toView:self.view];
        return;
    }

    [MBProgressHUD showMessag:@"正在注册" toView:self.view];
    EMError *error = [[EMClient sharedClient] registerWithUsername:_account.text password:_passwordRepeat.text];
    if (error==nil) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showSuccess:@"注册成功,现在登录" toView:self.view];

        [[EMClient sharedClient] loginWithUsername:_account.text password:_passwordRepeat.text completion:^(NSString *aUsername, EMError *aError) {

            EMMessage *message = [EaseSDKHelper sendTextMessage:@"我刚注册,请小哥指导"
                                                             to:@"wanggang"//接收方
                                                    messageType:EMChatTypeChat//消息类型
                                                     messageExt:nil]; //扩展信息
            [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
                //
            } completion:^(EMMessage *message, EMError *error) {
                //
            }];

            RootViewController *rvc = [[RootViewController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = rvc;
        }];
    }else{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@",error] toView:self.view];
    }
}

- (IBAction)noRegist:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}


@end
