//
//  FriendImagesView.m
//  TT
//
//  Created by wanggang on 2016/10/8.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "FriendImagesView.h"

@interface FriendImagesView ()
{
    NSArray *totalArray;
}

@end

@implementation FriendImagesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            UIImageView *iv = [[UIImageView alloc] init];
            iv.frame = CGRectMake(j*80+5*j, i*80+5*i, 80, 80);
            [arr addObject:iv];
        }
    }
    totalArray = arr;
}

- (void)setImageArr:(NSArray *)imageArr{
    //计算出容器的大小
    CGSize size = [self getSize:imageArr.count];
    self.width = size.width;
    self.height = size.height;
    self.fixedWidth = @(self.width);
    self.fixedHeight = @(self.height);
    //隐藏多余的图片
    for (int i = imageArr.count; i<totalArray.count; i++) {
        UIImageView *iv = totalArray[i];
        iv.hidden = YES;
    }
    //显示图片
    for (int i = 0; i < imageArr.count; i ++) {
        UIImageView *iv = totalArray[i];
        iv.image = [UIImage imageNamed:imageArr[i]];
        iv.hidden = NO;
        [self addSubview:iv];
    }
}

- (CGSize)getSize:(NSInteger)count{

    switch (count) {
        case 0:
            return CGSizeMake(0, 0);
        case 1:
            return CGSizeMake(250, 80);
        case 2:
            return CGSizeMake(250, 80);
        case 3:
            return CGSizeMake(250, 80);
        case 4:
            return CGSizeMake(250, 165);
        case 5:
            return CGSizeMake(250, 165);
        case 6:
            return CGSizeMake(250, 165);
        case 7:
            return CGSizeMake(250, 250);
        case 8:
            return CGSizeMake(250, 250);
        case 9:
            return CGSizeMake(250, 250);
    }
    return CGSizeMake(0, 0);
}

@end
