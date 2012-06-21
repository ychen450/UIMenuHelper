//
//  SMRotaryWheel.m
//  RotaryWheelProject
//
//  Created by cesarerocchi on 2/10/12.
//  Copyright (c) 2012 studiomagnolia.com. All rights reserved.

#import <UIKit/UIKit.h>
#import "SMRotaryProtocol.h"
#import "SMClove.h"

@interface SMRotaryWheel : UIView {
    BOOL touchDo;
    int touchNum;
    
    UIImage *bgImage;
    UIImage *centerImage;
    NSArray *iconsFile;
    UIImage *sectorImage;
    UIImage *selectSectorImage;
}

@property (weak) id <SMRotaryProtocol> delegate;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) NSMutableArray *cloves;
@property (nonatomic, strong) NSMutableArray *images;
@property CGAffineTransform startTransform;
@property int currentValue;
@property int previousValue;
@property int numberOfSections;
@property CGPoint wheelCenter;
@property (nonatomic, strong) NSMutableDictionary *cloveNames;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber;
- (void) initWheel;
- (void) buildClovesEven;
- (void) buildClovesOdd;
- (float) calculateDistanceFromCenter:(CGPoint)point;
- (void) setImageFiles:(NSArray*)icons background:(NSString*)bg center:(NSString*)cen sector:(NSString*)sec1 sectorSel:(NSString*)sec2;

@end
