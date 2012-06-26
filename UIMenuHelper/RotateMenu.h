//
//  RotateMenu.h
//  UIMenuHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import <UIKit/UIKit.h>

@protocol RotateMenuDelegate;

@interface RotateMenu : UIView {
    
    BOOL touchDo;
    int touchNum;
    
    UIImage *bgImage;
    UIImage *centerImage;
    NSArray *iconsFile;
    UIImage *sectorImage;
    UIImage *selectSectorImage;
    
    NSMutableArray *cloveArray;
}

@property (weak) id <RotateMenuDelegate> delegate;
@property (nonatomic, strong) UIView *container;
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



@protocol RotateMenuDelegate <NSObject>

- (void) rotateDidChangeValue:(NSNumber *)newValue;

@end