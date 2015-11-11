//
//  AboutViewController.m
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()<UIScrollViewDelegate>

@end

@implementation AboutViewController
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UIImageView *_myImageView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于";
    self.view.backgroundColor=[UIColor whiteColor];
    [self initUI];
    [_scrollView setContentOffset:CGPointMake(_pageControl.currentPage*kScreenSize.width, 0) animated:YES];
}

-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height)];
    for (NSInteger i=0; i<4; i++) {
        _myImageView=[[UIImageView alloc]init];
        _myImageView.frame=CGRectMake(kScreenSize.width*i, 0, kScreenSize.width, kScreenSize.height-30);
        _myImageView.image=[UIImage imageNamed:[ NSString stringWithFormat:@"截图%ld",(long)i+1]];
        [_scrollView addSubview:_myImageView];
        
    }
    _scrollView.contentSize = CGSizeMake(kScreenSize.width*4, 160);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,kScreenSize.height-30, kScreenSize.width, 30)];
    view.backgroundColor = [UIColor darkGrayColor];
    view.alpha = 0.5;
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenSize.width/2-60, 0, 120, 30)];
    _pageControl.numberOfPages = 4;
    //添加翻页触发事件
    [_pageControl addTarget:self action:@selector(pageControl:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:_pageControl];
    [self.view addSubview:view];
}
//控制滚动
- (void)pageControl:(UIPageControl *)page{
    
    [_scrollView setContentOffset:CGPointMake(_pageControl.currentPage*kScreenSize.width, 0) animated:YES];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    _pageControl.currentPage = point.x/kScreenSize.width;
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
