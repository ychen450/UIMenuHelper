//
//  PieChart.m
//  UIMenuHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import "PieChart.h"

@implementation PieChart

- (id)initWithFrame:(CGRect)frame 
              value:(float)v 
           setColor:(float)r1 green1:(float)g1 blue1:(float)b1 red2:(float)r2 green2:(float)g2 blue2:(float)b2 
           setImage:(NSString*)center patternImage:(NSString*)pattern 
            setText:(NSString*)t1 text2:(NSString*)t2 font:(NSString*)f
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        red1 = r1;
        red2 = r2;
        green1 = g1;
        green2 = g2;
        blue1 = b1;
        blue2 = b2;
        currentValue = v;
        centerImage = center;
        patternImage = pattern;
        text1 = t1;
        text2 = t2;
        fontName = f;
        endInit = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
	CGRect f = self.bounds;
	CGPoint o = CGPointMake( f.size.width/2.0, f.size.height/2.0);
	CGFloat minDimension = MIN( f.size.width, f.size.height );
	CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextClearRect(c, rect);
    
	NSMutableArray* segAngles = [NSMutableArray array];
    
    [segAngles addObject:[NSNumber numberWithFloat:currentValue * 2.0 * M_PI]];
	[segAngles addObject:[NSNumber numberWithFloat:(1.0-currentValue) * 2.0 * M_PI]];
    
	float sAngle = -M_PI_2;
	radius = minDimension/3.0;
	for( int i=0; i<[segAngles count]; i++ )
	{
		float eAngle = sAngle + [[segAngles objectAtIndex:i] floatValue];
        
		// Draw the pie-segment 
		CGContextBeginPath(c);
		CGContextMoveToPoint(c, o.x, o.y);
		CGContextAddArc(c, o.x, o.y, radius, sAngle, eAngle, 0);
        if (i==0) {
            CGContextSetRGBFillColor(c, red1, green1, blue1, 1.0);
        } else {
            CGContextSetRGBFillColor(c, red2, green2, blue2, 1.0);
        }
		CGContextFillPath(c);
        
		sAngle = eAngle;
	}
    
    NSLog(@"draw rect: current %f",currentValue);
    
    if (!endInit) {
        UIImageView *piv = [[UIImageView alloc] initWithFrame:CGRectMake(f.size.width/2-radius, f.size.height/2-radius, radius*2, radius*2)];
        piv.image = [UIImage imageNamed:patternImage];
        [self addSubview:piv];
        UIImageView *civ = [[UIImageView alloc] initWithFrame:CGRectMake(f.size.width/2-radius*0.6, f.size.height/2-radius*0.6, radius*1.2, radius*1.2)];
        civ.image = [UIImage imageNamed:centerImage];
        [self addSubview:civ];
        
        UILabel *lbNumber = [[UILabel alloc] initWithFrame:CGRectMake(f.size.width/2-radius*0.6, f.size.height/2-radius*0.7, radius*1.2, radius*1.2)];
        lbNumber.backgroundColor = [UIColor clearColor];
        lbNumber.textAlignment = UITextAlignmentCenter;
        lbNumber.textColor = [UIColor colorWithRed:red1 green:green1 blue:blue1 alpha:1.0];
        lbNumber.numberOfLines = 1;
        lbNumber.minimumFontSize = 10.0;
        lbNumber.adjustsFontSizeToFitWidth = YES;
        lbNumber.text = text1;
        float fontSize = 40.0;
        CGFloat width = 1.0;
        while (width>0) {
            width = [text1 sizeWithFont:[UIFont fontWithName:fontName size:fontSize]].width;
            fontSize = fontSize - 1.0;
            width = width - radius*0.9;
        }
        lbNumber.font = [UIFont fontWithName:fontName size:fontSize];
        [self addSubview:lbNumber];
        
        UILabel *lbPoint = [[UILabel alloc] initWithFrame:CGRectMake(f.size.width/2-radius*0.6, f.size.height/2-radius*0.4, radius*1.2, radius*1.2)];
        lbPoint.backgroundColor = [UIColor clearColor];
        lbPoint.textAlignment = UITextAlignmentCenter;
        lbPoint.textColor = [UIColor colorWithRed:red1 green:green1 blue:blue1 alpha:1.0];
        lbPoint.numberOfLines = 1;
        lbPoint.minimumFontSize = 8.0;
        lbPoint.adjustsFontSizeToFitWidth = YES;
        lbPoint.text = text2;
        fontSize = 40.0;
        width = 1.0;
        while (width>0) {
            width = [text2 sizeWithFont:[UIFont fontWithName:fontName size:fontSize]].width;
            fontSize = fontSize - 1.0;
            width = width - radius*0.7;
        }
        lbPoint.font = [UIFont fontWithName:fontName size:fontSize];
        [self addSubview:lbPoint];
        endInit = YES;
    }
}


- (void)setPieValue:(float)v {
    
    if (v!=currentValue) {
        currentValue = v;
        [self drawRect:self.bounds];
    }
}


@end
