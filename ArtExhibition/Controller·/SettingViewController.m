//
//  SettingViewController.m
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutViewController.h"

@interface SettingViewController () <UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSArray *_titles;
}


@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    _titles=[[NSArray alloc]init];
    _titles=@[@"关于",@"清理缓存",@"意见反馈 879467111@qq.com"];
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    UIView *myView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 30)];
    myView.backgroundColor=[UIColor clearColor];
    _tableView.tableHeaderView=myView;
    _tableView.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back"]];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.rowHeight=50;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"setting"];
    [_tableView reloadData];
    [self.view addSubview:_tableView];
    
}
#pragma  mark - 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titles.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"setting"];
    if (cell==nil) {
        cell=[tableView dequeueReusableCellWithIdentifier:@"setting" forIndexPath:indexPath];
    }
    cell.textLabel.text=_titles[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor=[UIColor clearColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
//        case 0:
//        {
//            HelpViewController *controller=[[HelpViewController alloc]init];
//            [self.navigationController pushViewController:controller animated:YES];
//        }
//        break;
        case 0:
        {
            AboutViewController *controller=[[AboutViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
        break;
        case 1:
        {
            NSString *title = [NSString stringWithFormat:@"删除缓存文件:%.5fM",[self getCachesSize]];
            
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil];
            [sheet showInView:self.view];
        }
        break;
    }
}
#pragma mark - 获取缓存大小
- (double)getCachesSize {
    //换算为M
    //获取SD 字节大小
    double sdSize = [[SDImageCache sharedImageCache] getSize];
    
    double totalSize = sdSize/1024/1024;//转化为M
    return totalSize;
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        //删除sd的
        //清除内存中的图片缓存
        [[SDImageCache sharedImageCache] clearMemory];
        //清除磁盘上的图片缓存
        [[SDImageCache sharedImageCache] clearDisk];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
