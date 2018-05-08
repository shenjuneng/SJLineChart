//
//  SJLineChartContentView.h
//  LearnX2
//
//  Created by 沈骏 on 2018/3/26.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import "SJLineChartView.h"

@interface SJLineChartContentView : UIView

@property (weak, nonatomic) id<SJLineChartViewDataSource> datasource;

/*         x,y轴刻度值颜色          */
@property (nonatomic,strong) UIColor * xAndYNumberColor;

/*         x y轴线条颜色          */
@property (nonatomic,strong) UIColor * xAndYLineColor;

/** X轴刻度间隔 */
@property (assign, nonatomic) CGFloat xInterVal;

/** 表格四周边距 */
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

/**
 单位y值的长度
 */
@property (assign, nonatomic) CGFloat yPerValueLength;
/**
 y轴 0点位置
 */
@property (assign, nonatomic) CGFloat yZero;

/** 值数组 */
@property (strong, nonatomic) NSArray *valueArrArr;

@end
