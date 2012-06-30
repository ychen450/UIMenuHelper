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
    
    BOOL rotateup;
    BOOL touchDo;
    int touchNum;
    
    UIImage *bgImage;
    UIImage *centerImage;
    NSArray *iconsFile;
    UIImage *sectorImage;
    UIImage *selectSectorImage;
    UIImage *upBtnImage;
    UIImage *downBtnImage;
    
    NSMutableArray *cloveArray;
    NSMutableArray *icons;
    NSMutableArray *iconTransform;
}

@property (weak) id <RotateMenuDelegate> delegate;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) NSMutableArray *images;
@property CGAffineTransform startTransform;
@property int currentValue;
@property int previousValue;
@property int numberOfSections;
@property BOOL moveEnable;
@property BOOL rotateEnable;
@property BOOL iconFaceDown;
@property CGPoint wheelCenter;
@property (nonatomic, strong) NSMutableDictionary *cloveNames;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber iconFaceDown:(BOOL)ifd;
- (void) initWheel;
- (void) buildClovesEven;
- (void) buildClovesOdd;
- (float) calculateDistanceFromCenter:(CGPoint)point;
- (void) setImageFiles:(NSArray*)icons downBtn:(NSString*)down upBtn:(NSString*)up background:(NSString*)bg center:(NSString*)cen sector:(NSString*)sec1 sectorSel:(NSString*)sec2;

- (IBAction)ClickRotateBtn:(id)sender;

@end



@protocol RotateMenuDelegate <NSObject>

- (void) rotateDidChangeValue:(NSNumber *)newValue;

@end
