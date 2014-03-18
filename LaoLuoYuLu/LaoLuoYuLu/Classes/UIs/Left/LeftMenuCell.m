//
//  LeftMenuCell.m
//  LaoLuoYuLu
//
//  Created by 老岳 on 14-3-7.
//  Copyright (c) 2014年 LYue. All rights reserved.
//

#define ImageView_Width 30

#import "LeftMenuCell.h"

@implementation LeftMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //imageView
        self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (Row_Height-ImageView_Width)/2, ImageView_Width, ImageView_Width)];
        self.leftImageView.backgroundColor = ClearColor;
        [self addSubview:self.leftImageView];
        //titleLabel
        float titleLabel_x = self.leftImageView.frame.origin.x + self.leftImageView.frame.size.width + 10;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel_x, 0, LeftMenuWidth-titleLabel_x, Row_Height)];
        self.titleLabel.textColor = WhiteColor;
        self.titleLabel.backgroundColor = ClearColor;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.titleLabel.textColor = selected ? WhiteColor : [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:selected?18:16];
}

@end