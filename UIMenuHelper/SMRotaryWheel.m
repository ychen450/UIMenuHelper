//
//  SMRotaryWheel.m
//  RotaryWheelProject
//
//  Created by cesarerocchi on 2/10/12.
//  Copyright (c) 2012 studiomagnolia.com. All rights reserved.

#import "SMRotaryWheel.h"
#import <QuartzCore/QuartzCore.h>

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


static float deltaAngle;


@implementation SMRotaryWheel

@synthesize startTransform, container, cloves, currentValue, previousValue, delegate, wheelCenter, cloveNames, numberOfSections, images;

              
- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber {
    
    if ((self = [super initWithFrame:frame])) {
		
        self.numberOfSections = sectionsNumber;
        self.delegate = del;
	}
    return self;
}


- (void) initWheel {
        
    container = [[UIView alloc] initWithFrame:self.frame];
    
    cloves = [NSMutableArray arrayWithCapacity:numberOfSections];
    images = [NSMutableArray arrayWithCapacity:numberOfSections];
    
    // Calculate angle between each clove
    CGFloat angleSize = 2*M_PI/numberOfSections;
    
    for (int i = 0; i < numberOfSections; i++) {
        
        UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(95, 0, 130, 160)];
        im.image = sectorImage;
        im.layer.anchorPoint = CGPointMake(0.5f, 1.0f);
        //im.layer.position = CGPointMake(160,160); 
        im.layer.position = CGPointMake(container.bounds.size.width/2.0-container.frame.origin.x, container.bounds.size.height/2.0-container.frame.origin.y);
        im.transform = CGAffineTransformMakeRotation(angleSize*(i));
        im.tag = i;
        
        if (i == 0) {
            im.image = selectSectorImage;
        }
        
        UIImageView *cloveImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 130, 70)];
        cloveImage.image = [UIImage imageNamed:[iconsFile objectAtIndex:i]];
        [im addSubview:cloveImage];
        
        [container addSubview:im];
        [images addObject:im];
    }
    
    container.userInteractionEnabled = NO;
    [self addSubview:container];
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.frame];
    bg.image = bgImage;
    [self addSubview:bg];
    
    UIImageView *mask = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    mask.image = centerImage;
    mask.center = self.center;
    [self addSubview:mask];
    
    if (numberOfSections % 2 == 0) {
        [self buildClovesEven];
    } else {
        [self buildClovesOdd];
    }
    [self.delegate rotateDidChangeValue:[NSNumber numberWithInt:0]];
}

- (void) setImageFiles:(NSArray*)icons background:(NSString*)bg center:(NSString*)cen sector:(NSString*)sec1 sectorSel:(NSString*)sec2 {
    
    iconsFile = [NSArray arrayWithArray:icons];
    bgImage = [UIImage imageNamed:bg];
    centerImage = [UIImage imageNamed:cen];
    sectorImage = [UIImage imageNamed:sec1];
    selectSectorImage = [UIImage imageNamed:sec2];
    
    [self initWheel];
}


- (void) buildClovesEven {
    
    CGFloat fanWidth = M_PI*2/numberOfSections;
    CGFloat mid = 0;
    
    for (int i = 0; i < numberOfSections; i++) {
        
        SMClove *clove = [[SMClove alloc] init];
        clove.midValue = mid;
        clove.minValue = mid - (fanWidth/2);
        clove.maxValue = mid + (fanWidth/2);
        clove.value = i;
        
        if (clove.maxValue-fanWidth < - M_PI) {
            
            mid = 3.14;
            clove.midValue = mid;
            clove.minValue = fabsf(clove.maxValue);
            
        }
        mid -= fanWidth;
        [cloves addObject:clove];
    }
}


