//
//  SJLinePointItem.h
//  LearnX2
//
//  Created by 沈骏 on 2018/3/26.
//  Copyright © 2018年 沈骏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SJLinePointItem : NSObject

/** xValue */
@property (strong, nonatomic) NSString *xValue;

/** yValue */
@property (assign, nonatomic) CGFloat yValue;

/** point */
@property (assign, nonatomic) CGPoint point;

@end
