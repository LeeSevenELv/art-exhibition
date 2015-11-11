//
//  BaseModel.h
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
