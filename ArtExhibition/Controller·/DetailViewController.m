//
//  DetailViewController.m
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCollectionViewCell.h"
#import "LZXHelper.h"
#import "WorksModel.h"
#import "WorksViewController.h"

@interface DetailViewController () <UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UIScrollView *_myScrollView;
    UICollectionView *_myCollectionView;
    UILabel *_nameLabel;
    UILabel *_artistLabel;
    NSMutableArray *_dataArr;
    CGFloat _artistHigh;
    CGFloat _nameHigh;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=[NSString stringWithFormat:@"共%@件",self.model.exhibitNum];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [super viewDidLoad];
    [self initUI];
    [self initData];

}
-(void)initUI{
    
    _myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height)];
    [self.view addSubview:_myScrollView];
    _myScrollView.delegate=self;
    _myScrollView.showsVerticalScrollIndicator = NO;
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.minimumLineSpacing=5;//竖直的
    flowLayout.minimumInteritemSpacing=10;//水平的
    flowLayout.itemSize=CGSizeMake(arc4random()%10+180, 145);
    _myCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(10, 10, kScreenSize.width, 300) collectionViewLayout:flowLayout];
    _myCollectionView.showsHorizontalScrollIndicator=NO;
    _myCollectionView.backgroundColor=[UIColor whiteColor];
    _myCollectionView.delegate=self;
    _myCollectionView.dataSource=self;
    [_myCollectionView registerNib:[UINib nibWithNibName:@"DetailCollectionViewCell"  bundle:nil] forCellWithReuseIdentifier:@"DetailCollection"];
    
    [_myScrollView addSubview:_myCollectionView];
    
    UILabel *nameLabel=[[UILabel alloc]init];
    nameLabel.text=[NSString stringWithFormat:@"%@",self.model.name];
    nameLabel.numberOfLines=0;
    _nameHigh=[LZXHelper textHeightFromTextString:nameLabel.text width:kScreenSize.width fontSize:17.0];
    nameLabel.frame=CGRectMake(5, 340, kScreenSize.width, _nameHigh);
    
    UILabel *artistLabel=[[UILabel alloc]init];
    artistLabel.font=[UIFont systemFontOfSize:14.0];
    artistLabel.numberOfLines=0;
    artistLabel.tintColor=[UIColor darkGrayColor];
    artistLabel.text=[NSString stringWithFormat:@"艺术家:%@",self.model.artist];
    _artistHigh=[LZXHelper textHeightFromTextString:artistLabel.text width:kScreenSize.width fontSize:14.0];
    artistLabel.frame=CGRectMake(5, 360+_nameHigh, kScreenSize.width, _artistHigh);
    [_myScrollView addSubview:nameLabel];
    [_myScrollView addSubview:artistLabel];
    
    UIWebView *webView=[[UIWebView alloc]init];
    NSString *str=[NSString stringWithFormat:@"%@",self.model.exhibitDesc];
    NSURL *url=[NSURL URLWithString:str];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    webView.userInteractionEnabled=YES;
    [webView loadRequest:request];
    int webViewHigh=[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"].intValue;
    webView.frame=CGRectMake(0, 364+_nameHigh+_artistHigh,kScreenSize.width,webViewHigh);
    _myScrollView.contentSize=CGSizeMake(kScreenSize.width, 364+_nameHigh+_artistHigh+webViewHigh);
    [_myScrollView addSubview:webView];
}
-(void)initData{
    _dataArr=[[NSMutableArray alloc]init];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString *url=[NSString stringWithFormat:kDetailUrl,(long)self.model.id];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDict=dict[@"data"];
            NSArray *worksArr=dataDict[@"works"];
           
            for (NSDictionary *dic in worksArr) {
                WorksModel *model=[[WorksModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [_dataArr addObject:model];
            }
            [_myCollectionView setContentSize:CGSizeMake((_dataArr.count/2+1)*190+10*_dataArr.count, 320)];
            [_myCollectionView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error");
    }];
}
#pragma mark -实现代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"DetailCollection" forIndexPath:indexPath];
    WorksModel *model = _dataArr[indexPath.row];
    [cell.myPicView sd_setImageWithURL:[NSURL URLWithString:model.worksPic]placeholderImage:[UIImage imageNamed:@"kb"]];
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WorksModel *model=_dataArr[indexPath.row];
    WorksViewController *controller=[[WorksViewController alloc]init];
    controller.model = model;
    controller.dataArr=[[NSMutableArray alloc]initWithArray:_dataArr];
    [self.navigationController pushViewController:controller animated:YES];
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
