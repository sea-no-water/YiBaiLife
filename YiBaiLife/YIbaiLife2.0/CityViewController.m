//
//  CityViewController.m
//  YIbaiLife2.0
//
//  Created by mac on 16/6/24.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "CityViewController.h"

@interface CityViewController ()<UIScrollViewDelegate>
{
    UIScrollView * _bigSc;//大视图控制器
    UIScrollView * _samllSc;//小视图控制器
    UIPageControl * _page;//页面控制器
    NSMutableArray * _array;
    NSTimer * _timer;

}

@end

@implementation CityViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self createBGImage];
    [self createScrollView];
    [self createButton];
    [self createMenuButton];
}
-(void)createBGImage
{
    UIImageView * image=[[UIImageView alloc]init];
    image.frame=CGRectMake(0, 20, 320, 44);
    image.image=[UIImage imageNamed:@"c_bg"];
    [self.view addSubview:image];
    
    UIButton * btn=[[UIButton alloc]init];
    [btn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    btn.frame=CGRectMake(0, 25, 30, 30);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)backClick
{
    [_timer invalidate];
    [self.navigationController popViewControllerAnimated:YES ];
}
-(void)createScrollView
{
    _bigSc=[[UIScrollView alloc]init];
    _bigSc.frame=CGRectMake(0, 64, 320, 416);
    _bigSc.contentSize=CGSizeMake(320, 650);
    _bigSc.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_bigSc];
    
    _samllSc=[[UIScrollView alloc]init];
    _samllSc.frame=CGRectMake(0, 0, 320, 240);
    _samllSc.contentSize=CGSizeMake(320*5, 240);
    _samllSc.pagingEnabled=YES;
    _samllSc.delegate=self;
    [_bigSc addSubview:_samllSc];
    
    [self createImage];
    
}
-(void)createImage
{
    for (int i=0; i<5; i++)
    {
        UIImageView * image=[[UIImageView alloc]init];
        image.image=[UIImage imageNamed:[NSString stringWithFormat:@"c_item%d.jpg",i]];
        image.frame=CGRectMake(320*i, 0, 320, 240);
        [_samllSc addSubview:image];
        
    }
    [self createPage];
}
-(void)createPage
{
    _page=[[UIPageControl alloc]init];
    _page.bounds=CGRectMake(0, 0, 130, 30);
    _page.center=CGPointMake(160, 230);
    _page.numberOfPages=5;
    _page.currentPage=0;
    [_bigSc addSubview:_page];
    [_page addTarget:self action:@selector(pageMove) forControlEvents:UIControlEventValueChanged];
    _timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(pageMove) userInfo:nil repeats:YES];
}
-(void)pageMove
{
    static int a=1;
    if (_page.currentPage==0)
    {
        a=1;
        
    }
    if (_page.currentPage==4) {
        a=-1;
        
    }
    _page.currentPage=_page.currentPage+a;
    int x=_page.currentPage;
    int y;
    y=x*320;
    [_samllSc setContentOffset:CGPointMake(y, 0) animated:YES];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _page.currentPage=_samllSc.contentOffset.x/320;
}
-(void)createButton
{
    for (int i=0; i<12; i++) {
        UIButton * button=[[UIButton alloc]init];
        button.frame=CGRectMake(15+i%3*(320/3), 260+i/3*100, 80, 80);
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"c_%d",i+1]] forState:UIControlStateNormal];
        [_bigSc addSubview:button];
    }
}
-(void)createMenuButton
{
    _array =[NSMutableArray new];
    for (int i=0; i<4; i++)
    {
        UIButton * button=[[UIButton alloc]init];
        
        button.frame=CGRectMake(250, 410, 50, 50);
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"c_setting%d",3-i]] forState:UIControlStateNormal];
        button.tag=3-i;
        [self.view addSubview:button];
        [button addTarget:self action:@selector(btnClickMove) forControlEvents:UIControlEventTouchUpInside];
        [_array addObject:button];
    }
}
-(void)btnClickMove
{
    
    static BOOL isdouble=YES;
    if (isdouble==YES)
    {
        for (int i=0; i<4;i++)
        {
            UIButton * button=_array[i];
            [UIView animateWithDuration:0.5 animations:^{
                button.frame=CGRectMake(140+i%2*110, 300+i/2*110, 50, 50);
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.25 animations:^{
                    button.frame=CGRectMake(170+i%2*80, 330+i/2*80, 50, 50);
                    
                }];
                isdouble=NO;
                
                
            }];
            
            
        }
        return;
        
    }
    if (isdouble==NO)
    {
        for (int i=0; i<4; i++)
        {
            UIButton * button=_array[i];
            [UIView animateWithDuration:0.25 animations:^{
                button.frame=CGRectMake(140+i%2*110, 300+i/2*110, 50, 50);
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                    button.frame=CGRectMake(250, 410, 50, 50);
                }];
                
                isdouble=YES;
            }];
            
        }
        return;
    }
    
    
    
    
}


@end
