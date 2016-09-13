//
//  NewsCategaryCell.m
//  TT
//
//  Created by wanggang on 16/9/13.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "NewsCategaryCell.h"

@implementation NewsCategaryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(NewsCateModel *)model{
    [self.topicPic sd_setImageWithURL:[NSURL URLWithString:model.kpic] placeholderImage:nil];
    self.titleName.text = model.long_title;
    self.contentLabel.text = model.intro;
}

@end
