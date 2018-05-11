//
//  LineProgressView.m
//  TestDemo-01
//
//  Created by 武月洋 on 2018/4/26.
//  Copyright © 2018年 武月洋. All rights reserved.
//

#import "LineProgressView.h"

@interface LineProgressView ()

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAShapeLayer *bottomProgressLayer;

@end

@implementation LineProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.progressColor = [UIColor orangeColor];
        self.progressBottomColor = [UIColor lightGrayColor];
        self.progressWidth = 15.f;
        [self setUpSubViews];
    }
    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.progressColor = [UIColor orangeColor];
        self.progressBottomColor = [UIColor lightGrayColor];
        self.progressWidth = 15.f;
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews {
    
    self.bottomProgressLayer = [CAShapeLayer layer];
    self.bottomProgressLayer.strokeColor = self.progressBottomColor.CGColor;
    self.bottomProgressLayer.fillColor = [UIColor clearColor].CGColor;
    self.bottomProgressLayer.lineWidth = self.progressWidth;
    self.bottomProgressLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:self.bottomProgressLayer];
    
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.strokeColor = self.progressColor.CGColor;
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.lineWidth = self.progressWidth;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.strokeEnd = 0;
    [self.layer addSublayer:self.progressLayer];
}

- (void)setProgressWidth:(CGFloat)progressWidth {
    _progressWidth = progressWidth;
    self.progressLayer.lineWidth = _progressWidth;
    self.bottomProgressLayer.lineWidth = _progressWidth;
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.progressLayer.strokeColor = _progressColor.CGColor;
}

- (void)setProgressBottomColor:(UIColor *)progressBottomColor {
    _progressBottomColor = progressBottomColor;
    self.bottomProgressLayer.strokeColor = _progressBottomColor.CGColor;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.duration = 1;
    animation.fromValue = @0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];;
    
    self.progressLayer.strokeEnd = _progress;
    [self.progressLayer addAnimation:animation forKey:@"strokeEnd"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat centerY = self.bounds.size.height/2;
    CGFloat right = self.bounds.size.width - 17;

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(17, centerY)];
    [path addLineToPoint:CGPointMake(right, centerY)];


    self.progressLayer.path = path.CGPath;
    self.bottomProgressLayer.path = path.CGPath;
}

@end
