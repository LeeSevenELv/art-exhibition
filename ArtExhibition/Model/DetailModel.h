//
//  DetailModel.h
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "BaseModel.h"

@interface DetailModel : BaseModel

@property(nonatomic,copy)NSString *artist;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSArray *works;
@property(nonatomic,copy)NSString *worksPic;

@end
