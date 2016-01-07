//
//  EvaluateViewController.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"
#import "HRDetailHeaderView.h"
#import "HRDataModel.h"
#import "HRDetailDataModel.h"
#import "SRSelectGroup.h"
@interface EvaluateViewController : UIViewController

@property (nonatomic, strong) SRSelectGroup *group;

@property (weak, nonatomic) IBOutlet HRDetailHeaderView *headerView;

@property (weak, nonatomic) IBOutlet UIView *ratioBackView;

@property (weak, nonatomic) IBOutlet CWStarRateView *starView1;
@property (weak, nonatomic) IBOutlet CWStarRateView *starView2;
@property (weak, nonatomic) IBOutlet CWStarRateView *starView3;
@property (weak, nonatomic) IBOutlet CWStarRateView *starView4;
@property (weak, nonatomic) IBOutlet CWStarRateView *starView5;
@property (weak, nonatomic) IBOutlet UITextView *evaTextView;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;


//头部视图数据
@property (nonatomic, strong) HRDataModel *model;
//参数数据模型
@property (nonatomic, strong) HRDetailDataModel *dataModel;
@end
