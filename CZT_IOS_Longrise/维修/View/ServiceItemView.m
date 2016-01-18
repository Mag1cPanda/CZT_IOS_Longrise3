//
//  ServiceItemView.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 16/1/15.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "ServiceItemView.h"

@implementation ServiceItemView


-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(5, frame.size.height/2-5, 10, 10)];
        _icon.image = [UIImage imageNamed:@"icon12"];
        [self addSubview:_icon];
        
        _itemLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxY(_icon.frame)+5, frame.size.height/2-10, 200, 21)];
        _itemLab.text = @"Text";
        [self addSubview:_itemLab];
    }
    return self;
}

@end
