//
//  SJLineChartXView.m
//  LearnX2
//
//  Created by 沈骏 on 2018/3/26.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import "SJLineChartContentView.h"
#import "SJLineChartTools.h"

@interface SJLineChartContentView ()


@end

@implementation SJLineChartContentView

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (NSInteger i = 0; i < [self.datasource xNamesArr].count; i++) {
        CGPoint p = P_M((i + 1)*_xInterVal, SelfHeight - _edgeInsets.bottom);
        CGFloat len = [SJLineChartTools getTextWithWhenDrawWithText:[NSString stringWithFormat:@"%@", [self.datasource xNamesArr][i]]];
        
        // X轴上半部分的横杠
        [SJLineChartTools drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x, _edgeInsets.top) andIsDottedLine:YES andColor:_xAndYLineColor];
        [SJLineChartTools drawText:[NSString stringWithFormat:@"%@",[self.datasource xNamesArr][i]] andContext:context atPoint:P_M(p.x-len/2, p.y+2) WithColor:_xAndYNumberColor];
    }
    
    NSInteger i = 0;
    for (NSArray *arr in self.valueArrArr) {
        [self drawPathWithDataArr:arr lineColor:[self.datasource lineColorWithIndex:i]];
        i++;
    }
}

/**
 开始画折线
 */
- (void)drwaAnimation {
 
    
}


/**
 画一条折线

 @param dataArr 折线数组
 @param color 折线颜色
 */


- (void)drawPathWithDataArr:(NSArray *)dataArr lineColor:(UIColor *)color {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
//    CGContextRestoreGState(context);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (SJLinePointItem *item in dataArr) {
        if ([dataArr.firstObject isEqual:item]) {
            [path moveToPoint:item.point];
        } else {
            [path addLineToPoint:item.point];
        }
        [path moveToPoint:item.point];

        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextAddArc(context, item.point.x, item.point.y, 2, 0, M_PI*2, 0);
        CGContextDrawPath(context, kCGPathFillStroke);
        
        
        CGFloat len = [SJLineChartTools getTextWithWhenDrawWithText:[NSString stringWithFormat:@"%.2f", item.yValue]];
        [SJLineChartTools drawText:[NSString stringWithFormat:@"%.2f", item.yValue] andContext:context atPoint:CGPointMake(item.point.x - len/2, item.point.y - 10) WithColor:color];
    }

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = color.CGColor;
    [self.layer addSublayer:shapeLayer];
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = 2;
    [shapeLayer addAnimation:ani forKey:nil];
    
}

#pragma mark - set get
- (NSArray *)valueArrArr {
    if (_valueArrArr == nil) {
        _valueArrArr = [self.datasource valueArrArr];
        // 整理所有点的位置
        for (NSArray *arr in _valueArrArr) {
            for (SJLinePointItem *item in arr) {
                NSInteger index = 0;
                for (NSString *xName in [self.datasource xNamesArr]) {
                    if ([xName isEqualToString:item.xValue]) {
                        index = [[self.datasource xNamesArr] indexOfObject:xName];
                    }
                }
                CGFloat x = _xInterVal*(index + 1);
        
                CGFloat y =  _yZero - item.yValue*_yPerValueLength;
                item.point = CGPointMake(x, y);
            }
        }
    }
    return _valueArrArr;
}

@end
