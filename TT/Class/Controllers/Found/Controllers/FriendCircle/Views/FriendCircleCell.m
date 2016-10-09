//
//  FriendCircleCell.m
//  TT
//
//  Created by wanggang on 2016/10/8.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "FriendCircleCell.h"

@implementation FriendCircleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}

- (void)setup{
    //头像,姓名,时间,内容
    UIButton *iconb = [UIButton buttonWithType:UIButtonTypeCustom];
    [iconb setBackgroundImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    iconb.layer.masksToBounds = YES;
    iconb.layer.cornerRadius = 20.0f;
    [self.contentView addSubview:iconb];

    UILabel *namel = [UILabel new];
    namel.textColor = WGColor(85, 85, 85);
    namel.font = WGFont(13.0f);
    [self.contentView addSubview:namel];

    UILabel *timel = [UILabel new];
    timel.textColor = [UIColor grayColor];
    timel.font = WGFont(12.0f);
    [self.contentView addSubview:timel];

    UILabel *conl = [UILabel new];
    conl.textColor = WGColor(85, 85, 85);
    conl.font = WGFont(13.0f);
    [self.contentView addSubview:conl];

    _iconButton = iconb;
    _nameLabel = namel;
    _timeLabel = timel;
    _contentLabel = conl;

    //照片,点赞,评论
    FriendImagesView *piv = [FriendImagesView new];
    [self.contentView addSubview:piv];

    UILabel *goodl = [UILabel new];
    goodl.textColor = WGColor(85, 85, 85);
    goodl.font = WGFont(12.0f);
    goodl.backgroundColor = WGColor(213, 213, 213);
    goodl.numberOfLines = 0;
    [self.contentView addSubview:goodl];

    FriendsCommentsView *fcv = [FriendsCommentsView new];
    fcv.backgroundColor = WGColor(213, 213, 213);
    [self.contentView addSubview:fcv];

    _friendPhotos = piv;
    _goodLabel = goodl;
    _friendsComments = fcv;

    _iconButton.sd_layout.leftSpaceToView(self.contentView,12.0f).topSpaceToView(self.contentView,12.0f).widthIs(40.0f).heightIs(40.0f);
    _nameLabel.sd_layout.leftSpaceToView(_iconButton,10.0f).topSpaceToView(self.contentView,12.0f).widthIs(200.0f).heightIs(20.0f);
    _timeLabel.sd_layout.leftSpaceToView(_iconButton,10.0f).topSpaceToView(_nameLabel,5.0f).widthIs(200.0f).heightIs(15.0f);
    _contentLabel.sd_layout.leftSpaceToView(self.contentView,12.0f).topSpaceToView(_timeLabel,5.0f).rightSpaceToView(self.contentView,12.0f).autoHeightRatio(0);
    _friendPhotos.sd_layout.leftSpaceToView(self.contentView,12.0f).topSpaceToView(_contentLabel,10.0f);//宽高内部实现
    _goodLabel.sd_layout.leftSpaceToView(self.contentView,12.0f).topSpaceToView(_friendPhotos,5.0f).rightSpaceToView(self.contentView,12.0f).autoHeightRatio(0);
    _friendsComments.sd_layout.leftSpaceToView(self.contentView,12.0f).topSpaceToView(_goodLabel,5.0f).rightSpaceToView(self.contentView,12.0f);
}

- (void)setModel:(FriendCircleModel *)model{
    _model = model;
    _nameLabel.text = model.name;
    _timeLabel.text = model.time;
    _contentLabel.text = model.content;
    _friendPhotos.imageArr = model.images;
    _goodLabel.text = [NSString stringWithFormat:@"%@ 等%ld人觉得您的说说很赞!",[model.feelGood componentsJoinedByString:@","],model.feelGood.count];
    _friendsComments.comArray = model.coments;

    //高度适应
    [self setupAutoHeightWithBottomView:_friendsComments bottomMargin:10.0f];
}

@end
