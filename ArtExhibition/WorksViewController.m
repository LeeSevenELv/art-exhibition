//
//  DetailViewController.m
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.0/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "WorksViewController.h"
#import "PictureViewController.h"
#import "PicDetailCell.h"
#import "UITableView+Wave.h"
#import "UMSocial.h"

@interface WorksViewController ()  <UMSocialUIDelegate>
@property (strong, nonatomic)UIImageView *expandZoomImageView;
@property(nonatomic)NSInteger indexInteger;
@end

@implementation WorksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //标题
    self.title=[NSString stringWithFormat:@"%@",self.model.workName];
   
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share:)];
    self.navigationItem.rightBarButtonItem=item;
    UIBarButtonItem *item1= [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item1;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"PicDetailCell" bundle:nil] forCellReuseIdentifier:@"pic"];
    self.tableView.contentInset = UIEdgeInsetsMake(kScreenSize.height/2.0, 0, 0, 0);
    self.tableView.rowHeight=200;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    self.expandZoomImageView=[[UIImageView alloc]init];
    [self.expandZoomImageView sd_setImageWithURL:[NSURL URLWithString:self.model.worksPic] placeholderImage:[UIImage imageNamed:@"Imagebackground"]];
    self.expandZoomImageView.frame = CGRectMake(0, -kScreenSize.height/2.0, kScreenSize.width, kScreenSize.height/2.0);
     self.expandZoomImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.expandZoomImageView addGestureRecognizer:tap];
   
    
    [self.tableView addSubview:self.expandZoomImageView];
    UISwipeGestureRecognizer *rswipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(right:)];
    rswipe.direction=UISwipeGestureRecognizerDirectionRight;
    [self.tableView addGestureRecognizer:rswipe];
    UISwipeGestureRecognizer *lswipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(left:)];
    lswipe.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.tableView addGestureRecognizer:lswipe];
    
}
-(void)right:(UISwipeGestureRecognizer *)swipe{
    NSInteger j=[self.dataArr indexOfObject:self.model];
    if (j<1) {
        return;
    }
    j--;
    self.model=self.dataArr[j];
    self.title=[NSString stringWithFormat:@"%@",self.model.workName];
    [self.tableView reloadDataAnimateWithWave:RightToLeftWaveAnimation];
}
-(void)left:(UISwipeGestureRecognizer *)swipe{
    NSInteger i=[self.dataArr indexOfObject:self.model];
    if (i>=self.dataArr.count-1) {
        return;
    }
    i++;
    self.model=self.dataArr[i];
    self.title=[NSString stringWithFormat:@"%@",self.model.workName];
    [self.tableView reloadDataAnimateWithWave:RightToLeftWaveAnimation];
    
}

-(void)tap:(UITapGestureRecognizer *)tap{
    PictureViewController *controller=[[PictureViewController alloc]init];
    self.indexInteger=[self.dataArr indexOfObject:self.model];
    controller.image=self.expandZoomImageView.image;
    controller.model=self.model;
    controller.dataArr=self.dataArr;
    controller.indexInteger=self.indexInteger;
    
    CATransition *animation=[CATransition animation];
    animation.type = @"rippleEffect";//设置动画类型
    animation.subtype=@"formRight";//动画方向
    animation.duration=2;//动画时间
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -(kScreenSize.height/1.8)) {
        CGRect f = self.expandZoomImageView.frame;
        f.origin.y = yOffset;
        f.size.height =  -yOffset;
        self.expandZoomImageView.frame = f;
    }
}

-(void)share:(id)sender{
[UMSocialSnsService presentSnsIconSheetView:self
                                     appKey:@"5630606de0f55a8cf700061e"
                                  shareText:[NSString stringWithFormat:@"%@ <艺术长廊>",self.model.workName]
                                 shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.worksPic]]]
                            shareToSnsNames:[NSArray arrayWithObjects:UMShareToSms,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToFacebook,UMShareToTwitter,nil]
                                   delegate:self];


}
#pragma mark- 实现协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.expandZoomImageView sd_setImageWithURL:[NSURL URLWithString:self.model.worksPic] placeholderImage:[UIImage imageNamed:@"kb"]];
    PicDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"pic" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    cell.userInteractionEnabled=NO;
    if (indexPath.row==0) {
        
        cell.worksNameLabel.text=self.model.workName;
        cell.authorLabel.text=self.model.author;
        
        if ([self.model.worksSize isEqualToString:@""]||!self.model.worksSize ) {
            cell.sizeLabel.text=nil;
        }else{
            cell.sizeLabel.text=[NSString stringWithFormat:@"%@",self.model.worksSize];
        }
        if ([self.model.worksMaterial isEqualToString:@""]) {
            cell.meterLabel.text=nil;
        }else{
            cell.meterLabel.text=self.model.worksMaterial;
        }
    }
        return cell;
}
#pragma mark -UM协议
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

#pragma mark - <UIGestureRecognizerDelegate>
// 是否支持多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}



@end
