//
//  PieChart.h
//  UIMenuHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PieChart : UIView 

@property float pievalue;
@property (nonatomic, weak) NSString *midtext;
@property (nonatomic, weak) UIColor *color1;
@property (nonatomic, weak) UIColor *color2;

- (id)initWithFrame:(CGRect)frame;

@end
