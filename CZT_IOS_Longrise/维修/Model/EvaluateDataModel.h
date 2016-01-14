//
//  EvaluateDataModel.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 16/1/12.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "JSONModel.h"

@protocol EvaluateDataModel <NSObject>


@end

@interface EvaluateDataModel : JSONModel
@property (nonatomic, copy) NSString *carno;
@property (nonatomic, copy) NSString *caruser;
@property (nonatomic, copy) NSString *companycode;
@property (nonatomic, copy) NSString *evaluatetotle;
@property (nonatomic, copy) NSString *evaluatetime;
@property (nonatomic, copy) NSString *evaluateprice;
@property (nonatomic, copy) NSString *settleno;
@property (nonatomic, copy) NSString *evaluatetotledetails;
@property (nonatomic, copy) NSString *evaluatequality;
@property (nonatomic, copy) NSString *lcipusertableid;
@property (nonatomic, copy) NSString *repairdate;
@property (nonatomic, copy) NSString *lciprepairrecordid;
@property (nonatomic, copy) NSString *showname;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *ownerphoto;
@property (nonatomic, copy) NSString *userphoto;
@property (nonatomic, copy) NSString *evaluateservice;
@property (nonatomic, copy) NSString *evaluateefficiency;
@property (nonatomic, copy) NSString *evaluateenvironment;
@property (nonatomic, copy) NSString *lcipcompanyid;

@end
