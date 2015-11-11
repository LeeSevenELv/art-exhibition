//
//  WorksModel.h
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "BaseModel.h"

@interface WorksModel : BaseModel
@property (nonatomic,copy)NSString *author;
@property(nonatomic)NSInteger id;
@property(nonatomic,copy)NSString *workName;
@property(nonatomic,copy)NSString *worksSize;
@property(nonatomic,copy)NSString *worksPic;
@property(nonatomic,copy)NSString *worksMaterial;
@end
