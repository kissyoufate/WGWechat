//
//  BaseNavViewController.m
//  TT
//
//  Created by wanggang on 16/9/9.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:WGColor(85, 85, 85)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0f]}];

    if (self.childViewControllers.count > 0) {
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = CGRectMake(0, 0, 22, 22);
        [b setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [b addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];

        UIBarButtonItem *bi = [[UIBarButtonItem alloc] initWithCustomView:b];
        viewController.navigationItem.leftBarButtonItem = bi;

        self.tabBarController.tabBar.hidden = YES;
    }
    [super pushViewController:viewController animated:YES];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
