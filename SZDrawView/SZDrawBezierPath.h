//
//  SZDrawBezierPath.h
//  SZDrawView
//
//  Created by Next on 16/8/26.
//  Copyright © 2016年 Next. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZDrawBezierPath : UIBezierPath
/**
 *  设置划线的颜色和线宽
 *
 *  @param color 划线颜色
 *  @param width 线宽
 */
+ (void)setLineColor:(UIColor *)color andLineWidth:(CGFloat)width;
/**
 *  获取已经设好起点的画图对象
 *
 *  @param pointStart 起点坐标
 *
 *  @return 画图对象
 */
+ (instancetype)drawBezierPathWithStartPoint:(CGPoint)pointStart;
/**
 *  得到画图对象对应的shapeLayer
 *
 *  @param path 画图对象
 *
 *  @return shapeLayer
 */
+ (CAShapeLayer *)shapeLayerOfCGPathWithDrawBezierPath:(SZDrawBezierPath *)path;

@end
