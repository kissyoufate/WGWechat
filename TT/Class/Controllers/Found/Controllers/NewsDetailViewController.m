//
//  NewsDetailViewController.m
//  TT
//
//  Created by wanggang on 16/9/13.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createWeb];
}

- (void)createWeb{
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.detailURL]]];
    [self.view addSubview:web];
}

@end
