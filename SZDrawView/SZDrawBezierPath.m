//
//  SZDrawBezierPath.m
//  SZDrawView
//
//  Created by Next on 16/8/26.
//  Copyright © 2016年 Next. All rights reserved.
//

#import "SZDrawBezierPath.h"

static UIColor * lineColor;
static CGFloat lineWidth = 5.0;

@implementation SZDrawBezierPath
//
- (instancetype)init{
    self = [super init];
    if (self) {
        lineColor = [UIColor blackColor];
        lineWidth = 5.0f;
    }
    return self;
}
//设置划线的颜色和线宽
+ (void)setLineColor:(UIColor *)color andLineWidth:(CGFloat)width{
    lineColor = color;
    lineWidth = width;
}
//获取已经设好起点的画图对象
+ (instancetype)drawBezierPathWithStartPoint:(CGPoint)pointStart{
    SZDrawBezierPath * path = [[self alloc] init];
    path.lineWidth = lineWidth;
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineCapRound; //终点处理
    [path moveToPoint:pointStart];
    return path;
}
//得到画图对象对应的shapeLayer
+ (CAShapeLayer *)shapeLayerOfCGPathWithDrawBezierPath:(SZDrawBezierPath *)path{
    CAShapeLayer * shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.strokeColor = lineColor.CGColor;
    shapeLayer.lineWidth = path.lineWidth;
    return shapeLayer;
}



@end
