//
//  FriendCircleModel.h
//  TT
//
//  Created by wanggang on 2016/10/8.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "BaseModel.h"

@class Coments;
@interface FriendCircleModel : BaseModel

@property (nonatomic, strong) NSArray<Coments *> *coments;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSArray<NSString *> *feelGood;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, strong) NSArray<NSString *> *images;

@end
@interface Coments : NSObject

@property (nonatomic, copy) NSString *comentName;

@property (nonatomic, copy) NSString *comentContent;

@end

