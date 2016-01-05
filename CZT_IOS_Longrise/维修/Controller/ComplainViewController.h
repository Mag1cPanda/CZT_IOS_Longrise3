//
//  ComplainViewController.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRDetailHeaderView.h"
#import "HRDataModel.h"
#import "HRDetailDataModel.h"

@interface ComplainViewController : UIViewController

@property (weak, nonatomic) IBOutlet HRDetailHeaderView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UITextView *comTextView;

//头部视图数据
@property (nonatomic, strong) HRDataModel *model;
//参数数据模型
@property (nonatomic, strong) HRDetailDataModel *dataModel;
@end
