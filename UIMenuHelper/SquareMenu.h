//
//  SquareMenu.h
//  UIMenuHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import <UIKit/UIKit.h>

@protocol SquareMenuProtocol;

@interface SquareMenu : UIView {
    
    NSMutableArray *btnArray;
    NSMutableArray *imageArray;
    
    UIImage *bgImage;
    NSArray *iconsFile;
    UIImage *sectorImage;
    UIImage *selectSectorImage;
}

@property (weak) id <SquareMenuProtocol> delegate;
@property (nonatomic, strong) UIView *container;
@property int numberOfSections;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber;
- (void) initSquare;
- (void) setImageFiles:(NSArray*)icons background:(NSString*)bg;
- (IBAction)selectSquare:(id)sender;

- (void) slideup:(float)time;
- (void) closedown;

- (void) addNotifAt:(int)btnnum Number:(int)notnum;
- (void) setEnable:(BOOL)enabled btnNumber:(int)btnnum;
- (void) addSpecialView:(UIView*)view btnNumber:(int)btnnum;

@end


@protocol SquareMenuProtocol <NSObject>

- (void) squareDidChangeValue:(int)btntag;

@end
