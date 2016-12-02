//
//  WeatherViewController.m
//  YIbaiLife2.0
//
//  Created by mac on 16/6/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "WeatherViewController.h"
#import "DNButton.h"
#import "centerImageView.h"
@interface WeatherViewController ()
{
    UIButton * _dnBtn;
    UIButton * _isClick;//记录上次点击的按钮
    UIImageView *_tipImg;//指示图片
    centerImageView * _centerImage;//中间的图片
}

@end

@implementation WeatherViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    //背景
    UIImageView * beijing = [[UIImageView alloc]init];
    beijing.image = [UIImage imageNamed:@"w_bg"];
    beijing.frame = CGRectMake(0, 0, 320, 480);
    [self.view addSubview:beijing];

    
    //导航条
    UIImageView * bar = [[UIImageView alloc]init];
    bar.frame = CGRectMake(0, 20, 320, 44);
    bar.image = [UIImage imageNamed:@"w_bg2"];
    bar.userInteractionEnabled = YES;
    [self.view  addSubview:bar];
    
    //白天和晚上的按钮
    _dnBtn = [[UIButton alloc]init];
    _dnBtn.frame =CGRectMake(250, 27, 60, 30);
    [_dnBtn setTitle:@"白天" forState:UIControlStateNormal];
    [_dnBtn setTitle:@"夜晚" forState:UIControlStateSelected];
    [_dnBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_dnBtn addTarget:self action:@selector(clickDnBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dnBtn];
    
    //滚动视图
    UIScrollView * sc = [[UIScrollView alloc]init];
    sc.backgroundColor = [UIColor grayColor];
    sc.frame = CGRectMake(0, 410, 320, 70);
    [self.view addSubview:sc];
    sc.contentSize = CGSizeMake(640, 0);
    
    
    //添加七个按钮
    NSArray * array = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    for (int i = 0; i <7; i ++)
    {
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(10+90*i, 20, 80, 40);
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blueColor ] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"w_xq2"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"w_xq1"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i+1;
        [sc addSubview:btn];
        
        //设置周一默认为点击状态
        if (btn.tag == 1) {
            btn.selected = YES;
            _isClick = btn;//设置默认点击的为1
        }
    }

    //指示图片
    //添加指示图片
    _tipImg = [[UIImageView alloc]init];
    _tipImg.bounds = CGRectMake(0, 0, 80, 10);
    _tipImg.center = CGPointMake(_isClick.center.x, _isClick.center.y - 25);
    _tipImg.image = [UIImage imageNamed:@"w_tip"];
    [sc addSubview:_tipImg];
    
    
    //中间的图片视图
    _centerImage = [[centerImageView alloc]init];
    _centerImage.frame = CGRectMake(20, 82, 280, 292);
    _centerImage.image = [UIImage imageNamed:@"w_qing"];
    //把不需要的地方切割掉
    _centerImage.clipsToBounds = YES;
    [self.view addSubview:_centerImage];
    _centerImage.today = 1;
    
    //添加返回按钮
    UIButton * fanhui  = [[UIButton alloc]init];
    fanhui.frame =CGRectMake(5, 15, 40, 20);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:fanhui];
    
}

//白天黑夜按钮
- (void)clickDnBtn:(UIButton *)button
{
    button.selected = !button.selected;
    _centerImage.isNight = button.selected;
    
}

//滚动视图按钮
- (void)buttonClick:(UIButton * )button
{
    if (button.selected == NO)
    {
        button.selected = !button.selected;
        _isClick.selected = !_isClick.selected;
        _isClick = button;
        _tipImg.center = CGPointMake(_isClick.center.x, _isClick.center.y - 25);
        
        _centerImage.today = button.tag;
        
    }
   
    
  
}

//返回按钮
- (void)fanhui
{
    [self.navigationController popViewControllerAnimated:YES];
  
}
    




@end
