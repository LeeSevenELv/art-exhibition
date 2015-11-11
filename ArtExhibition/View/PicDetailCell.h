//
//  PicDetailCell.h
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *worksNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *meterLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@end
