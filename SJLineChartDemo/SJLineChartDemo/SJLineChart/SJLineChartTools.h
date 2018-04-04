//
//  SJLineChartTools.h
//  LearnX2
//
//  Created by 沈骏 on 2018/3/27.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+SJLineChart.h"

#define P_M(x,y) CGPointMake(x, y)

#define SelfWidth self.width

#define SelfHeight self.height

@interface SJLineChartTools : NSObject

#pragma mark - public method

/**
 *  绘制线段
 *
 *  @param context  图形绘制上下文
 *  @param start    起点
 *  @param end      终点
 *  @param isDotted 是否是虚线
 *  @param color    线段颜色
 */
+ (void)drawLineWithContext:(CGContextRef )context andStarPoint:(CGPoint )start andEndPoint:(CGPoint)end andIsDottedLine:(BOOL)isDotted andColor:(UIColor *)color;

/**
 *  绘制文字
 *
 *  @param text    文字内容
 *  @param context 图形绘制上下文
 *  @param rect    绘制点
 *  @param color   绘制颜色
 */
+ (void)drawText:(NSString *)text andContext:(CGContextRef )context atPoint:(CGPoint )rect WithColor:(UIColor *)color;

/**
 *  判断文本宽度
 *
 *  @param text 文本内容
 *
 *  @return 文本宽度
 */
+ (CGFloat)getTextWithWhenDrawWithText:(NSString *)text;

@end
