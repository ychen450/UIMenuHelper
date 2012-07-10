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

@interface PieChart : UIView {

    float radius;
    
    float red1;
    float red2;
    float green1;
    float green2;
    float blue1;
    float blue2;
    
    NSString* centerImage;
    NSString* patternImage;
    NSString* text1;
    NSString* text2;
    NSString* fontName;
    
    float currentValue;
    
    BOOL endInit;
}

- (id)initWithFrame:(CGRect)frame 
              value:(float)v 
           setColor:(float)r1 green1:(float)g1 blue1:(float)b1 red2:(float)r2 green2:(float)g2 blue2:(float)b2 
           setImage:(NSString*)center patternImage:(NSString*)pattern 
            setText:(NSString*)t1 text2:(NSString*)t2 font:(NSString*)f;

- (void)setPieValue:(float)v;

@end
