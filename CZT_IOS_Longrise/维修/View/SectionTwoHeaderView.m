//
//  SectionTwoHeaderView.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/23.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "SectionTwoHeaderView.h"

@implementation SectionTwoHeaderView

-(void)setUIWithInfo:(DetailInfoModel *)model{
    
    self.total.text = [NSString stringWithFormat:@"评价(%@)",model.peoplenumber];

    NSInteger totalNum = [model.ratenum integerValue]
                       + [model.middlenum integerValue]
                       + [model.badnum integerValue];
    self.total.text = [NSString stringWithFormat:@"评价(%zi)",totalNum];
    self.good.text = [NSString stringWithFormat:@"好评(%@)",model.ratenum];
    self.middle.text = [NSString stringWithFormat:@"中评(%@)",model.middlenum];
    self.bad.text = [NSString stringWithFormat:@"差评(%@)",model.badnum];
}

@end
