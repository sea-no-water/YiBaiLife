//
//  centerImageView.m
//  YIbaiLife2.0
//
//  Created by mac on 16/6/23.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "centerImageView.h"
#define useing 10
#define unused 11
@interface centerImageView ()//对当前类的扩展
{
    NSArray * _moonArray;//月亮帧动画数组
    NSArray * _sunArray;//太阳帧动画数组
    UIImageView * _smImage;//太阳月亮图片
    
    NSMutableArray * _starArray;//所有星星的数组
    
    NSTimer * _findCloudTimer;//发现
    NSTimer * _moveCloudTimer;//移动
    NSMutableArray * _cloudArray;//存放云朵数组
    
    NSTimer * _findRainTimer;//发现雨
    NSTimer * _moveRainTimer;//移动雨
    NSMutableArray * _rainArray;//存放雨的数组
}

@end
@implementation centerImageView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
        
        _sunArray = @[[UIImage imageNamed:@"w_sun1" ],[UIImage imageNamed:@"w_sun2"]];
        _moonArray = @[[UIImage imageNamed:@"w_moon1" ],[UIImage imageNamed:@"w_moon2"]];
        
        
        //太阳月亮的图片
        _smImage = [[UIImageView alloc]init];
        _smImage.frame = CGRectMake(160, 10, 80, 80);
        [self addSubview:_smImage];
        //太阳帧动画
        _smImage.animationDuration = 0.5;
        [_smImage startAnimating];
        
        //创建星星
        NSArray * starArray = @[[UIImage imageNamed:@"xx1"],[UIImage imageNamed:@"xx2"]];
        _starArray = [NSMutableArray array];
        for (int i = 0; i<20; i++)
        {
            UIImageView * star = [[UIImageView alloc]init];
            star.frame = CGRectMake(arc4random()%280, arc4random()%100, 15, 15);
            star.animationImages = starArray;
            star.animationDuration = 0.5;
            [self addSubview:star];//添加到图片上
            [_starArray addObject:star];//添加到数组上
            
            
        }
        
        
        //添加云朵
        _cloudArray = [NSMutableArray array];
        for ( int  i = 0; i <5; i ++)
        {
            UIImageView * cloud = [[UIImageView alloc]init];
            cloud.frame = CGRectMake(280, arc4random()%100, 80, 60);
            cloud.tag = unused;//宏定义
            cloud.alpha = 0.95;
            cloud.image = [UIImage imageNamed:@"w_cloud"];
            [self addSubview:cloud];
            [_cloudArray addObject:cloud];
            
        }
        
        //添加雨
        _rainArray = [NSMutableArray array];
        for (int i = 0 ; i < 100; i ++)
        {
            UIImageView * rain = [[UIImageView alloc]init];
            rain.frame = CGRectMake(0, 0, 3, 15);
            rain.tag = unused;
            rain.image = [UIImage imageNamed:@"w_rain"];
            [self addSubview:rain];
            [_rainArray addObject:rain];
            
        }
        
        

        
        
        
        
    }
    return self;
}


//给today赋值
- (void)setToday:(int)today
{
    _today = today;
    [self showWeather];//出现天气
    
}

//给isnight赋值
- (void)setIsNight:(BOOL)isNight
{
    _isNight = isNight;
    [self showWeather];//出现天气
    
}
//出现天气
- (void)showWeather
{
    if (_isNight == YES)//如果是夜晚
    {
        self.image = [UIImage imageNamed:@"w_night" ];
        if (_today == 1 || _today == 5 || _today == 6 || _today == 7)
        {
            [self isneedSm:YES];
            [self isneedStar:YES];
            [self isneedYun:NO];
            [self isneedRain:NO];
            
        }
        if (_today == 2)
        {
            [self isneedSm:YES];
            [self isneedStar:YES];
            [self isneedYun:YES];
            [self isneedRain:NO];
            
        }
        if (_today == 3)
        {
            [self isneedSm:NO];
            [self isneedStar:NO];
            [self isneedYun:NO];
            [self isneedRain:NO];
            
        }
        if (_today == 4)
        {
            [self isneedSm:NO];
            [self isneedStar:NO];
            [self isneedYun:NO];
            [self isneedRain:YES];
            
        }
        
    }
    else//如果是白天
        
    {
        if (_today == 1 || _today == 5 || _today == 6 || _today == 7)
        {
            self.image = [UIImage imageNamed:@"w_qing" ];
            [self isneedSm: YES];
            [self isneedYun:NO];
            [self isneedStar:NO];
            [self isneedRain:NO];
            
        }
        if (_today == 2)
        {
            self.image = [UIImage imageNamed:@"w_duoyun" ];
            [self isneedSm:YES];
            [self isneedYun:YES];
            [self isneedStar:NO];
            [self isneedRain:NO];
            
        }
        if (_today == 3)
        {
            self.image = [UIImage imageNamed:@"w_yin" ];
            [self isneedSm:NO];
            [self isneedYun:NO];
            [self isneedStar:NO];
            [self isneedRain:NO];
            
            
        }
        if (_today == 4)
        {
            self.image = [UIImage imageNamed:@"w_yu" ];
            [self isneedSm:NO];
            [self isneedYun:NO];
            [self isneedStar:NO];
            [self isneedRain:YES];
            
            
        }
    }
}


