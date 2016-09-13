//
//  NewsCategaryCell.h
//  TT
//
//  Created by wanggang on 16/9/13.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsCateModel.h"

@interface NewsCategaryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *topicPic;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic,strong)NewsCateModel *model;

@end
