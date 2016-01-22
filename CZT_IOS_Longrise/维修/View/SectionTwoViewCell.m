//
//  SectionTwoViewCell.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/11.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "SectionTwoViewCell.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
@implementation SectionTwoViewCell

-(void)setUIWithInfo:(EvaluateResultModel *)model{
    
    //头像
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.userphoto]];
    //名字
    if (![model.showname isKindOfClass:[NSString class]]) {
        self.nameLab.text = @"匿名";
    }
    else{
        //隐私保护，隐藏中间字符
        NSMutableString *mStr = [NSMutableString stringWithString:model.showname];
        NSRange range = NSMakeRange(1, mStr.length-2);
        [mStr replaceCharactersInRange:range withString:@"**"];
        self.nameLab.text = mStr;
    }
    //时间
    self.timestamp.text = model.evaluatetime;
    //总体评价
    if ([model.evaluatetotle integerValue] == 1) {
        self.evaluate.image = [UIImage imageNamed:@"hao"];
    }
    else if ([model.evaluatetotle integerValue] == 2){
        self.evaluate.image = [UIImage imageNamed:@"zhong"];
    }
    else{
       self.evaluate.image = [UIImage imageNamed:@"cha"];
    }
    //评价内容
    self.content.text = model.evaluatetotledetails;
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
