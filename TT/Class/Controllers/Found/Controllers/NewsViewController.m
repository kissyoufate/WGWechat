//
//  NewsViewController.m
//  TT
//
//  Created by wanggang on 16/9/13.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCategaryViewController.h"
#import "LoginViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setAllControllers];

    [self configCateUI];

    if (![EMClient sharedClient].currentUsername) {
        [NSTimer scheduledTimerWithTimeInterval:20.0f target:self selector:@selector(shouldLogin) userInfo:nil repeats:YES];
        [self setLoginButton];
    }
}

#pragma mark - 没有登录的情况下提示用户 设置登录的按钮方便用户进行操作
- (void)shouldLogin{
    [MBProgressHUD showSuccess:@"如果喜欢可以注册个号玩一下" toView:self.view];
}

- (void)setLoginButton{
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.frame = CGRectMake(0, 0, 44, 44);
    [b setTitle:@"登录" forState:UIControlStateNormal];
    [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    b.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [b addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:b];
}

- (void)login{
    [UIApplication sharedApplication].keyWindow.rootViewController = [LoginViewController new];
}

- (void)configCateUI{
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *titleScrollViewColor = [UIColor whiteColor];
        *titleFont = [UIFont systemFontOfSize:16.0f];
        *norColor = [UIColor lightGrayColor];
        *selColor = WGColor(85, 85, 85);
    }];

    [self setUpCoverEffect:^(UIColor *__autoreleasing *coverColor, CGFloat *coverCornerRadius) {
        *coverColor = WGColor(0, 190, 12);
        *coverCornerRadius = 10.0f;
    }];

    self.isfullScreen = NO;
}

- (void)setAllControllers{
    NSArray *urlArray = @[
                          @"http://api.sina.cn/sinago/list.json?channel=news_toutiao",
                          @"http://api.sina.cn/sinago/list.json?channel=video_highlights",
                          @"http://api.sina.cn/sinago/list.json?channel=news_ent",
                          @"http://api.sina.cn/sinago/list.json?channel=news_funny",
                          @"http://api.sina.cn/sinago/list.json?channel=hdpic_pretty",
                          @"http://api.sina.cn/sinago/list.json?channel=news_tech"
                          ];
    NSArray *nameArray = @[
                           @"头条",
                           @"震惊",
                           @"娱乐",
                           @"搞笑",
                           @"明星",
                           @"科技"
                           ];

    for (int i = 0; i < urlArray.count; i ++) {
        NewsCategaryViewController *newscateVC = [[NewsCategaryViewController alloc] init];
        newscateVC.postURL = urlArray[i];
        newscateVC.title = nameArray[i];
        [self addChildViewController:newscateVC];
    }
}

@end
