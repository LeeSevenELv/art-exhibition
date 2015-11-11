//
//  NewCell.m
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "NewCell.h"

@implementation NewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(NewModel *)model {
    
    self.model = model;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.exhibitPic]placeholderImage:[UIImage imageNamed:@"kb"]];
    self.nameLabel.text=model.name;
    self.detailLabel.text=[NSString stringWithFormat:@"%@|%@|%@件",model.exhibitCity,model.galleryName,model.exhibitNum];
}


@end
