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
    
	float sAngle = -M_PI_2;
	float radius = minDimension/3.0;
	for( int i=0; i<[segAngles count]; i++ )
	{
		float eAngle = sAngle + [[segAngles objectAtIndex:i] floatValue];
        
		// Draw the pie-segment 
		CGContextBeginPath(c);
		CGContextMoveToPoint(c, o.x, o.y);
		CGContextAddArc(c, o.x, o.y, radius, sAngle, eAngle, 0);
        if (i==0) {
            //CGContextSetFillColorWithColor(c, color1.CGColor);
            CGContextSetRGBFillColor(c, 203./255., 51./255., 51./255., 1.0);
        } else {
            //CGContextSetFillColorWithColor(c, color2.CGColor);
            CGContextSetRGBFillColor(c, 250./255., 153./255., 51./255., 1.0);
        }
		CGContextFillPath(c);
        
		sAngle = eAngle;
	}
    
    //CGContextSetFillColorWithColor(c, [UIColor whiteColor].CGColor);
    //CGContextFillEllipseInRect(c, CGRectMake(f.size.width/2-radius*0.6, f.size.height/2-radius*0.6, radius*1.2, radius*1.2));
    
    UIImageView *pattern = [[UIImageView alloc] initWithFrame:CGRectMake(f.size.width/2-radius, f.size.height/2-radius, radius*2, radius*2)];
    pattern.image = [UIImage imageNamed:@"pattern.png"];
    [self addSubview:pattern];
    UIImageView *center = [[UIImageView alloc] initWithFrame:CGRectMake(f.size.width/2-radius*0.6, f.size.height/2-radius*0.6, radius*1.2, radius*1.2)];
    center.image = [UIImage imageNamed:@"circle.png"];
    [self addSubview:center];
    
    UILabel *lbNumber = [[UILabel alloc] initWithFrame:CGRectMake(f.size.width/2-radius*0.6, f.size.height/2-radius*0.6, radius*1.2, radius*1.2)];
    lbNumber.backgroundColor = [UIColor clearColor];
    lbNumber.textAlignment = UITextAlignmentCenter;
    
    lbNumber.numberOfLines = 1;
    lbNumber.minimumFontSize = 18.0;
    lbNumber.adjustsFontSizeToFitWidth = YES;
    lbNumber.text = [NSString stringWithFormat:@"%d",220];
    float fontSize = 40.0;
    CGFloat width = 1.0;
    while (width>0) {
        width = [@"220" sizeWithFont:[UIFont fontWithName:@"Helvetica" size:fontSize]].width;
        fontSize = fontSize - 2.0;
        width = width - radius;
    }
    lbNumber.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    
    [self addSubview:lbNumber];
}


@end
