//
//  QYModel.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/14.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"
#import "ResultModel.h"
@interface QYModel : JSONModel
@property (nonatomic, strong) NSArray<ResultModel> *data;
@end
