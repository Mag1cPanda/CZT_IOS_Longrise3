//
//  QYTableViewCell.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/9.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "QYTableViewCell.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
@implementation QYTableViewCell

-(void)setUIWithInfo:(ResultModel *)model{
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.companyphoto]];
    self.nameLab.text = model.name;
    self.address.text = [NSString stringWithFormat:@"地址：%@",model.address];
    self.rateCount.text = model.ratenum;
    self.goodRate.text = model.rate;
    
}

- (void)awakeFromNib {
    // Initialization code
    [AppDelegate storyBoradAutoLay:self];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
