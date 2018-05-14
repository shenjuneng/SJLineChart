//
//  ViewController.m
//  SJLineChartDemo
//
//  Created by 沈骏 on 2018/4/10.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import "ViewController.h"
#import "SJLineChartView.h"
#import <MJExtension.h>

#define UICOLOR_FROM_RGB(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]//取颜色的RGB值

#define kFirstColor                 UICOLOR_FROM_RGB(154, 99, 156, 1)
#define kSecondColor                UICOLOR_FROM_RGB(216, 65, 116, 1)
#define kThirdColor                 UICOLOR_FROM_RGB(177, 186, 61, 1)
#define kForthColor                 UICOLOR_FROM_RGB(112, 121, 176, 1)
#define kFifthColor                 UICOLOR_FROM_RGB(123, 184, 125, 1)
#define kSixthColor                 UICOLOR_FROM_RGB(86, 170, 217, 1)
#define kSevenColor                 UICOLOR_FROM_RGB(205, 126, 111, 1)

@interface ViewController ()<SJLineChartViewDataSource>

@property (weak, nonatomic) IBOutlet SJLineChartView *lineView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _lineView.datasource = self;
}

#pragma mark - SJLineChartViewDataSource
- (NSArray<NSString *> *)xNamesArr {
    return @[@"一月", @"二月", @"三月", @"四月"];
}

- (NSArray<SJLinePointItem *> *)valueArrArr {
    NSArray *dicArrArr = @[@[@{@"xValue" : @"一月", @"yValue" : @(0.5)}, @{@"xValue" : @"三月", @"yValue" : @(1.2)}, @{@"xValue" : @"四月", @"yValue" : @(10.8)}],
                           @[@{@"xValue" : @"一月", @"yValue" : @(-8.1)}, @{@"xValue" : @"四月", @"yValue" : @(1.2)}]];
    
    //    NSArray *dicArrArr = @[];
    
    //    NSArray *dicArrArr = @[@[@{@"xValue" : @"一月", @"yValue" : @(50)}]];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSArray *arr in dicArrArr) {
        NSArray *modelArr = [SJLinePointItem mj_objectArrayWithKeyValuesArray:arr];
        [tempArr addObject:modelArr];
    }
    
    return tempArr;
}

- (UIColor *)lineColorWithIndex:(NSInteger)index {
    NSArray *catColorArr = @[kFirstColor, kSecondColor, kThirdColor, kForthColor, kFifthColor, kSixthColor, kSevenColor];
    
    return catColorArr[index];
}



@end
