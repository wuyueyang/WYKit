//
//  LineProgressView.h
//  TestDemo-01
//
//  Created by 武月洋 on 2018/4/26.
//  Copyright © 2018年 武月洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineProgressView : UIView

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) CGFloat progressWidth;

@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, strong) UIColor *progressBottomColor;

@end
