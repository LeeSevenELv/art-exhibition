//
//  HaiwaiViewController.m
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "HaiwaiViewController.h"
#import "DetailViewController.h"
#import "NewCell.h"
#import "NewModel.h"
//#import "headView.h"
#import "JHRefresh.h"
#import "LZXHelper.h"
#import "MMProgressHUD.h"
#import "UITableView+Wave.h"

@interface HaiwaiViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    AFHTTPRequestOperationManager *_manager;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic)BOOL isRefreshing;
@property (nonatomic)BOOL isLoadMore;
@property(nonatomic)NSInteger pageIndex;

@end

@implementation HaiwaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self firstDownload];
    [self creatRefreshView];
    
}
-(void)createTableView{
    self.dataArr=[[NSMutableArray alloc]init];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewCell" bundle:nil] forCellReuseIdentifier:@"new"];
    self.tableView.rowHeight=200;
    [self.view addSubview:_tableView];
    _manager = [AFHTTPRequestOperationManager manager];
    //只下载 不解析  (二进制形式)
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
}
- (void)creatRefreshView {
    //增加下拉刷新
    
    //下面使用block 如果内部对self 进行操作 会存在 两个强引用 这样两个对象都不会释放导致内存泄露 (或者死锁就是两个对象不释放)
    //只要出现了循环引用 必须一强一弱 这样用完之后才会释放
    //arc 用 __weak  mrc __block
    
    __weak typeof (self) weakSelf = self;//弱引用
    
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        //重新下载数据
        if (weakSelf.isRefreshing) {
            return ;
        }
        weakSelf.isRefreshing = YES;//标记正在刷新
        weakSelf.pageIndex=1;
        
        NSString *url=[NSString stringWithFormat:kHaiwaiUrl,(long)weakSelf.pageIndex];
        [weakSelf addTaskWithUrl:url isRefresh:YES];
        
    }];
    
    //上拉加载更多
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        //重新下载数据
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore = YES;//标记正在刷新
        weakSelf.pageIndex ++;//页码加1
        
        NSString *url=[NSString stringWithFormat:kHaiwaiUrl,(long)weakSelf.pageIndex];
        
        
        [weakSelf addTaskWithUrl:url isRefresh:YES];
    }];
    
}
- (void)endRefreshing {
    if (self.isRefreshing) {
        self.isRefreshing = NO;//标记刷新结束
        //正在刷新 就结束刷新
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultNone];
    }
    if (self.isLoadMore) {
        self.isLoadMore = NO;
        [self.tableView footerEndRefreshing];
    }
}
//第一次下载 子类来调用
- (void)firstDownload {
    
    self.pageIndex = 1;
    
    NSString *url = [NSString stringWithFormat:kHaiwaiUrl,(long)self.pageIndex];
    
    //增加下载任务
    [self addTaskWithUrl:url isRefresh:NO];
}

#pragma mark - 增加下载任务
- (void)addTaskWithUrl:(NSString *)url isRefresh:(BOOL)isRefresh {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    NSString *path =[LZXHelper getFullPathWithFile:url];
    
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    //是否超时 一天
    BOOL isTimeout = [LZXHelper isTimeOutWithFile:url timeOut:24*60*60];
    if ((isRefresh == NO)&&(isExist == YES)&&(isTimeout == NO) ) {
        //同时成立
        //走本地缓存数据
        NSData *data = [NSData dataWithContentsOfFile:[LZXHelper getFullPathWithFile:url]];
        //解析二进制数据
        if (self.pageIndex == 1) {
            [self.dataArr removeAllObjects];
        }
        NSDictionary *dict1=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dict2=dict1[@"data"];
        NSArray *exhibits=dict2[@"exhibits"];
        for (NSDictionary *dict in exhibits) {
            NewModel *model=[[NewModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
        
        
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject) {
            
            //如果是下拉刷新 把之前的数据清空
            if (weakSelf.pageIndex == 1) {
                //清空之前的
                [weakSelf.dataArr removeAllObjects];
                //缓存第一页
                NSData *data = (NSData *)responseObject;
                //把二进制数据保存到本地
                //把url 地址作为缓存文件的名字(内部用md5加密)
                //YES 是否考虑安全(会创建临时文件)
                
                [data writeToFile:[LZXHelper getFullPathWithFile:url] atomically:YES];
            }
            
            //json 数据 json 自己解析
            NSDictionary *dict1=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dict2=dict1[@"data"];
            NSArray *exhibits=dict2[@"exhibits"];
            for (NSDictionary *dict in exhibits) {
                NewModel *model=[[NewModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArr addObject:model];
            }
            
            [self.tableView reloadData];
            //结束刷新
            [weakSelf endRefreshing];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MMProgressHUD dismissWithError:@"失败" title:@"网络故障"];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadDataAnimateWithWave:RightToLeftWaveAnimation];
}


#pragma  mark -实现协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"new" forIndexPath:indexPath];
    NewModel *model=self.dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailController=[[DetailViewController alloc]init];
    NewModel *model=self.dataArr[indexPath.row];
    detailController.model=model;
    [self.navigationController pushViewController:detailController animated:YES];
    
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
