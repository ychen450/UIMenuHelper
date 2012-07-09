//
//  RotateMenu.m
//  UIMenuHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import "RotateMenu.h"
#import <QuartzCore/QuartzCore.h>

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

static float deltaAngle;


@implementation RotateMenu

@synthesize startTransform, container, currentValue, previousValue, delegate, wheelCenter, cloveNames, numberOfSections, images, rotateEnable, iconFaceDown, moveEnable, rotateAutoClose;


- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber iconFaceDown:(BOOL)ifd{
    
    if ((self = [super initWithFrame:frame])) {
		
        self.numberOfSections = sectionsNumber;
        self.delegate = del;
        self.iconFaceDown = ifd;
	}
    return self;
}


- (void) initWheel {
    
    //self.center = CGPointMake(160, 256);
    rotateEnable = YES;
    moveEnable = YES;
    rotateAutoClose = NO;
    container = [[UIView alloc] initWithFrame:self.frame];
    
    images = [NSMutableArray arrayWithCapacity:numberOfSections];
    cloveArray = [[NSMutableArray alloc] initWithCapacity:numberOfSections];
    icons = [NSMutableArray arrayWithCapacity:numberOfSections];
    iconTransform = [NSMutableArray arrayWithCapacity:numberOfSections];
    
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
        
        UIImageView *cloveImage = [[UIImageView alloc] initWithFrame:CGRectMake(22.5, 12, 85, 85)];
        cloveImage.tag = i;
        cloveImage.image = [UIImage imageNamed:[iconsFile objectAtIndex:i]];
        if (iconFaceDown) {
            cloveImage.transform = CGAffineTransformMakeRotation(-angleSize*(i));
        }
        [im addSubview:cloveImage];
        [icons addObject:cloveImage];
        
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
    
    rotateup = NO;
    rotateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rotateBtn.frame = CGRectMake(0, 0, 320, 32);
    [rotateBtn setBackgroundImage:downBtnImage forState:UIControlStateNormal];
    [rotateBtn addTarget:self action:@selector(ClickRotateBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rotateBtn];
    
    if (numberOfSections % 2 == 0) {
        [self buildClovesEven];
    } else {
        [self buildClovesOdd];
    }
    [self.delegate rotateDidChangeValue:[NSNumber numberWithInt:0]];
}

- (void) setImageFiles:(NSArray*)iconsImage downBtn:(NSString*)down upBtn:(NSString*)up background:(NSString*)bg center:(NSString*)cen sector:(NSString*)sec1 sectorSel:(NSString*)sec2 {
    
    iconsFile = [NSArray arrayWithArray:iconsImage];
    bgImage = [UIImage imageNamed:bg];
    centerImage = [UIImage imageNamed:cen];
    sectorImage = [UIImage imageNamed:sec1];
    selectSectorImage = [UIImage imageNamed:sec2];
    upBtnImage = [UIImage imageNamed:up];
    downBtnImage = [UIImage imageNamed:down];
    
    [self initWheel];
}

- (IBAction)ClickRotateBtn:(id)sender {
    
    UIButton *btn = (UIButton*)sender;
    if (rotateup == NO) {
        [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             self.frame = CGRectMake(0, 140, 320, 320);
                             btn.frame = CGRectMake(0, 0, 320, 32);
                         }
                         completion:nil];
        [btn setImage:upBtnImage forState:UIControlStateNormal];
        rotateup = YES;
    } else {
        [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             self.frame = CGRectMake(0, 428, 320, 320);
                             btn.frame = CGRectMake(0, 0, 320, 32);
                         }
                         completion:nil];
        //[self bringSubviewToFront:btn];
        [btn setImage:downBtnImage forState:UIControlStateNormal];
        rotateup = NO;
    }

}

- (void) buildClovesEven {
    
    CGFloat fanWidth = M_PI*2/numberOfSections;
    CGFloat mid = 0;
    
    for (int i = 0; i < numberOfSections; i++) {
    
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:4];
        [dic setObject:[NSNumber numberWithFloat:mid] forKey:@"midValue"];
        [dic setObject:[NSNumber numberWithFloat:(mid-fanWidth/2)] forKey:@"minValue"];
        [dic setObject:[NSNumber numberWithFloat:(mid+fanWidth/2)] forKey:@"maxValue"];
        [dic setObject:[NSNumber numberWithInt:i] forKey:@"value"];
        
        if (([[dic objectForKey:@"maxValue"] floatValue] -fanWidth) < -M_PI) {
            mid = 3.14;
            [dic setObject:[NSNumber numberWithFloat:mid] forKey:@"midValue"];
            [dic setObject:[NSNumber numberWithFloat:fabsf([[dic objectForKey:@"maxValue"] floatValue])] forKey:@"minValue"];
        }
        mid -= fanWidth;
        [cloveArray addObject:dic];
    }
}

