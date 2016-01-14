//
//  DetailEvaluateModel.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/17.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"
#import "EvaluateDataModel.h"
@interface DetailEvaluateModel : JSONModel

@property (nonatomic, strong) NSArray<EvaluateDataModel> *data;
@property (nonatomic, strong) NSString *count;
@end
