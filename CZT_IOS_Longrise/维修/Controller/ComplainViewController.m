//
//  ComplainViewController.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "ComplainViewController.h"
#import "AppDelegate.h"
#import "HRDetailViewController.h"
#define FORMATSTR(str) [NSString stringWithFormat:@"%@",str]
@interface ComplainViewController ()<UITextViewDelegate>
{
    HRDetailHeaderView *header;
    BOOL isSubmit;
}
@end

@implementation ComplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [AppDelegate storyBoradAutoLay:self.view];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"投诉";
    _comTextView.delegate = self;
    
    NSLog(@"_dataModel -> %@",_dataModel);
    
    self.commitBtn.layer.cornerRadius = 5;
    header  = [[NSBundle mainBundle] loadNibNamed:@"HRDetailHeaderView" owner:nil options:nil][0];
    
    header.frame = self.headerView.bounds;
    
    if (nil !=  _model ) {
        [header setUIWithInfo:self.model];
    }
    
    [self.headerView addSubview:header];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshHRDetailDataBlockCompletion:(RefreshDataBlock)refreshDataBlock{

    _refreshDataBlock = refreshDataBlock;
    
}

-(void)viewWillDisappear:(BOOL)animated{

    if (nil != _refreshDataBlock) {
        _refreshDataBlock(isSubmit);
    }
}

#pragma mark - textViewDelegate
//给textView添加placeHolder
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请填写您要投诉的信息"]) {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"请填写您要投诉的信息";
    }
}

#pragma mark - 提交投诉
- (IBAction)submibComplain:(id)sender {
    
    if ([_comTextView.text isEqual:@"请填写您要投诉的信息"] || _comTextView.text.length < 10 || _comTextView.text.length > 500) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您输入的字数不在范围内，请重新输入";
        [hud hide:YES afterDelay:3.0];
    }
    else{
    
        NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
        NSDictionary *userdic = [bigDic objectForKey:@"userinfo"];
        NSString *token = [bigDic objectForKey:@"token"];
        NSString *userflag = [userdic objectForKey:@"userflag"];
    //    NSString *areaid = [Globle getInstance].areaid;
        
        
        NSMutableDictionary *bean = [NSMutableDictionary dictionary];
        
        [bean setValue:userflag forKey:@"userflag"];
        [bean setValue:token forKey:@"token"];
        [bean setValue:_comTextView.text forKey:@"complaininfo"];
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
        
    //    NSLog(@"结果bean %@",bean);
        [[Globle getInstance].service requestWithServiceIP:url ServiceName:@"appevaluatestroecomplaint" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
            
            if (nil != result) {
                NSDictionary *dic = result;
                hud.mode = MBProgressHUDModeText;
                hud.labelText = [dic objectForKey:@"redes"];
            }
            [hud hide:YES afterDelay:1.0];
            NSLog(@"投诉结果%@",[Util objectToJson:result]);
            
            sleep(1);
            
            /**
             *  使用代码块
             */
            _refreshDataBlock(YES);
            [self.navigationController popViewControllerAnimated:YES];
            
            
            /**
             *  使用通知
             */
            //创建通知
            //    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"restate",nil];
            //    NSNotification *notification = [NSNotification notificationWithName:@"RefreshData" object:nil userInfo:dict];
            //发送通知
            //    [[NSNotificationCenter defaultCenter]postNotification:notification];
        } ];
    
    }
    
    
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
