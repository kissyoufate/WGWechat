//
//  LoginViewController.m
//  TT
//
//  Created by wanggang on 16/9/9.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "RootViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)login:(id)sender {
    [MBProgressHUD showMessag:@"登录中" toView:self.view];
    [[EMClient sharedClient] loginWithUsername:_account.text password:_password.text completion:^(NSString *aUsername, EMError *aError) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        RootViewController *rvc = [[RootViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = rvc;
    }];
}

- (IBAction)regist:(id)sender {
    RegistViewController *rVC = [[RegistViewController alloc] init];
    [self presentViewController:rVC animated:YES completion:^{

    }];
}

- (IBAction)QQlogin:(id)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {

             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }

         else
         {
             NSLog(@"%@",error);
         }

     }];
}

- (IBAction)weixinLogin:(id)sender {
    [MBProgressHUD showError:@"程序小哥的微信平台账号密码忘记了,没搞到授权" toView:self.view];
}

- (IBAction)weiboLogin:(id)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {

             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }

         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}


@end
