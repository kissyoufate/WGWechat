//
//  FoundViewController.m
//  TT
//
//  Created by wanggang on 16/9/9.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "FoundViewController.h"
#import "NewsViewController.h"
#import "FriendCircleController.h"

@interface FoundViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTB;
}

@end

@implementation FoundViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI{
    myTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kView_W, kView_H) style:UITableViewStyleGrouped];
    myTB.delegate = self;
    myTB.dataSource = self;
    [self.view addSubview:myTB];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"恬恬圈";
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"火热资讯";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        NewsViewController *nVC = [[NewsViewController alloc] init];
        nVC.title = @"火爆资讯";
        [self.navigationController pushViewController:nVC animated:YES];
    }else if (indexPath.section == 0){
        FriendCircleController *fVC = [[FriendCircleController alloc] init];
        fVC.title = @"朋友圈";
        [self.navigationController pushViewController:fVC animated:YES];
    }
}

@end
