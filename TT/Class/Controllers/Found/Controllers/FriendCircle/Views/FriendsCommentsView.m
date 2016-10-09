//
//  FriendsCommentsView.m
//  TT
//
//  Created by wanggang on 2016/10/9.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "FriendsCommentsView.h"
#import "FriendCircleModel.h"

@class Coments;

@implementation FriendsCommentsView
{
    NSMutableArray *labelArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = WGColor(213, 213, 213);
}

- (void)setComArray:(NSArray *)comArray{
    if (!labelArray) {
        labelArray = [NSMutableArray array];
    }

    //无评论
    if (comArray.count == 0) {
        self.height = 0;
        return;
    }

    //有评论
    int haveLabelCount = labelArray.count;
    int needLabelCount = comArray.count>haveLabelCount?(comArray.count-haveLabelCount):0;
    for (int i = 0; i < needLabelCount; i ++) {
        UILabel *l = [UILabel new];
        l.font = WGFont(12.0f);
        l.textColor = WGColor(85, 85, 85);
        l.backgroundColor = WGColor(213, 213, 213);
        [self addSubview:l];
        [labelArray addObject:l];
    }
    //加载评论内容
    for (int i = 0; i < comArray.count; i++) {
        UILabel *l = (UILabel *)labelArray[i];
        Coments *cModel = comArray[i];
        l.text = [NSString stringWithFormat:@"%@ :%@",cModel.comentName,cModel.comentContent];
    }
    //调整label的位置
    if (labelArray.count) {
        //先清空father的布局
        [labelArray enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
            [label sd_clearAutoLayoutSettings];
            label.frame = CGRectZero;
        }];
    }
    UILabel *lastLabel = [UILabel new];//上一个label
    for (int i = 0; i < comArray.count; i ++) {
        UILabel *l = (UILabel *)labelArray[i];
        if (i == 0) {
            l.sd_layout.leftSpaceToView(self,0).topSpaceToView(self,0).rightSpaceToView(self,0).autoHeightRatio(0);
        }else
            l.sd_layout.leftSpaceToView(self,0).topSpaceToView(lastLabel,2).rightSpaceToView(self,0).autoHeightRatio(0);
        lastLabel = l;
    }
    [self setupAutoHeightWithBottomView:lastLabel bottomMargin:0];
}

@end
