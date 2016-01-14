//
//  EvaluateDataModel.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 16/1/12.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "EvaluateDataModel.h"

@implementation EvaluateDataModel
+(JSONKeyMapper *)keyMapper{
    
    JSONKeyMapper *keyMapper = [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"Id"}];
    return keyMapper;
}
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
@end