#pragma mark 判断是否需要太阳月亮
- (void)isneedSm:(BOOL)need
{
    if (need == NO)//如果不需要太阳月亮，关闭帧动画
    {
        [_smImage stopAnimating];
        
    }
    else if(_isNight == YES)//如果是晚上，用月亮的动画
    {
        _smImage.animationImages =_moonArray;
        [_smImage startAnimating];
    }
    else//白天
    {
        _smImage.animationImages = _sunArray;
        [_smImage startAnimating];
    }
}

#pragma mark 判断是否需要星星

- (void)isneedStar:(BOOL)need
{
    if (need == YES)
    {
        for (UIImageView * star in _starArray)
        {
            [star startAnimating];
            
        }
    }
    else
    {
        
        for (UIImageView * star in _starArray)
        {
            [star stopAnimating];
            
        }
        
    }
}

#pragma mark 判断是否需要云朵
- (void)isneedYun:(BOOL)need
{
    
    if (need == YES)//如果需要开启定时器
    {
        [self startClouldTimer];
    }
    else//如果不需要关闭定时器
    {
        [self stopClouldTimer];
    }
}

//开始定时器
- (void)startClouldTimer
{
    //只有定时器没有开启时，才有权限开定时器
    if (_findCloudTimer == nil)
    {
        
        
        _findCloudTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(findCloud) userInfo:nil repeats:YES];
        _moveCloudTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveCloud) userInfo:nil repeats:YES];
    }
}

- (void)stopClouldTimer
{
    //摧毁定时器
    [_findCloudTimer invalidate];
    _findCloudTimer = nil;
    
    [_moveCloudTimer invalidate];
    _moveCloudTimer = nil;
    
    //定时器停止后，防止云朵出现在屏幕上不动
    //移出屏幕外
    for (UIImageView * cloud in _cloudArray)
    {
        cloud.tag = unused;
        cloud.center = CGPointMake(1000, 1000);
    }
    
}



//找云朵
- (void)findCloud
{
    for (UIImageView * cloud in _cloudArray)
    {
        if (cloud.tag == unused)
        {
            cloud.tag = useing;
            cloud.frame = CGRectMake(280, arc4random()%100, arc4random()%100+30, 30);
            
            return;
            
        }
    }
}

//移动云朵
- (void)moveCloud
{
    
    for (UIImageView * cloud in _cloudArray)
    {
        if (cloud.tag == useing)
        {
            float x = cloud.center.x;
            float y = cloud.center.y;
            x -= 1;
            cloud.center = CGPointMake(x, y);
            if (x < -80)
            {
                cloud.tag =unused;
            }
        }
    }
    
    
}


#pragma  mark 判断是否需要雨
- (void)isneedRain:(BOOL)need
{
    if (need == YES)
    {
        [self startRainTimer];
    }
    else
    {
        [self stopRainTimer];
    }
}

//开始雨的定时器
- (void)startRainTimer
{
    if (_findRainTimer == nil)
    {
        
        _findRainTimer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(findRain) userInfo:nil repeats:YES];
        _moveRainTimer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(moveRain) userInfo:nil repeats:YES];
    }
}

//关闭雨的定时器
- (void)stopRainTimer
{
    [_findRainTimer invalidate];
    _findRainTimer = nil;
    [_moveRainTimer invalidate];
    _moveRainTimer = nil;
    //定时器关闭时,雨都变为未使用状态，把雨移出屏幕外
    for (UIImageView * rain in _rainArray)
    {
        
        
        rain.center = CGPointMake(1000, 1000);
        
    }
}


//找雨
- (void)findRain
{
    for (UIImageView *rain in _rainArray)
    {
        if (rain.tag == unused)
        {
            rain.tag = useing;
            rain.center = CGPointMake(arc4random()%280, 0);
            return;
        }
    }
}

//下雨
- (void)moveRain
{
    for (UIImageView * rain in _rainArray)
    {
        if (rain.tag == useing)
        {
            float x = rain.center.x;
            float y = rain.center.y;
            rain.center = CGPointMake(x, y+4);
            if (y >290)
            {
                rain.tag = unused;
                
            }
            
        }
    }
    
}


//停止所有定时器,当退出界面时停止所有的定时器
- (void)stopALLTimer
{
    [self stopClouldTimer];
    [self stopRainTimer];
    
    
}


@end
