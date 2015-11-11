//
//  TypeViewController.m
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "TypeViewController.h"
#import "DetailCollectionViewCell.h"
#import "DetailViewController.h"
#import "NewCell.h"

@interface TypeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    
}

@end

@implementation TypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"推荐";
    self.view.backgroundColor=[UIColor whiteColor];
    [self initUI];
    [self initData];
}
-(void)initData{
    _dataArr=[[NSMutableArray alloc]init];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString *url=[NSString stringWithFormat:kScrollDetailUrl,(long)self.model.id];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr=dict[@"data"];
            for (NSDictionary *dic in arr) {
                NewModel *model=[[NewModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [_dataArr addObject:model];
            }
            [_tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)initUI{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=200;
    [_tableView registerNib:[UINib nibWithNibName:@"NewCell" bundle:nil ] forCellReuseIdentifier:@"new"];
    [self.view addSubview:_tableView];
    
}
#pragma mark - 实现协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataArr.count<3) {
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _dataArr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"new" forIndexPath:indexPath];
    NewModel *model=_dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detailController=[[DetailViewController alloc]init];
    NewModel *model=_dataArr[indexPath.row];
    detailController.model=model;
    [self.navigationController pushViewController:detailController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
