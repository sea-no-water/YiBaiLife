//
//  CSButton.h
//  YIbaiLife2.0
//
//  Created by mac on 16/6/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSUIImageView.h"
@interface CSButton : UIButton

@property BOOL isUp;
@property CGPoint lastCenter;
@property CSUIImageView * coverImage;
@end
