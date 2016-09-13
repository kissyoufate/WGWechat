//
//  NewsCategaryViewController.m
//  TT
//
//  Created by wanggang on 16/9/13.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "NewsCategaryViewController.h"
#import "NewsCateModel.h"
#import "NewsCategaryCell.h"
#import "NewsDetailViewController.h"

@interface NewsCategaryViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataArray;
    UITableView *myTB;
}

@end

@implementation NewsCategaryViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (myTB && myTB.contentOffset.y==0) {
        [myTB.mj_header beginRefreshing];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
}

- (void)loadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:self.postURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (!dataArray) {
            dataArray = [NSMutableArray array];
        }else{
            [dataArray removeAllObjects];
        }

        for (id obj in responseObject[@"data"][@"list"]) {
            NewsCateModel *model = [NewsCateModel mj_objectWithKeyValues:obj];
            [dataArray addObject:model];
        }

        if (!myTB) {
            [self createTB];
        }else{
            [myTB reloadData];
        }

        [myTB.mj_header endRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

- (void)createTB{
    myTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kView_W, kView_H - 64) style:UITableViewStyleGrouped];
    myTB.delegate = self;
    myTB.dataSource = self;
    myTB.separatorInset = UIEdgeInsetsMake(0, 12, 0, 0);
    [self.view addSubview:myTB];
    
    myTB.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];

    myTB.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [MBProgressHUD showSuccess:@"暂不兹瓷加载更多" toView:self.view];
        [myTB.mj_footer endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCategaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCategaryCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCategaryCell" owner:self options:nil] lastObject];
    }
    cell.model = dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetailViewController *ndVC = [[NewsDetailViewController alloc] init];
    ndVC.detailURL = [dataArray[indexPath.row] link];
    ndVC.title = @"详情资讯";
    [self.navigationController pushViewController:ndVC animated:YES];
}

@end
