//
//  QYDetailViewController.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/10.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "QYDetailViewController.h"
#import "HeaderView.h"
#import "SectionOneCell.h"
#import "SectionTwoViewCell.h"
#import "CZT_IOS_Longrise.pch"
#import "UIImageView+WebCache.h"
#import "DetailModel.h"
#import "SectionTwoHeaderView.h"
#import "AppDelegate.h"
@interface QYDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    HeaderView *header;
    NSString *evaCount;//评价数
    
    NSMutableArray *evaluateArray;
    DetailInfoModel *infoModel;
}
@end

@implementation QYDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"_companyId%@",_companyId);
    NSLog(@"_areaId%@",_areaId);
    
    self.view.backgroundColor = [UIColor whiteColor];
    evaluateArray = [NSMutableArray array];
    
    
    /**
     *  暂时隐藏分享按钮
     */
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 30, 30);
//    [btn setImage:[UIImage imageNamed:@"icon02"] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    self.navigationItem.rightBarButtonItem = barBtn;
    
    header = [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil][0];
    header.frame = CGRectMake(0, 0, ScreenWidth, 260*SCALE);
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.tableHeaderView = header;
    [self.view addSubview:table];
    

    [table registerNib:[UINib nibWithNibName:@"SectionOneCell" bundle:nil] forCellReuseIdentifier:@"SectionOneCell"];
    
    [table registerNib:[UINib nibWithNibName:@"SectionTwoViewCell" bundle:nil] forCellReuseIdentifier:@"SectionTwoViewCell"];
    
    [self loadEnterpriseDetailInfoData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 加载企业信息详情
-(void)loadEnterpriseDetailInfoData{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    //只有这一组有数据
    NSLog(@"areaid -> %@",_areaId);
    NSLog(@"comid -> %@",_companyId);
    
    [bean setValue:_areaId forKey:@"areaid"];
    [bean setValue:_companyId forKey:@"lcipcompanyid"];
    [bean setValue:@"1" forKey:@"pagenum"];
    [bean setValue:@"10" forKey:@"pagesize"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@/",[Globle getInstance].wxSericeURL,businessapp];
    
    [[Globle getInstance].service requestWithServiceIP:url ServiceName:@"appsearchcompanyinfo" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [hud hide:YES afterDelay:0];
        
//        NSLog(@"DetailResult%@",[Util objectToJson:result]);
        
        if (nil != result) {
            DetailModel *model = [[DetailModel alloc]initWithString:[Util objectToJson:result] error:nil];
//            NSLog(@"DetailModel -> %@",model);
            /**
             *  头视图和主营范围模型
             */
            infoModel = model.data.companyinfo;
            
            if (nil != infoModel) {
                [header setUIWithInfo:infoModel];
            }
            
            
            DetailEvaluateModel *evaModel = model.data.companyevaluate;

            NSLog(@"evaCount -> %ld",evaModel.data.count);
            /**
             *  评价模型数组
             */
            evaluateArray = [NSMutableArray arrayWithArray:evaModel.data];
        
            [table reloadData];
        }
    }];
}




#pragma mark - tabelView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else{
        /**
         *  如果没有评价数据，就返回一行用来显示暂无评价数据
         */
        if (evaluateArray.count == 0) {
            return 1;
        }
        else return evaluateArray.count;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        SectionOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SectionOneCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (nil != infoModel) {
            [cell setUIWithInfo:infoModel];
        }
        
        return cell;
        
    }
    else{
        
        /**
         *  如果评价数据为0
         */
        if (evaluateArray.count == 0) {
            
            UITableViewCell *cell = [UITableViewCell new];
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 21)];
            lab.text = @"暂无评价数据";
            lab.textAlignment = NSTextAlignmentCenter;
            lab.center = cell.contentView.center;
            [cell.contentView addSubview:lab];
            [AppDelegate storyBoradAutoLay:cell.contentView];
            return cell;
        }
        
        else{
            
            SectionTwoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SectionTwoViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (evaluateArray.count > indexPath.row) {
                EvaluateResultModel *model = evaluateArray[indexPath.row];
                [cell setUIWithInfo:model];
            }
            return cell;
        }
        

    }
    
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"主营范围";
    }
    else{
        return @"评价";
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        SectionTwoHeaderView *twoHeader = [[NSBundle mainBundle] loadNibNamed:@"SectionTwoHeaderView" owner:nil options:nil][0];
        
        if (nil != infoModel) {
            [twoHeader setUIWithInfo:infoModel];
        }
        
        return twoHeader;
    }
    else return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100*SCALE;
    }
    else{
        return 130*SCALE;
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
