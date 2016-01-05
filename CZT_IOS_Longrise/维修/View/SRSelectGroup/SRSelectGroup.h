//
//  SRSelectGroup.h
//  CustomBtn
//
//  Created by Siren on 15/12/24.
//  Copyright © 2015年 Siren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRadioButton.h"

//@protocol SRSelectGroupDelegate <NSObject>
//
//@optional
//
//-(void)SRSelectGroupSelectedIndex:(NSInteger)selectedIndex;
//
//@end

@interface SRSelectGroup : UIView<QRadioButtonDelegate>

{
    QRadioButton *_radio1;
    QRadioButton *_radio2;
    QRadioButton *_radio3;
}



@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSString *evaluate;
@end
