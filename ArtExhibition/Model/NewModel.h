//
//  NewModel.h
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "BaseModel.h"

@interface NewModel : BaseModel

@property(nonatomic,copy)NSString *exhibitPic;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *exhibitCity;
@property(nonatomic,copy)NSString *exhibitNum;
@property(nonatomic,copy)NSString *galleryName;
@property(nonatomic,copy)NSString *exhibitEndDate;
@property(nonatomic,copy)NSString *exhibitStartDate;
@property(nonatomic,copy)NSString *artist;
@property(nonatomic,copy)NSString *exhibitDesc;
@property(nonatomic)NSInteger id;

@end
