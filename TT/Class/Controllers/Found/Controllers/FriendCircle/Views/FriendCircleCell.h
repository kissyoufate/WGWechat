//
//  FriendCircleCell.h
//  TT
//
//  Created by wanggang on 2016/10/8.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendCircleModel.h"
#import "FriendImagesView.h"

@interface FriendCircleCell : UITableViewCell

@property (nonatomic,strong)FriendCircleModel *model;

@property (nonatomic,strong)UIButton *iconButton;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)FriendImagesView *friendPhotos;

@end
