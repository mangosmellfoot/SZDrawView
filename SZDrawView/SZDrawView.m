//
//  SZDrawView.m
//  SZDrawView
//
//  Created by Next on 16/8/26.
//  Copyright © 2016年 Next. All rights reserved.
//

#import "SZDrawView.h"
#import "SZDrawBezierPath.h"

@interface SZDrawView ()

@property (nonatomic,strong) SZDrawBezierPath * path;               //绘图类
@property (nonatomic,strong) CAShapeLayer * shapeLayer;             //图像显示layer

@end

@implementation SZDrawView

//
- (instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}
//
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}
//
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([event allTouches].count == 1) {
        CGPoint startPoint = [[touches anyObject] locationInView:self];     //根据touches集合获取对应的触摸点
        _path = [SZDrawBezierPath drawBezierPathWithStartPoint:startPoint];
        _shapeLayer = [SZDrawBezierPath shapeLayerOfCGPathWithDrawBezierPath:_path];
        [self.layer addSublayer:_shapeLayer];
    }
}
//
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([event allTouches].count == 1) {
        CGPoint movePoint = [[touches anyObject] locationInView:self];     //根据touches集合获取对应的触摸点
        [_path addLineToPoint:movePoint];
        _shapeLayer.path = _path.CGPath;
    } else {
        [self.superview touchesMoved:touches withEvent:event];
    }
}
//
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
//保存绘出图像
- (UIImage *)saveViewToImage{
    UIGraphicsBeginImageContext(self.frame.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
