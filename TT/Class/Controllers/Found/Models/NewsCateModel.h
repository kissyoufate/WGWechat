//
//  NewsCateModel.h
//  TT
//
//  Created by wanggang on 16/9/13.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "BaseModel.h"

@class Pics,List,Comment_Count_Info;
@interface NewsCateModel : BaseModel

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSString *kpic;

@property (nonatomic, copy) NSString *comments;

@property (nonatomic, copy) NSString *feedShowStyle;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, copy) NSString *bpic;

@property (nonatomic, assign) NSInteger pubDate;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, assign) NSInteger articlePubDate;

@property (nonatomic, assign) NSInteger comment;

@property (nonatomic, strong) Comment_Count_Info *comment_count_info;

@property (nonatomic, copy) NSString *long_title;

@property (nonatomic, assign) BOOL is_focus;

@property (nonatomic, strong) Pics *pics;


@end
@interface Pics : NSObject

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSArray<List *> *list;

@end

@interface List : NSObject

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *alt;

@property (nonatomic, copy) NSString *kpic;

@end

@interface Comment_Count_Info : NSObject

@property (nonatomic, assign) NSInteger comment_status;

@property (nonatomic, assign) NSInteger qreply;

@property (nonatomic, assign) NSInteger show;

@property (nonatomic, assign) NSInteger dispraise;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger praise;

@end

