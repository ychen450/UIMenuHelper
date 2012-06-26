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
}

@property (weak) id <SquareMenuProtocol> delegate;
@property (nonatomic, strong) UIView *container;
@property int numberOfSections;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber;
- (void) initSquare;
- (IBAction)selectSquare:(id)sender;

- (void) slideup;
- (void) closedown;

- (void) addNotifAt:(int)btnnum Number:(int)notnum;

@end


@protocol SquareMenuProtocol <NSObject>

- (void) squareDidChangeValue:(int)btntag;

@end
