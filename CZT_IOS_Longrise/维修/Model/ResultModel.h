//
//  ResultModel.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/14.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"

@protocol ResultModel <NSObject>


@end

@interface ResultModel : JSONModel

@property (nonatomic, copy) NSString *evaluatetotle;
@property (nonatomic, copy) NSString *companycode;
@property (nonatomic, copy) NSString *orgnumber;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *evaluatenum;
@property (nonatomic, copy) NSString *businessrange;
@property (nonatomic, copy) NSString *linkmobile;
@property (nonatomic, copy) NSString *companyphoto;
@property (nonatomic, copy) NSString *lcipusertableid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *areaid;
@property (nonatomic, copy) NSString *linkman;
@property (nonatomic, copy) NSString *ratenum;
@property (nonatomic, copy) NSString *linktel;
@property (nonatomic, copy) NSString *peoplenumber;
@property (nonatomic, copy) NSString *levels;
@property (nonatomic, copy) NSString *rate;
@property (nonatomic, copy) NSString *lcipcompanyid;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *industryid;

@end
