//
//  NewsViewController.m
//  YIbaiLife2.0
//
//  Created by mac on 16/6/23.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

{
   UIButton *  _selectBtn;
    UILabel * _titleLabel;
    UIImageView * _newImg;
    BOOL _isFrame;
    
}
@end

@implementation NewsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor redColor];
   
    //背后的界面
    [self backGroundView];
    
    //前面的界面
    [self qianmianView];
    

    
}




#pragma mark 背后的界面

- (void)backGroundView
{
    //背景界面
    UIImageView * bgImage = [[UIImageView alloc]init];
    bgImage.frame = self.view.bounds;
    bgImage.image = [UIImage imageNamed:@"n_background"];
    [self.view addSubview:bgImage];
 
    
    //选中的按钮
    _selectBtn = [[UIButton alloc]init];
    _selectBtn.backgroundColor = [UIColor grayColor];
    _selectBtn.alpha = 0.5;
    [self.view addSubview:_selectBtn];
    
    
    //六个按钮
    for (int i = 0 ; i < 6; i++)
    {
        UIButton * btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(0, 50+i*65, 320, 50);
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        if (btn.tag == 0)
        {
            _selectBtn.frame = btn.frame;
        }
        
    }
    
    //返回按钮
    UIButton * fanhui = [[UIButton alloc]init];
    fanhui.frame = CGRectMake(15, 450, 30, 20);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhuiClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:fanhui];
    
}


//菜单按钮方法
- (void)btnClick:(UIButton *)btn
{
    UIView * view = [self.view viewWithTag:10];
    
    NSArray *array = @[@"头条",@"娱乐",@"体育",@"科技",@"财经",@"时尚"];
    _newImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"news_%d",btn.tag+1]];
    _titleLabel.text = array [btn.tag];

    [UIView animateWithDuration:0.5 animations:^{
        _selectBtn.frame = btn.frame;
        view.frame = self.view.bounds;
        
    }];

    
}


//返回按钮方法
- (void)fanhuiClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


#pragma mark  前面部分
- (void)qianmianView
{
    //前面视图的view
    UIView * view = [[UIView alloc]init];
    view.tag = 10;
    view.frame  = self.view.bounds;
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    //剪切去多余的
    view.clipsToBounds = YES;
    
    
    //bar
    UIImageView *bar = [[UIImageView alloc]init];
    bar.image = [UIImage imageNamed:@"commonNavBar.png"];
    bar.frame = CGRectMake(0, 0, 320,44);
    [view addSubview:bar];
    //bar2
    UIImageView *bar2 = [[UIImageView alloc]init];
    bar2.image = [UIImage imageNamed:@"commonNavBar.png"];
    bar2.frame = CGRectMake(0, 20, 320,44);
    [view addSubview:bar2];
    
    //创建title的label
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.bounds = CGRectMake(0, 0, 60, 30);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.center = bar2.center;
    _titleLabel.text = @"头条";
    _titleLabel.font = [UIFont systemFontOfSize:25];
    _titleLabel.textColor = [UIColor whiteColor];
    [view addSubview:_titleLabel];
    
    //创建菜单按钮
    UIButton *menu = [[UIButton alloc] init];
    menu.frame = CGRectMake(10, 27, 30, 30);
    [menu setBackgroundImage:[UIImage imageNamed:@"n_menu.png"] forState:UIControlStateNormal];
    [menu addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:menu];
    
    //创建用来显示新闻的图片
    _newImg = [[UIImageView alloc] init];
    _newImg.frame = CGRectMake(0, 64, 320,416);
    _newImg.image = [UIImage imageNamed:@"news_1.png"];
    [view addSubview:_newImg];
    
}

//clickMenu方法
- (void)clickMenu:(UIButton * )button
{
    UIView * view = [self.view viewWithTag:10];

    [UIView animateWithDuration:0.5 animations:^{
                
    view.frame = CGRectMake(150, 50, 320, 400);
    }];

}



@end
