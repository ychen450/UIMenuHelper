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

@synthesize pievalue, midtext, color1, color2;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
	CGRect f = self.bounds;
	CGPoint o = CGPointMake( f.size.width/2.0, f.size.height/2.0);
	CGFloat minDimension = MIN( f.size.width, f.size.height );
	CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextClearRect(c, rect);
    
	NSMutableArray* segAngles = [NSMutableArray array];
    
    [segAngles addObject:[NSNumber numberWithFloat:pievalue * 2.0 * M_PI]];
	[segAngles addObject:[NSNumber numberWithFloat:(1.0-pievalue) * 2.0 * M_PI]];
    
	float sAngle = 0.0;
	float radius = minDimension/2.0;
	for( int i=0; i<[segAngles count]; i++ )
	{
		float eAngle = sAngle + [[segAngles objectAtIndex:i] floatValue];
        
		// Draw the pie-segment 
		CGContextBeginPath(c);
		CGContextMoveToPoint(c, o.x, o.y);
		CGContextAddArc(c, o.x, o.y, radius, sAngle, eAngle, 0);
        if (i==0) {
            CGContextSetFillColorWithColor(c, [color1 CGColor]);
        } else {
            CGContextSetFillColorWithColor(c, [color2 CGColor]);
        }
		CGContextFillPath(c);
        
		sAngle = eAngle;
	}
    
    CGContextSetFillColorWithColor(c, [UIColor whiteColor].CGColor);
    CGContextFillEllipseInRect(c, CGRectMake(10, 10, 40, 40));
    
    UILabel *lbNumber = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    lbNumber.backgroundColor = [UIColor clearColor];
    lbNumber.textAlignment = UITextAlignmentCenter;
    lbNumber.font = [UIFont systemFontOfSize:12];
    lbNumber.text = [NSString stringWithFormat:@"%d",220];
    [self addSubview:lbNumber];
}


@end
