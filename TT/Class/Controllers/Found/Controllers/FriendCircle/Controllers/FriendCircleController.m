//
//  FriendCircleController.m
//  TT
//
//  Created by wanggang on 2016/10/8.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "FriendCircleController.h"
#import "FriendCircleModel.h"
#import "FriendCircleCell.h"

@interface FriendCircleController () <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataArray;
    int page;
}

@property (nonatomic,strong)UITableView *tb;

@end

@implementation FriendCircleController

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    [self loadData];
}

- (void)loadData{
    NSDictionary *dataDic = [self theData];
    if (!dataArray) {
        dataArray = [NSMutableArray array];
    }else if (dataArray && page == 1){
        [dataArray removeAllObjects];
    }
    for (id obj in dataDic[@"data"]) {
        FriendCircleModel *model = [FriendCircleModel mj_objectWithKeyValues:obj];
        [dataArray addObject:model];
    }
    if (self.tb) {
        [self.tb reloadData];
    }else
        [self createtb];
    [self.tb.mj_header endRefreshing];
    [self.tb.mj_footer endRefreshing];
}

- (void)createtb{
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kView_W, kView_H - 64) style:UITableViewStylePlain];
    self.tb.delegate = self;
    self.tb.dataSource = self;
    [self.tb setTableFooterView:[UIView new]];
    [self.view addSubview:self.tb];

    self.tb.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [self loadData];
    }];

    self.tb.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self loadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tb cellHeightForIndexPath:indexPath model:dataArray[indexPath.row] keyPath:@"model" cellClass:[FriendCircleCell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCircleCell"];
    if (!cell) {
        cell = [[FriendCircleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendCircleCell"];
    }
    cell.model = dataArray[indexPath.row];
    return cell;
}

#pragma mark - 模拟数据
- (NSDictionary *)theData{
    NSDictionary *dateDic = @{
                              @"data":@[
                                      @{
                                          @"name":@"张三",
                                          @"time":@"2015.01.01 23:05",
                                          @"content":@"这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长这是一条内容,内容可能会很长",
                                          @"images":@[@"f01",@"f02",@"f03"],
                                          @"feelGood":@[@"李四",@"名字1",@"路人甲",@"路人乙",@"起哦",@"4221",@"名字2",@"名字随机",@"哈哈2",@"767",@"佛去武汉",@"uouo",@"的前雾灯",@"路人",@"欧元"],
                                          @"coments":@[
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  ]
                                          },
                                      @{
                                          @"name":@"张三",
                                          @"time":@"2015.01.01 23:05",
                                          @"content":@"这是一条内容,内容可能会很长",
                                          @"images":@[@"f01",@"f02",@"f03",@"f04",@"f05",@"f06",@"f07"],
                                          @"feelGood":@[@"李四",@"名字1",@"路人甲",@"路人乙",@"起哦",@"4221",@"名字2",@"名字随机",@"哈哈2",@"767",@"佛去武汉",@"uouo",@"的前雾灯",@"路人",@"欧元"],
                                          @"coments":@[
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  ]
                                          },
                                      @{
                                          @"name":@"张三",
                                          @"time":@"2015.01.01 23:05",
                                          @"content":@"这是一条内容,内容可能会很长",
                                          @"images":@[@"f01",@"f02"],
                                          @"feelGood":@[@"李四",@"名字1",@"路人甲",@"路人乙",@"起哦",@"4221",@"名字2",@"名字随机",@"哈哈2",@"767",@"佛去武汉",@"uouo",@"的前雾灯",@"路人",@"欧元"],
                                          @"coments":@[
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  ]
                                          },
                                      @{
                                          @"name":@"张三",
                                          @"time":@"2015.01.01 23:05",
                                          @"content":@"这是一条内容,内容可能会很长",
                                          @"images":@[@"f01",@"f02",@"f04"],
                                          @"feelGood":@[@"李四",@"名字1",@"路人甲",@"路人乙",@"起哦",@"4221",@"名字2",@"名字随机",@"哈哈2",@"767",@"佛去武汉",@"uouo",@"的前雾灯",@"路人",@"欧元"],
                                          @"coments":@[
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  ]
                                          },
                                      @{
                                          @"name":@"张三",
                                          @"time":@"2015.01.01 23:05",
                                          @"content":@"这是一条内容,内容可能会很长",
                                          @"images":@[@"f01",@"f02",@"f03",@"f04",@"f05"],
                                          @"feelGood":@[@"李四",@"名字1",@"路人甲",@"路人乙",@"起哦",@"4221",@"名字2",@"名字随机",@"哈哈2",@"767",@"佛去武汉",@"uouo",@"的前雾灯",@"路人",@"欧元"],
                                          @"coments":@[
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  ]
                                          },
                                      @{
                                          @"name":@"张三",
                                          @"time":@"2015.01.01 23:05",
                                          @"content":@"这是一条内容,内容可能会很长",
                                          @"images":@[@"f01",@"f02",@"f03",@"f04",@"f05"],
                                          @"feelGood":@[@"李四",@"名字1",@"路人甲",@"路人乙",@"起哦",@"4221",@"名字2",@"名字随机",@"哈哈2",@"767",@"佛去武汉",@"uouo",@"的前雾灯",@"路人",@"欧元"],
                                          @"coments":@[
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  ]
                                          },
                                      @{
                                          @"name":@"张三",
                                          @"time":@"2015.01.01 23:05",
                                          @"content":@"这是一条内容,内容可能会很长",
                                          @"images":@[@"f01",@"f02",@"f03",@"f04",@"f05"],
                                          @"feelGood":@[@"李四",@"名字1",@"路人甲",@"路人乙",@"起哦",@"4221",@"名字2",@"名字随机",@"哈哈2",@"767",@"佛去武汉",@"uouo",@"的前雾灯",@"路人",@"欧元"],
                                          @"coments":@[
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  ]
                                          },
                                      @{
                                          @"name":@"张三",
                                          @"time":@"2015.01.01 23:05",
                                          @"content":@"这是一条内容,内容可能会很长",
                                          @"images":@[@"f01",@"f02",@"f03",@"f04",@"f05",@"f08",@"f04",@"f05",@"f08"],
                                          @"feelGood":@[@"李四",@"名字1",@"路人甲",@"路人乙",@"起哦",@"4221",@"名字2",@"名字随机",@"哈哈2",@"767",@"佛去武汉",@"uouo",@"的前雾灯",@"路人",@"欧元"],
                                          @"coments":@[
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  ]
                                          },
                                      @{
                                          @"name":@"张三",
                                          @"time":@"2015.01.01 23:05",
                                          @"content":@"这是一条内容,内容可能会很长",
                                          @"images":@[@"f01",@"f02",@"f03",@"f04",@"f05"],
                                          @"feelGood":@[@"李四",@"名字1",@"路人甲",@"路人乙",@"起哦",@"4221",@"名字2",@"名字随机",@"哈哈2",@"767",@"佛去武汉",@"uouo",@"的前雾灯",@"路人",@"欧元"],
                                          @"coments":@[
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  ]
                                          },
                                      @{
                                          @"name":@"张三",
                                          @"time":@"2015.01.01 23:05",
                                          @"content":@"这是一条内容,内容可能会很长",
                                          @"images":@[@"f01",@"f02"],
                                          @"feelGood":@[@"李四",@"名字1",@"路人甲",@"路人乙",@"起哦",@"4221",@"名字2",@"名字随机",@"哈哈2",@"767",@"佛去武汉",@"uouo",@"的前雾灯",@"路人",@"欧元"],
                                          @"coments":@[
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  @{
                                                      @"comentName":@"评论人名字",
                                                      @"comentContent":@"评论的内容.......可能会有很多的"
                                                      },
                                                  ]
                                          }
                                      ]
                              };
    return dateDic;
}

@end
