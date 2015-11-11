//
//  PictureViewController.m
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "PictureViewController.h"

@interface PictureViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UIImageView *_myImageView;
}
@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=[NSString stringWithFormat:@"%@",self.model.workName];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initUI];
}

-(void)initUI{
    _myImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, kScreenSize.height/5, kScreenSize.width-40, kScreenSize.height/2)];
    _myImageView.userInteractionEnabled=YES;
    [_myImageView sd_setImageWithURL:[NSURL URLWithString:self.model.worksPic] placeholderImage:[UIImage imageNamed:@"kb"]];
    UIPinchGestureRecognizer *pinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    [_myImageView addGestureRecognizer:pinch];
    
    
    UISwipeGestureRecognizer *rswipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(right:)];
    rswipe.direction=UISwipeGestureRecognizerDirectionRight;
    [_myImageView addGestureRecognizer:rswipe];
    
    UISwipeGestureRecognizer *lswipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(left:)];
    lswipe.direction=UISwipeGestureRecognizerDirectionLeft;
    [_myImageView addGestureRecognizer:lswipe];
    
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.minimumZoomScale = 0.5;
    _scrollView.delegate = self;
    
    
    
    [self.view addSubview:_myImageView];
    
}
-(void)right:(UISwipeGestureRecognizer *)swipe{
    NSInteger j=[self.dataArr indexOfObject:self.model];
    if (j<1) {
        return;
    }
    j--;
    self.model=self.dataArr[j];
    self.title=[NSString stringWithFormat:@"%@",self.model.workName];
    [_myImageView sd_setImageWithURL:[NSURL URLWithString:self.model.worksPic] placeholderImage:[UIImage imageNamed:@"kb"]];
}
-(void)left:(UISwipeGestureRecognizer *)swipe{
    NSInteger i=[self.dataArr indexOfObject:self.model];
    if (i>=self.dataArr.count-1) {
        return;
    }
    i++;
    self.model=self.dataArr[i];
    self.title=[NSString stringWithFormat:@"%@",self.model.workName];
    [_myImageView sd_setImageWithURL:[NSURL URLWithString:self.model.worksPic] placeholderImage:[UIImage imageNamed:@"kb"]];
}
- (void)pinch:(UIPinchGestureRecognizer *)pinch {
    
    _myImageView.transform = CGAffineTransformScale(_myImageView.transform, pinch.scale, pinch.scale);
    
    pinch.scale = 1;   // 下次相对比例应该从1开始
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {

    return _myImageView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
