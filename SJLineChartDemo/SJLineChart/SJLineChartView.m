//
//  SJLineChartView.m
//  LearnX2
//
//  Created by 沈骏 on 2018/3/26.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import "SJLineChartView.h"
#import "SJLineChartContentView.h"
#import "SJLineChartTools.h"



@interface SJLineChartView()

/** Y轴刻度间隔 */
@property (assign, nonatomic) CGFloat yInterVal;
/**
 单位y值的长度
 */
@property (assign, nonatomic) CGFloat yPerValueLength;
/**
 y轴 0点位置
 */
@property (assign, nonatomic) CGFloat yZero;
/** 表格四周边距 */
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

/** 滚动视图 */
@property (strong, nonatomic) UIScrollView *scrollView;

/** X轴长度（根据X轴间隔计算） */
@property (assign, nonatomic) CGFloat xContentScrollView;

/**
 X轴
 */
@property (nonatomic, strong) SJLineChartContentView *xAxisView;


@end

@implementation SJLineChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSet];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self defaultSet];
    }
    return self;
}

- (void)defaultSet {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];

    
    _edgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    _xAndYNumberColor = [UIColor blackColor];
    _xAndYLineColor = [UIColor blackColor];
    _xInterVal = 30.0;
}


/**
 后于 layoutSubviews
 这个方法以后 可以使用 SelfWidth 

 @param rect 位置大小
 */
- (void)drawRect:(CGRect)rect {
    
    [self setupScaleData];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 绘制Y轴
    [SJLineChartTools drawLineWithContext:context andStarPoint:P_M(_edgeInsets.left, SelfHeight - _edgeInsets.bottom) andEndPoint:P_M(_edgeInsets.left, _edgeInsets.top) andIsDottedLine:NO andColor:_xAndYLineColor];
    
    [SJLineChartTools drawLineWithContext:context andStarPoint:P_M(_edgeInsets.left, SelfHeight - _edgeInsets.bottom) andEndPoint:P_M(SelfWidth, SelfHeight - _edgeInsets.bottom) andIsDottedLine:NO andColor:_xAndYLineColor];
    
    // 绘制 刻度
    for (NSInteger i = 0; i < _yLineDataArr.count; i++) {
        CGPoint p = P_M(_edgeInsets.left, SelfHeight - _edgeInsets.bottom - (i + 1)*_yInterVal);
        CGFloat len = [SJLineChartTools getTextWithWhenDrawWithText:[NSString stringWithFormat:@"%@", _yLineDataArr[i]]];
        // y轴上半部分的横杠
        [SJLineChartTools drawLineWithContext:context andStarPoint:p andEndPoint:P_M(p.x+SelfWidth-_edgeInsets.left, p.y) andIsDottedLine:YES andColor:_xAndYLineColor];
        [SJLineChartTools drawText:[NSString stringWithFormat:@"%@",_yLineDataArr[i]] andContext:context atPoint:P_M(p.x-len-2, p.y-3) WithColor:_xAndYNumberColor];
    }
}

/**
 会调用2次， 且先于 drawRect
 */
- (void)layoutSubviews {
    
}


#pragma mark - prviate
/**
 设置 X轴 Y轴滚动范围
 */
- (void)setupScaleData {
//    // 设置contentChart
//    [self updateXScale];
    
    // 设置y轴的刻度
    [self updateYScale];
    
    // 设置contentChart
    [self updateXScale];
}

/**
 *  更新Y轴的刻度大小
 */
- (void)updateYScale {
    CGFloat max = 0;
    CGFloat min = 0;
    
    for (NSArray *arr in [self.datasource valueArrArr]) {
        for (SJLinePointItem *item in arr) {
            if (item.yValue >= max) {
                max = item.yValue;
            }
            if (item.yValue <= min) {
                min = item.yValue;
            }
        }
    }
    
    // 取整
    NSInteger maxInt = ceilf(fabs(max));
    NSInteger minInt = ceilf(fabs(min));
    
    maxInt = minInt > maxInt ? minInt : maxInt;
    

    if (maxInt%5 == 0) {
        maxInt = maxInt;
    } else {
        maxInt = (maxInt/5 + 1)*5;
    }
    
    NSMutableArray *topArr = [NSMutableArray array];
    if (maxInt == 5) {
        for (NSInteger i = 0; i < 5; i++) {
            [topArr addObject:@(i+1)];
        }
    } else if (maxInt == 10) {
        for (NSInteger i = 0; i < 5; i++) {
            [topArr addObject:@((i+1)*2)];
        }
    } else if (maxInt > 10) {
        for (NSInteger i = 0; i < maxInt/5; i++) {
            [topArr addObject:@((i+1)*5)];
        }
    }
    
    if (min < 0) {
        NSMutableArray *bottomArr = [NSMutableArray array];
        for (NSNumber *num in topArr) {
            [bottomArr insertObject:@(-[num integerValue]) atIndex:0];
        }
        [bottomArr addObject:@(0)];
        [bottomArr addObjectsFromArray:topArr];
        
        _yLineDataArr = bottomArr;
    } else {
        _yLineDataArr = topArr;
    }
    
    // 得到y轴间距
    _yInterVal = (SelfHeight - _edgeInsets.bottom - _edgeInsets.top)/(_yLineDataArr.count + 1);
    
    // 得到 单位y值的长度 和 Y轴0点
    if (_yLineDataArr.count >= 2) {
        CGFloat perValue = [_yLineDataArr[0] floatValue];
        CGFloat nextValue = [_yLineDataArr[1] floatValue];
        CGFloat dValuel = nextValue - perValue;
        
        _yPerValueLength = _yInterVal/dValuel;
    }
    
    
    if (min < 0) {
        NSInteger zeroIndex = [_yLineDataArr indexOfObject:@0];
        _yZero = SelfHeight - _edgeInsets.bottom - _yInterVal*(zeroIndex + 1);
    } else {
        _yZero = SelfHeight - _edgeInsets.bottom;
    }
}

/**
 *  更新X轴的刻度大小
 */
- (void)updateXScale {
    NSLog(@"%@", [self.datasource xNamesArr]);
    _xInterVal = 30;
    if ([self.datasource xNamesArr].count*_xInterVal < SelfWidth - _edgeInsets.left - _edgeInsets.right && [self.datasource xNamesArr].count > 1) {
        _xInterVal = (SelfWidth - _edgeInsets.left - _edgeInsets.right)/[self.datasource xNamesArr].count;
    }
    
    _xContentScrollView = _xInterVal*([self.datasource xNamesArr].count + 1);
    
    _scrollView.frame = CGRectMake(_edgeInsets.left, 0, SelfWidth - _edgeInsets.left, SelfHeight);
    _scrollView.contentSize = CGSizeMake(_xContentScrollView, SelfHeight);
    
    [_xAxisView removeFromSuperview];
    _xAxisView = [[SJLineChartContentView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.contentSize.width, SelfHeight)];
    _xAxisView.backgroundColor = [UIColor clearColor];
    _xAxisView.datasource = self.datasource;
    _xAxisView.xAndYNumberColor = _xAndYNumberColor;
    _xAxisView.xAndYLineColor = _xAndYLineColor;
    _xAxisView.xInterVal = _xInterVal;
    _xAxisView.edgeInsets = UIEdgeInsetsMake(_edgeInsets.top, 0, _edgeInsets.bottom, 0);
    _xAxisView.yZero = _yZero;
    _xAxisView.yPerValueLength = _yPerValueLength;
    [_scrollView addSubview:_xAxisView];
}

#pragma mark - public
- (void)reloadSubViews {
    [self setNeedsDisplay];
}

@end
