//
//  SRSelectGroup.m
//  CustomBtn
//
//  Created by Siren on 15/12/24.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import "SRSelectGroup.h"

@implementation SRSelectGroup

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _radio1 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
        _radio1.frame = CGRectMake(0, 0, frame.size.width/3, frame.size.height);
        [_radio1 setTitle:@"好评" forState:UIControlStateNormal];
        [_radio1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [self addSubview:_radio1];
        
        _radio2 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
        _radio2.frame = CGRectMake(CGRectGetMaxX(_radio1.frame), 0, frame.size.width/3, frame.size.height);
        [_radio2 setTitle:@"中评" forState:UIControlStateNormal];
        [_radio2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_radio2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [self addSubview:_radio2];
        
        _radio3 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
        _radio3.frame = CGRectMake(CGRectGetMaxX(_radio2.frame), 0, frame.size.width/3, frame.size.height);
        [_radio3 setTitle:@"差评" forState:UIControlStateNormal];
        [_radio3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_radio3.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [self addSubview:_radio3];
        
    }
    return self;
}

#pragma mark - QRadioButtonDelegate

- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
    
    if (radio == _radio1) {
        _selectedIndex = 1;
        _evaluate = @"好评";
    }
    else if (radio == _radio2){
        _selectedIndex = 2;
        _evaluate = @"中评";
    }
    else{
        _selectedIndex = 3;
        _evaluate = @"差评";
    }
     NSLog(@"_selectedIndex:%ld _evaluate:%@", _selectedIndex, _evaluate);
    
}


@end
