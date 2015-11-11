//
//  PictureViewController.h
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorksModel.h"

@interface PictureViewController : UIViewController
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)WorksModel *model;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic)NSInteger indexInteger;
@end
