//
//  AddFriendViewController.m
//  TT
//
//  Created by wanggang on 16/9/12.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "AddFriendViewController.h"

@interface AddFriendViewController () <UISearchControllerDelegate,UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate>
{
    UISearchController *searchVC;
    UITableView *myTB;
    NSArray *nameArray;
}

@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{
    searchVC = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchVC.delegate = self;
    searchVC.searchResultsUpdater = self;
    //搜索时，背景变暗色
    searchVC.dimsBackgroundDuringPresentation = NO;
    //搜索时，背景变模糊
    searchVC.obscuresBackgroundDuringPresentation = NO;
    //隐藏导航栏
    searchVC.hidesNavigationBarDuringPresentation = NO;
    searchVC.searchBar.frame = CGRectMake(0, 0, kView_W, 44.0);
    //searchBar 取消按钮颜色
    searchVC.searchBar.tintColor = WGColor(85, 85, 85);
    //修改cancel为@"取消"
    for (id obj in searchVC.searchBar.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *b = (UIButton *)obj;
            [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [b setTitle:@"取消" forState:UIControlStateNormal];
        }
    }

    [self.view addSubview:searchVC.searchBar];

    myTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kView_W, kView_H - 44) style:UITableViewStylePlain];
    myTB.delegate = self;
    myTB.dataSource = self;
    [myTB setTableFooterView:[UIView new]];
    [self.view addSubview:myTB];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = searchVC.searchBar.text;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self easeAddFriend];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [myTB reloadData];
}

#pragma mark - 添加好友方法
- (void)easeAddFriend{
    UIAlertController *avc = [UIAlertController alertControllerWithTitle:@"添加提示" message:[NSString
                                                                                          stringWithFormat:@"确认要添加:%@为 好友么",searchVC.searchBar.text] preferredStyle:
                              UIAlertControllerStyleAlert];
    UIAlertAction *at1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        EMError *error = [[EMClient sharedClient].contactManager addContact:[NSString stringWithFormat:@"%@",searchVC.searchBar.text] message:@"我想加您为好友"];
        if (!error) {
            [MBProgressHUD showSuccess:@"申请发送成功,请等待对方回应!" toView:self.view];
        }
    }];
    UIAlertAction *at2 = [UIAlertAction actionWithTitle:@"算了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    [avc addAction:at1];
    [avc addAction:at2];
    [self presentViewController:avc animated:YES completion:^{

    }];
}

@end
