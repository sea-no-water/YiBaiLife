//
//  ZhuYeViewController.m
//  YIbaiLife2.0
//
//  Created by mac on 16/6/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ZhuYeViewController.h"
#import "ZYButton.h"
#import "WeatherViewController.h"
#import "NewsViewController.h"
#import "SearchViewController.h"
#import "CityViewController.h"
@interface ZhuYeViewController ()
@property NSMutableArray * btnArray;
@property NSTimer * timer;
@end

@implementation ZhuYeViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationController * nav = [[UINavigationController alloc]init];
    nav.navigationBarHidden = YES;
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = nav;
    [nav pushViewController:self animated:YES];

    //背景
    [self beijing];
    //四个按钮
    [self buttonFour];




}


//
- (void)beijing
{
    UIImageView * beijing = [[UIImageView alloc] init];
    beijing.frame = CGRectMake(0, 0, 320, 480);
    beijing.image = [UIImage imageNamed:@"bg2.jpg"];
    [self.view addSubview:beijing];
    
}


//
- (void)buttonFour
{
    _btnArray = [NSMutableArray array];
    
    for (int i = 0; i <4; i ++)
    {
        ZYButton * button = [[ZYButton alloc] init];
        button.angle = i*90;
        double hudu = button.angle*M_PI/180;
        button.frame = CGRectMake(135 + 100*cos(hudu), 225 + 100*sin(hudu), 50, 50);
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"m_item%d",i+1]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = i;
        
        [_btnArray addObject:button];
        [self.view addSubview:button];
        

        
    }
}


//
- (void)selectButton:(ZYButton *)button
{
    //如果定时器正在运行，则不再创建定时器
    if (_timer != nil)
    {
        return;
    }

    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveBtn) userInfo:button repeats:YES];

}


//
- (void)moveBtn
{
    ZYButton * button = _timer.userInfo;
    //角度为270
    if (button.angle%360 == 270)
    {
        //销毁定时器
        [_timer invalidate];
        _timer = nil;
        
        //通过tag值判断点击的时那个按钮
        if (button.tag == 0)
        {
            NSLog(@"天气");
            [self goToWheather];
        }
        if (button.tag == 1)
        {
            [self gotoSouSuo];
            NSLog(@"搜索");
        }
        if (button.tag == 2)
        {
            [self gotoCity];
            NSLog(@"城市");
        }
        if (button.tag == 3)
        {
            [self gotoNews];
            NSLog(@"新闻");
        }
        return;
    }
    
    
    //让按钮旋转
    for (ZYButton * button in _btnArray)
    {
        button.angle ++;
        double hudu = button.angle*M_PI/180;
        button.frame = CGRectMake(135 + 100*cos(hudu), 225 + 100*sin(hudu), 50, 50);
    }
    
    
    
    
}

//天气界面
- (void)goToWheather
{
    UINavigationController * nav = self.navigationController;
    nav.navigationBar.hidden = YES;
    WeatherViewController * vc = [[WeatherViewController alloc]init];
    [nav pushViewController:vc animated:YES];
 

}



//新闻界面
- (void)gotoNews

{
    NewsViewController * vc = [[NewsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//搜索界面
- (void)gotoSouSuo
{
    SearchViewController * vc = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


//城市界面
- (void)gotoCity
{
    CityViewController * vc = [[CityViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}





@end
