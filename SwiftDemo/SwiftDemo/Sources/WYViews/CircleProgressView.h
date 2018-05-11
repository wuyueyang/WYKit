//
//  CircleProgressView.h
//  TestDemo-01
//
//  Created by 武月洋 on 2018/4/26.
//  Copyright © 2018年 武月洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleProgressView : UIView

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) CGFloat progressWidth;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, strong) UIColor *progressBottomColor;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGSize imageSize;

@end
