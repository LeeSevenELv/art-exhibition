//
//  DetailViewController.m
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorksModel.h"
@interface WorksViewController : UITableViewController
@property(nonatomic,strong)WorksModel *model;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end
