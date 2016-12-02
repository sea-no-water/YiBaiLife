

//
//  SearchViewController.m
//  YIbaiLife2.0
//
//  Created by mac on 16/6/24.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
{
    UIScrollView * _sc;
    UILabel * _label;
}

@end

@implementation SearchViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    //导航控制器中，导航条隐藏，第一个视图为scrollview时，消除自动向下偏移20点的bug
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //bar2
    UIImageView *bar2 = [[UIImageView alloc]init];
    bar2.image = [UIImage imageNamed:@"s_bg"];
    bar2.frame = CGRectMake(0, 20, 320,44);
    bar2.userInteractionEnabled = YES;
    [self.view addSubview:bar2];

    
    NSArray * array = @[@"百度",@"新浪",@"搜狐",@"淘宝",@"天猫",@"谷歌",@"QQ",@"360",@"腾讯",@"易信",@"Bing"];
    //
    _sc = [[UIScrollView alloc]init];
    _sc.frame = CGRectMake(0, 64, 320, 40);
    _sc.backgroundColor = [UIColor grayColor];
    _sc.contentSize = CGSizeMake(80*array.count, 0);
    _sc.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_sc];
    
    
    //
    for (int i = 0 ; i<array.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(80*i, 0, 79, 38);
        button.backgroundColor = [UIColor orangeColor];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [_sc addSubview:button];
    }
    
    
    //
    
    _label = [[UILabel alloc]init];
    _label.center = CGPointMake(40, 38);
    _label.bounds = CGRectMake(0, 0, 79, 2);
    _label.backgroundColor = [UIColor redColor];
    [_sc addSubview:_label];
    
    //添加返回按钮
    UIButton * fanhui  = [[UIButton alloc]init];
    fanhui.frame =CGRectMake(5, 15, 40, 20);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [bar2 addSubview:fanhui];

    
}

//返回按钮
- (void)fanhui
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


//按钮点击居中
- (void)Click:(UIButton * )button

{
    float x = button.center.x;
    if (x < 160 )
    {
        [_sc setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    //如果点击的按钮时最后的，，，让滚动视图，偏移量最大容量减去屏幕
    else if(x> _sc.contentSize.width - 160)
    {
        //
        [_sc setContentOffset:CGPointMake(_sc.contentSize.width - 320 , 0) animated:YES];
    }
    else//否则，按钮居中
    {
        [_sc setContentOffset:CGPointMake(x - 160, 0) animated:YES];
        
    }
    [UIView animateWithDuration:0.3 animations:^{
        _label.center = CGPointMake(x, 38);
        
    }];
    
}








@end
