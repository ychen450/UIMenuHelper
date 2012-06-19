//
//  PieChart.h
//  UIMenuHelper
//
//  Created by Yan-Ling, Chen on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PieChart : UIView 

@property float pievalue;
@property (nonatomic, weak) NSString *midtext;
@property (nonatomic, weak) UIColor *color1;
@property (nonatomic, weak) UIColor *color2;

- (id)initWithFrame:(CGRect)frame;

@end
