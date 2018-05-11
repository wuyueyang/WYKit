//
//  CircleProgressView.m
//  TestDemo-01
//
//  Created by 武月洋 on 2018/4/26.
//  Copyright © 2018年 武月洋. All rights reserved.
//

#import "CircleProgressView.h"

@interface CircleProgressView()
// 外圈灰色大圆
@property (nonatomic, strong) CAShapeLayer *bigBaseLayer;
// 带颜色的大圆
@property (nonatomic, strong) CAShapeLayer *bigShapeLayer;

@property (nonatomic, strong) UIImageView *completImage;

@end;

@implementation CircleProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.progressColor = [UIColor orangeColor];
        self.progressBottomColor = [UIColor lightGrayColor];
        self.progressWidth = 5.f;
        self.imageSize = CGSizeMake(15, 15);
        [self setUpSubViews];
    }
    return self;

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.progressColor = [UIColor orangeColor];
        self.progressBottomColor = [UIColor lightGrayColor];
        self.progressWidth = 5.f;
        [self setUpSubViews];
    }
    return self;
}


- (void)setUpSubViews {
    
    self.bigBaseLayer = [CAShapeLayer layer];
    self.bigBaseLayer.lineWidth = self.progressWidth;
    self.bigBaseLayer.strokeColor = self.progressBottomColor.CGColor;
    self.bigBaseLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:self.bigBaseLayer];

    self.bigShapeLayer = [CAShapeLayer layer];
    self.bigShapeLayer.lineWidth = self.progressWidth;
    self.bigShapeLayer.lineCap = kCALineCapButt;
    self.bigShapeLayer.strokeColor = self.progressColor.CGColor;
    self.bigShapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.bigShapeLayer.strokeEnd = 0;
    [self.bigBaseLayer addSublayer:self.bigShapeLayer];
    
    _completImage = [[UIImageView alloc] init];
    _completImage.hidden = YES;
    [self addSubview:_completImage];
}

- (void)setProgressWidth:(CGFloat)progressWidth {
    _progressWidth = progressWidth;
    self.bigBaseLayer.lineWidth = _progressWidth;
    self.bigShapeLayer.lineWidth = _progressWidth;
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.bigShapeLayer.strokeColor = _progressColor.CGColor;
}

- (void)setProgressBottomColor:(UIColor *)progressBottomColor {
    _progressBottomColor = progressBottomColor;
    self.bigBaseLayer.strokeColor = _progressBottomColor.CGColor;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.duration = 1;
    animation.fromValue = @0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];;
    
    self.bigShapeLayer.strokeEnd = _progress;
    [self.bigShapeLayer addAnimation:animation forKey:@"strokeEnd"];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    if (_image) {
        _completImage.hidden = NO;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height)/2 - self.progressWidth/2;
    
    UIBezierPath *bigPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:M_PI_2 * 3 endAngle:-M_PI_2 clockwise:NO];
    
    self.bigBaseLayer.path = bigPath.CGPath;
    self.bigShapeLayer.path = bigPath.CGPath;
    
    CGFloat imageX = (self.bounds.size.width - _imageSize.width)/2;
    CGFloat imageY = (self.bounds.size.height - _imageSize.height)/2;
    _completImage.frame = CGRectMake(imageX, imageY, _imageSize.width, _imageSize.height);
    _completImage.image = _image;
}

@end
