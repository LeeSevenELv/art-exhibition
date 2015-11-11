//
//  DetailCell.m
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)showDetailWithModel:(NewModel *)model {
    
    self.nameLabel.text = model.name;
    self.artistLabel.text = [NSString stringWithFormat:@"艺术家:%@",model.artist];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
