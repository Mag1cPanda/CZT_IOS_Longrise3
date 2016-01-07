//
//  EvaluateViewController.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "EvaluateViewController.h"
#import "AppDelegate.h"

@interface EvaluateViewController ()<UITextViewDelegate,CWStarRateViewDelegate>
{
    HRDetailHeaderView *header;
    
}
@end

@implementation EvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [AppDelegate storyBoradAutoLay:self.view];
    
    _group = [[SRSelectGroup alloc]initWithFrame:_ratioBackView.bounds];
    NSLog(@"selectedIndex -> %ld",_group.selectedIndex);
    [_ratioBackView addSubview:_group];
    
    _starView1.allowIncompleteStar = NO;
    _starView2.allowIncompleteStar = NO;
    _starView3.allowIncompleteStar = NO;
    _starView4.allowIncompleteStar = NO;
    _starView5.allowIncompleteStar = NO;
    
    _starView1.delegate = self;
    _starView2.delegate = self;
    _starView3.delegate = self;
    _starView4.delegate = self;
    _starView5.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"评价";
    
    self.submitBtn.layer.cornerRadius = 5;
    header = [[NSBundle mainBundle] loadNibNamed:@"HRDetailHeaderView" owner:nil options:nil][0];
    header.frame = self.headerView.bounds;
    
    if (nil !=  _model ) {
        [header setUIWithInfo:self.model];
    }
    
    [self.headerView addSubview:header];
    
}

#pragma mark - starViewDelegate
- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent{
//    starRateView.scorePercent 
    NSLog(@"newScorePercent -> %f",newScorePercent);
    if (starRateView == _starView1) {
        _starView1.scorePercent = newScorePercent;
    }
    else if (starRateView == _starView2){
        _starView2.scorePercent = newScorePercent;
    }
    else if (starRateView == _starView3){
        _starView3.scorePercent = newScorePercent;
    }
    else if (starRateView == _starView4){
        _starView4.scorePercent = newScorePercent;
    }
    else{
        _starView5.scorePercent = newScorePercent;
    }
    
}

#pragma mark - 提交投评价
- (IBAction)submibEvaluate:(id)sender {
    
    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    NSDictionary *userdic = [bigDic objectForKey:@"userinfo"];
    NSString *token = [bigDic objectForKey:@"token"];
    NSString *userflag = [userdic objectForKey:@"userflag"];
    //    NSString *areaid = [Globle getInstance].areaid;
    
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    
    [bean setValue:userflag forKey:@"userflag"];
    [bean setValue:token forKey:@"token"];
    NSString *indexStr = [NSString stringWithFormat:@"%ld",_group.selectedIndex];
    [bean setValue:indexStr forKey:@"evaluatetotle"];
    
    NSString *star1Score = [NSString stringWithFormat:@"%f",_starView1.scorePercent] ;
    [bean setValue:star1Score forKey:@"evaluateservice"];
    
    NSString *star2Score = [NSString stringWithFormat:@"%f",_starView2.scorePercent] ;
    [bean setValue:star2Score forKey:@"evaluatequality"];
    
    NSString *star3Score = [NSString stringWithFormat:@"%f",_starView3.scorePercent] ;
    [bean setValue:star3Score forKey:@"evaluateefficiency"];
    
    NSString *star4Score = [NSString stringWithFormat:@"%f",_starView4.scorePercent] ;
    [bean setValue:star4Score forKey:@"evaluateprice"];
    
    NSString *star5Score = [NSString stringWithFormat:@"%f",_starView5.scorePercent] ;
    [bean setValue:star5Score forKey:@"evaluateenvironment"];
    
    [bean setValue:_evaTextView.text forKey:@"evaluatetotledetails"];;
    [bean setValue:_dataModel.company forKey:@"company"];
    [bean setValue:@"420115000000000000" forKey:@"areaid"];
    [bean setValue:_dataModel.companycode forKey:@"companycode"];
    [bean setValue:@"0" forKey:@"flag2"];
    [bean setValue:_dataModel.Id forKey:@"lciprepairrecordid"];
    [bean setValue:_dataModel.lcipcompanyid forKey:@"lcipcompanyid"];
    [bean setValue:_dataModel.settleno forKey:@"settleno"];
    [bean setValue:_dataModel.workorderno forKey:@"workorderno"];
    [bean setValue:_dataModel.carno forKey:@"carno"];
    [bean setValue:_dataModel.caruser forKey:@"caruser"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在提交";
    
    NSString *url = [NSString stringWithFormat:@"%@%@/",[Globle getInstance].wxSericeURL,businessapp];
    
    NSLog(@"评价bean %@",bean);
    [[Globle getInstance].service requestWithServiceIP:url ServiceName:@"appevaluatestroeevaluate" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        if (nil != result) {
            NSDictionary *dic = result;
            hud.mode = MBProgressHUDModeText;
            hud.labelText = [dic objectForKey:@"redes"];
        }
        [hud hide:YES afterDelay:3.0];
        NSLog(@"评价结果%@",[Util objectToJson:result]);
        
    } ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
