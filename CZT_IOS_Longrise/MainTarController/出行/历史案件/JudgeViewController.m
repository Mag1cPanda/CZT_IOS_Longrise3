//
//  JudgeViewController.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 16/1/6.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "JudgeViewController.h"
#import "Globle.h"
#import "AFNetWorkService.h"
#import "CZT_IOS_Longrise.pch"
#import "FVCustomAlertView.h"

@interface JudgeViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    
    NSMutableArray *dataList;
    NSInteger select;
    NSString *reasonName;
    NSString *reasonCode;
    FVCustomAlertView *alertView;
    UIAlertView *jugdeAlertView;
}

@end

@implementation JudgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价";
    select = 100;
    dataList = [NSMutableArray array];
    reasonName = nil;
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 选项点击事件
- (IBAction)btnClicked:(id)sender {
    _verySatisfiedImageView.hidden = YES;
    _satisfiedImageView.hidden = YES;
    _justSoSoImageView.hidden = YES;
    _unsatisfiedImageView.hidden = YES;
    UIButton *clickedButton = (UIButton *)sender;
    NSInteger tag = clickedButton.tag - 1000;
    if (tag == 0) {
        
        _selectPickerView.hidden = YES;
        _verySatisfiedImageView.hidden = NO;
        select = 0;
        
    }else if (tag == 1){
        
        _selectPickerView.hidden = YES;
        _satisfiedImageView.hidden = NO;
        select = 1;
        
    }else if (tag == 2){
        
        if (dataList.count > 0) {
            _pickerBtn.hidden = NO;
            _selectPickerView.hidden = NO;
            [_selectPickerView reloadAllComponents];
        }else{
            _pickerBtn.hidden = NO;
            [self requestData];
            [_selectPickerView reloadAllComponents];
        }
        _justSoSoImageView.hidden = NO;
        select = 2;
        
    }else if (tag == 3){
        if (dataList.count > 0) {
            _pickerBtn.hidden = NO;
            _selectPickerView.hidden = NO;
            [_selectPickerView reloadAllComponents];
        }else{
            [self requestData];
            _pickerBtn.hidden = NO;
            [_selectPickerView reloadAllComponents];
        }
        _unsatisfiedImageView.hidden = NO;
        select = 3;
        
    }
    
    
}

#pragma mark - picker点击事件
- (IBAction)pickerViewBtnCliked:(id)sender {
    _pickerBtn.hidden = YES;
     _selectPickerView.hidden = YES;
}



#pragma mark - 请求数据
-(void)requestData{
    
    alertView = [[FVCustomAlertView alloc] init];
    [alertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:-1];
    [self.view addSubview:alertView];
    
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    [bean setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [bean setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:[NSString stringWithFormat:@"%@/zdsearchunsatisfiedreason",kckpzcslrest] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        if (nil != result) {
            NSDictionary *bigDic = result;
            if ([bigDic[@"restate"]isEqualToString:@"0"]) {
                if (bigDic[@"data"]) {
                    
                    NSArray *dataArray = bigDic[@"data"];
                    for (NSDictionary *dic in dataArray) {
                        [dataList addObject:dic];
                    }
                    
                }else{
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:bigDic[@"redes"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"获取不满意原因列表失败，请检查网络！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                NSLog(@"%@",bigDic[@"redes"]);
            }
        }
        [_selectPickerView reloadAllComponents];
        _selectPickerView.hidden = NO;
        [alertView dismiss];
        
    }];
    
    
}

#pragma mark - 确定点击事件
- (IBAction)sureClicked:(id)sender {
    
    if (select == 100) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请评价！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    alertView = [[FVCustomAlertView alloc] init];
    [alertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:-1];
    [self.view addSubview:alertView];
    
    NSDictionary *loginDic = [Globle getInstance].loginInfoDic;
    NSDictionary *userDic = [loginDic valueForKey:@"userinfo"];
    NSString * telephone = [userDic valueForKey:@"mobilephone"];
    
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    [bean setValue:_appcaseno forKey:@"appcaseno"];
    [bean setValue:_casecarno forKey:@"casecarno"];
    [bean setValue:telephone forKey:@"casetelephoe"];
    [bean setValue:_suggestTextView.text forKey:@"personevaluate"];
    [bean setValue:[NSString stringWithFormat:@"%ld",select] forKey:@"personescord"];
    if (select == 0) {
    
        [bean setValue:nil forKey:@"reasoncode"];
        
    }else if (select == 1){
        [bean setValue:nil forKey:@"reasoncode"];
        
    }else if (select == 2){
        if (reasonName == nil) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请选择不满意的原因!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return;
        }else{
            [bean setValue:reasonCode forKey:@"reasoncode"];
        }
        
    }else if (select == 3){
        if (reasonName == nil) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请选择不满意的原因!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return;
        }else{
            [bean setValue:reasonCode forKey:@"reasoncode"];
        }
        
    }
    [bean setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [bean setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    
    [[Globle getInstance].service requestWithServiceIP:ServiceURL ServiceName:[NSString stringWithFormat:@"%@/zdsubmitcarevaluationinfo",kckpzcslrest] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        if (nil != result) {
            NSDictionary *bigDic = result;
            if ([bigDic[@"restate"]isEqualToString:@"0"]){
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"评价成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
//                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                NSString *str = bigDic[@"redes"];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"评价失败!" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"评价失败!" message:@"请检查您的网络!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        [alertView dismiss];
    }];
    
}

#pragma mark - picker代理方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return dataList.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *unsatisfiedReasonStr = nil;
    if (dataList.count > row) {
        NSDictionary *dic = dataList[row];
        unsatisfiedReasonStr = dic[@"reasonname"];
    }
    return unsatisfiedReasonStr;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (dataList.count > row) {
        NSDictionary *dic = dataList[row];
        reasonName = dic[@"reasonname"];
        reasonCode = dic[@"reasoncode"];
    }
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
