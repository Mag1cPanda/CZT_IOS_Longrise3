//
//  QYSearchViewController.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/18.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "QYSearchViewController.h"
#import "QYDetailViewController.h"
#import "QYTableViewCell.h"
#import "ResultModel.h"
#import "QYModel.h"
@interface QYSearchViewController ()
<UISearchBarDelegate,
UITableViewDataSource,
UITableViewDelegate>
{
    UITableView *searchTable;
    NSMutableArray *qySearchData;
    UISearchBar *qySearch;
    NSMutableDictionary *enterpriseBean;
    NSInteger enterprisePage;
    QYModel *qyModel;
}
@end

@implementation QYSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"找企业";
    self.view.backgroundColor = [UIColor whiteColor];
    qySearchData = [NSMutableArray array];
    enterpriseBean = [NSMutableDictionary dictionary];
    enterprisePage = 1;
    
    qySearch = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth,30)];
    qySearch.placeholder = @"请输入关键字";
    qySearch.text = self.searchString;
    qySearch.backgroundColor = [UIColor whiteColor];
    qySearch.searchBarStyle = UISearchBarStyleMinimal;
    qySearch.delegate = self;
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:qySearch];
    [self.view addSubview:backView];

    searchTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    searchTable.delegate = self;
    searchTable.dataSource = self;
    searchTable.tableHeaderView = backView;
    [self.view addSubview:searchTable];
    
    [searchTable registerNib:[UINib nibWithNibName:@"QYTableViewCell" bundle:nil] forCellReuseIdentifier:@"QYTableViewCell"];
    
    [self loadEnterPriseSearchData];
}


#pragma mark - 加载企业搜索数据
-(void)loadEnterPriseSearchData{
    
    [enterpriseBean setValue:@"420100000000000000" forKey:@"areaid"];
    [enterpriseBean setValue:_searchString forKey:@"companyname"];
    [enterpriseBean setValue:[NSNumber numberWithInteger:enterprisePage] forKey:@"pagenum"];
    [enterpriseBean setValue:@"3" forKey:@"pagesize"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在加载";
    
    NSLog(@"搜索企业Bean%@",enterpriseBean);
    NSString *url = [NSString stringWithFormat:@"%@%@/",[Globle getInstance].wxSericeURL,businessapp];
    
    [[Globle getInstance].service requestWithServiceIP:url ServiceName:@"appsearchfixcompany" params:enterpriseBean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [hud hide:YES afterDelay:0];
        if (nil != result) {
            NSString *json = [Util objectToJson:result];
            NSLog(@"企业搜索数据%@",json);
            qyModel = [[QYModel alloc]initWithString:json error:nil];
            [qySearchData addObjectsFromArray:qyModel.data];
            [searchTable reloadData];
        }
    } ];
}


#pragma mark - searchBar Delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    _searchString = searchBar.text;
    [qySearchData removeAllObjects];
    [self loadEnterPriseSearchData];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return qySearchData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QYTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ResultModel *model = qySearchData[indexPath.row];
    
    if (nil != model) {
        [cell setUIWithInfo:model];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 110*SCALE;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QYDetailViewController *vc = [QYDetailViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [qySearch resignFirstResponder];
}

//补全分割线
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell  respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
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
