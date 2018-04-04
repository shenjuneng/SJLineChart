//
//  SJLineChartView.h
//  LearnX2
//
//  Created by 沈骏 on 2018/3/26.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJLinePointItem.h"


@protocol SJLineChartViewDataSource<NSObject>

@required

- (NSArray<NSString *> *)xNamesArr;

- (NSArray<SJLinePointItem *> *)valueArrArr;

@optional

- (UIColor *)lineColorWithIndex:(NSInteger)index;

@end

@interface SJLineChartView : UIView

@property (weak, nonatomic) id<SJLineChartViewDataSource> datasource;
/**
 Y轴上的刻度列表
 */
@property (nonatomic,strong) NSArray * yLineDataArr;



/*         x,y轴刻度值颜色          */
@property (nonatomic,strong) UIColor * xAndYNumberColor;

/*         x y轴线条颜色          */
@property (nonatomic,strong) UIColor * xAndYLineColor;

/** X轴刻度间隔 */
@property (assign, nonatomic) CGFloat xInterVal;

#pragma mark - public
- (void)reloadSubViews;



@end