- (float) calculateDistanceFromCenter:(CGPoint)point {

    CGPoint center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
	float dx = point.x - center.x;
	float dy = point.y - center.y;
	return sqrt(dx*dx + dy*dy);
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    CGPoint delta = [touch locationInView:self];
    float dist = [self calculateDistanceFromCenter:delta];
    
    if (dist < 70 || dist > 150) 
    {
        touchDo = NO;
        return;
    } else {
        touchDo = YES;
    }
    
    startTransform = container.transform;
    
    CGFloat radians = atan2f(startTransform.b, startTransform.a);
    NSLog(@"start transform: %f", RADIANS_TO_DEGREES(radians));
    
    UIImageView *iv = [images objectAtIndex:currentValue];
    iv.image = sectorImage;
    
	float dx = delta.x  - container.center.x;
	float dy = delta.y  - container.center.y;
	deltaAngle = atan2(dy,dx);
    
    touchNum = 1;
    NSLog(@"touch began, num %d",touchNum);
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touchDo == NO) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    
	float dx = pt.x  - container.center.x;
	float dy = pt.y  - container.center.y;
	float ang = atan2(dy,dx);
    
    float angleDif = deltaAngle - ang;
    
    CGAffineTransform newTrans = CGAffineTransformRotate(startTransform, -angleDif);
    container.transform = newTrans;
    
    if (touchNum==1) {
        touchNum++;
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    NSLog(@"touch ended");
    
    if (touchDo == NO) {
        return;
    }
    if (touchNum==1) {
        NSLog(@"single touch");
        UITouch *touch = [touches anyObject];
        CGPoint pt = [touch locationInView:self];
        
        float dx = pt.x  - container.center.x;
        float dy = pt.y  - container.center.y;
        float ang = atan2(dy,dx);
        
        // do something to deltaangle
        deltaAngle = -1.52;
        
        float angleDif = deltaAngle - ang;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        CGAffineTransform newTrans = CGAffineTransformRotate(startTransform, angleDif);
        container.transform = newTrans;
        
        [UIView commitAnimations];
        
        CGFloat radians = atan2f(container.transform.b, container.transform.a);
        CGFloat newVal = 0.0;
        
        for (SMClove *c in cloves) {
            if (c.minValue > 0 && c.maxValue < 0) {
                if (c.maxValue > radians || c.minValue < radians) {
                    if (radians > 0) {
                        newVal = radians - M_PI;
                    } else {
                        newVal = M_PI + radians;                    
                    }
                    currentValue = c.value;
                }
            }
            if (radians > c.minValue && radians < c.maxValue) {
                newVal = radians - c.midValue;
                currentValue = c.value;
            }
        }
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        
        CGAffineTransform t = CGAffineTransformRotate(container.transform, -newVal);
        container.transform = t;
        
        [UIView commitAnimations];
        
        UIImageView *iv = [images objectAtIndex:currentValue];
        iv.image = selectSectorImage;
        
        [self.delegate rotateDidChangeValue:[NSNumber numberWithInt:currentValue]];
        previousValue = currentValue;

        return;
    }
    
    CGFloat radians = atan2f(container.transform.b, container.transform.a);
    CGFloat newVal = 0.0;
    
    for (SMClove *c in cloves) {
        if (c.minValue > 0 && c.maxValue < 0) {
            if (c.maxValue > radians || c.minValue < radians) {
                if (radians > 0) {
                    newVal = radians - M_PI;
                } else {
                    newVal = M_PI + radians;                    
                }
                currentValue = c.value;
            }
        }
        if (radians > c.minValue && radians < c.maxValue) {
            newVal = radians - c.midValue;
            currentValue = c.value;
        }
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    
    CGAffineTransform t = CGAffineTransformRotate(container.transform, -newVal);
    container.transform = t;
    
    [UIView commitAnimations];
    
    UIImageView *iv = [images objectAtIndex:currentValue];
    iv.image = selectSectorImage;
    
    [self.delegate rotateDidChangeValue:[NSNumber numberWithInt:currentValue]];
    previousValue = currentValue;
}

- (void) buildClovesOdd {
    
    CGFloat fanWidth = M_PI*2/numberOfSections;
    CGFloat mid = 0;
    
    for (int i = 0; i < numberOfSections; i++) {
        
        SMClove *clove = [[SMClove alloc] init];
        clove.midValue = mid;
        clove.minValue = mid - (fanWidth/2);
        clove.maxValue = mid + (fanWidth/2);
        clove.value = i;
        
        mid -= fanWidth;
        
        if (clove.minValue < - M_PI) { // odd sections
            
            mid = -mid;
            mid -= fanWidth; 
            
        }
        [cloves addObject:clove];
    }
}

@end
