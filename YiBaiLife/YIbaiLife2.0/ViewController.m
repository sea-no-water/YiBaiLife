//
//  ViewController.m
//  YIbaiLife2.0
//
//  Created by mac on 16/6/22.
//  Copyright (c) 2016年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "CSButton.h"
#import "CSUIImageView.h"
#import "ZhuYeViewController.h"
@interface ViewController ()
{
    NSMutableArray * _Fimages;
    int _rightCount;
}


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //背景
    [self beijing];
    //创建10张图片
    [self  image];
    //创建按钮
    [self button];
    







}


//
- (void)beijing
{
    CSUIImageView * beijingImg = [[CSUIImageView alloc]init];
    beijingImg.frame = CGRectMake(0, 0, 320, 480);
    beijingImg.image = [UIImage imageNamed:@"bg.jpg"];
    [self.view addSubview: beijingImg];
    
}

//
- (void)image
{
    _Fimages = [NSMutableArray array];
    NSMutableArray * allImages = [NSMutableArray array];
    for (int i = 0; i < 10 ; i ++)
    {
        CSUIImageView * img = [[CSUIImageView alloc] init];
        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"b_%d.png",i]];
        img.tag = i;
        img.isCover = NO;
        [allImages addObject:img];
        
    }
    for (int i = 0 ; i < 4; i ++)
    {
        int index = arc4random()%allImages.count;
        CSUIImageView * imgview = allImages[index];
        imgview.frame = CGRectMake(15 + i*80, 100, 50, 50);
        [self.view addSubview:imgview];
        [_Fimages addObject:imgview];
        [allImages removeObject:imgview];
        
    }
    
}


//
- (void)button
{
    
    for (int i = 0 ; i < 10; i ++)
    {
        CSButton * button = [[CSButton alloc]init];
        button.frame = CGRectMake(12 + i%5*64, 300 + i/5*64, 40, 40);
        button.tag = i;
        button.isUp = NO;
        button.lastCenter = button.center;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"s_%d",i] ]forState:UIControlStateNormal];
         [self.view addSubview:button];
        
        
    }
    
}



//
- (void)buttonClick:(CSButton   *)button
{
    
    
    
    if (button.isUp == NO)
    {
        for (CSUIImageView * img in _Fimages)
        {
            if (img.isCover == NO)
            {
                img.isCover = YES;
                button.isUp = YES;
                button.coverImage = img;
                [UIView animateWithDuration:0.5 animations:^{
                    button.center = img.center;

                    
                }completion:^(BOOL finished) {
                    if (button.tag == img.tag)
                    {
                        _rightCount ++;
                    }
                    if (_rightCount == 4)
                    {
                        [self gotoNextView];
                    }
                }];
                break;

            }
        }
    }
    else
    {
        button.isUp = NO;
        button.coverImage.isCover = NO;
        if (button.tag == button.coverImage.tag)
        {
            _rightCount --;
        }
        [UIView animateWithDuration:0.5 animations:^{
            
            button.center = button.lastCenter;

        }];
        
    }
    
    
    
    
    
}


//
- (void)gotoNextView
{
    //设置跳转时的动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view.window cache:YES];
    [UIView commitAnimations];
    
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    ZhuYeViewController * vc = [[ZhuYeViewController alloc]init];
    
    window.rootViewController = vc;
    
    
}









@end