- (void) buildClovesOdd {
    
    CGFloat fanWidth = M_PI*2/numberOfSections;
    CGFloat mid = 0;
    
    for (int i = 0; i < numberOfSections; i++) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:4];
        [dic setObject:[NSNumber numberWithFloat:mid] forKey:@"midValue"];
        [dic setObject:[NSNumber numberWithFloat:(mid-fanWidth/2)] forKey:@"minValue"];
        [dic setObject:[NSNumber numberWithFloat:(mid+fanWidth/2)] forKey:@"maxValue"];
        [dic setObject:[NSNumber numberWithInt:i] forKey:@"value"];
        
        mid -= fanWidth;
        
        if ([[dic objectForKey:@"minValue"] floatValue] < -M_PI) {
            mid = -mid;
            mid -= fanWidth;
        }
        [cloveArray addObject:dic];
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
    
    if (iconFaceDown) {
        [iconTransform removeAllObjects];
        for (UIImageView *iconiv in icons) {
            NSValue *v = [NSValue valueWithCGAffineTransform:iconiv.transform];
            [iconTransform addObject:v];
        }
    }
    
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
    
    if (rotateEnable) {
        UITouch *touch = [touches anyObject];
        CGPoint pt = [touch locationInView:self];
        
        float dx = pt.x  - container.center.x;
        float dy = pt.y  - container.center.y;
        float ang = atan2(dy,dx);
        
        float angleDif = deltaAngle - ang;
        
        CGAffineTransform newTrans = CGAffineTransformRotate(startTransform, -angleDif);
        container.transform = newTrans;
        
        if (iconFaceDown) {
            for (UIImageView *iconiv in icons) {
                CGAffineTransform at = [[iconTransform objectAtIndex:iconiv.tag] CGAffineTransformValue];
                iconiv.transform = CGAffineTransformRotate(at, angleDif);
            }
        }
    }
        
    if (touchNum==1) {
        touchNum++;
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
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
        
        deltaAngle = -1.52;
        
        float angleDif = deltaAngle - ang;
        
        CGAffineTransform newTrans = CGAffineTransformRotate(startTransform, angleDif);
        
        CGFloat radians = atan2f(newTrans.b, newTrans.a);
        CGFloat newVal = 0.0;
        
        
        for (int i=0; i<[cloveArray count]; i++) {
            
            NSMutableDictionary *dic = [cloveArray objectAtIndex:i];
            float max = [[dic objectForKey:@"maxValue"] floatValue];
            float min = [[dic objectForKey:@"minValue"] floatValue];
            
            if (min > 0 && max < 0) {
                if (max > radians || min < radians) {
                    if (radians > 0) {
                        newVal = radians - M_PI;
                    } else {
                        newVal = M_PI + radians;
                    }
                    currentValue = [[dic objectForKey:@"value"] intValue];
                }
            }
            if (radians > min && radians < max) {
                newVal = radians - [[dic objectForKey:@"midValue"] floatValue];
                currentValue = [[dic objectForKey:@"value"] intValue];
            }
        }
        
        if (moveEnable) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.6];
            
            CGAffineTransform t = CGAffineTransformRotate(startTransform, angleDif-newVal);
            container.transform = t;
            
            if (iconFaceDown) {
                for (UIImageView *iconiv in icons) {
                    CGAffineTransform at = [[iconTransform objectAtIndex:iconiv.tag] CGAffineTransformValue];
                    iconiv.transform = CGAffineTransformRotate(at, newVal-angleDif);
                }
            }
            [UIView commitAnimations];
        }
        UIImageView *iv = [images objectAtIndex:currentValue];
        iv.image = selectSectorImage;
        
        [self.delegate rotateDidChangeValue:[NSNumber numberWithInt:currentValue]];
        previousValue = currentValue;
        
        if (rotateAutoClose && rotateup==YES) {
            [UIView animateWithDuration:0.6 delay:0.1 options:UIViewAnimationCurveEaseInOut
                             animations:^{
                                 self.frame = CGRectMake(0, 428, 320, 320);
                                 rotateBtn.frame = CGRectMake(0, 0, 320, 32);
                             }
                             completion:nil];
            //[self bringSubviewToFront:btn];
            [rotateBtn setImage:downBtnImage forState:UIControlStateNormal];
            rotateup = NO;
        }
        return;
    }
    if (rotateEnable) {
        CGFloat radians = atan2f(container.transform.b, container.transform.a);
        CGFloat newVal = 0.0;
        
        for (NSMutableDictionary *dic in cloveArray) {
            float max = [[dic objectForKey:@"maxValue"] floatValue];
            float min = [[dic objectForKey:@"minValue"] floatValue];
            
            if (min > 0 && max < 0) {
                if (max > radians || min < radians) {
                    if (radians > 0) {
                        newVal = radians - M_PI;
                    } else {
                        newVal = M_PI + radians;
                    }
                    currentValue = [[dic objectForKey:@"value"] intValue];
                }
            }
            if (radians > min && radians < max) {
                newVal = radians - [[dic objectForKey:@"midValue"] floatValue];
                currentValue = [[dic objectForKey:@"value"] intValue];
            }
        }
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        
        CGAffineTransform t = CGAffineTransformRotate(container.transform, -newVal);
        container.transform = t;
        
        if (iconFaceDown) {
            for (UIImageView *iconiv in icons) {
                iconiv.transform = CGAffineTransformRotate(iconiv.transform, newVal);
            }
        }
        [UIView commitAnimations];
        
        UIImageView *iv = [images objectAtIndex:currentValue];
        iv.image = selectSectorImage;
        
        [self.delegate rotateDidChangeValue:[NSNumber numberWithInt:currentValue]];
        previousValue = currentValue;
    } else {
        UIImageView *iv = [images objectAtIndex:currentValue];
        iv.image = selectSectorImage;
    }
    
    if (rotateAutoClose && rotateup==YES) {
        [UIView animateWithDuration:0.6 delay:0.1 options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             self.frame = CGRectMake(0, 428, 320, 320);
                             rotateBtn.frame = CGRectMake(0, 0, 320, 32);
                         }
                         completion:nil];
        //[self bringSubviewToFront:btn];
        [rotateBtn setImage:downBtnImage forState:UIControlStateNormal];
        rotateup = NO;
    }
}




@end

