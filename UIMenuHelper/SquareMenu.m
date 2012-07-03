//
//  SquareMenu.m
//  UIMenuHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import "SquareMenu.h"
#import <QuartzCore/QuartzCore.h>

@implementation SquareMenu

@synthesize delegate, container, numberOfSections;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber {
    
    if ((self = [super initWithFrame:frame])) {
		
        self.numberOfSections = sectionsNumber;
        self.delegate = del;
	}
    return self;
}


- (void) setImageFiles:(NSArray*)icons background:(NSString*)bg {
    
    bgImage = [UIImage imageNamed:bg];
    iconsFile = icons;
    
    [self initSquare];
}

- (void) initSquare {
    
    container = [[UIView alloc] initWithFrame:self.frame];
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:self.frame];
    im.image = bgImage;
    [self addSubview:im];
    
    NSMutableArray *tempbtnarray = [[NSMutableArray alloc] init];
    for (int i=0; i<numberOfSections; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i<numberOfSections/2) {
            btn.frame = CGRectMake(i*2*self.frame.size.width/numberOfSections, 0, self.frame.size.height/2, self.frame.size.height/2);
        } else {
            btn.frame = CGRectMake((i-numberOfSections/2)*2*self.frame.size.width/numberOfSections , self.frame.size.height/2 , self.frame.size.height/2, self.frame.size.height/2);
        }
        [btn setBackgroundImage:[UIImage imageNamed:[iconsFile objectAtIndex:i]] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(selectSquare:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:btn];
        [tempbtnarray addObject:btn];
    }
    btnArray = [NSArray arrayWithArray:tempbtnarray];
    
    [self.delegate squareDidChangeValue:0];
}

- (IBAction)selectSquare:(id)sender {
    
    UIButton *btn = (UIButton*)sender;
    NSLog(@"select: %d", btn.tag);
    [self.delegate squareDidChangeValue:btn.tag];
}

- (void) slideup:(float)time {
    NSLog(@"slideup ");
    [self addSubview:container];
    self.frame = CGRectMake(0, 480, self.frame.size.width , self.frame.size.height);
    [UIView animateWithDuration:time delay:0.0 options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         self.frame = CGRectMake(0, 416-self.frame.size.height, self.frame.size.width , self.frame.size.height);
                     }
                     completion:nil];
}

- (void) closedown {
    
    [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         self.frame = CGRectMake(0, 416, self.frame.size.width , self.frame.size.height);
                     }
                     completion:nil];
    //[self removeFromSuperview];
}

- (void) addNotifAt:(int)btnnum Number:(int)notnum {
    
    UIButton *btn = [btnArray objectAtIndex:btnnum];
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(btn.frame.size.width*2/3, btn.frame.size.height/5, 25, 25)];
    im.image = [UIImage imageNamed:@"myrotcenter.png"];
    
    UILabel *lbNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    lbNumber.backgroundColor = [UIColor clearColor];
    lbNumber.textColor = [UIColor whiteColor];
    lbNumber.textAlignment = UITextAlignmentCenter;
    lbNumber.font = [UIFont boldSystemFontOfSize:20];
    lbNumber.text = [NSString stringWithFormat:@"%d",notnum];
    [im addSubview:lbNumber];
    
    [btn addSubview:im];
}

- (void) setEnable:(BOOL)enabled btnNumber:(int)btnnum {
    UIButton *btn = [btnArray objectAtIndex:btnnum];
    btn.enabled = enabled;
}

- (void) addSpecialView:(UIView*)view btnNumber:(int)btnnum {
    UIButton *btn = [btnArray objectAtIndex:btnnum];
    [btn addSubview:view];
}





@end
