//
//  SquareMenu.h
//  UIMenuHelper
//
//  Created by Yan-Ling, Chen on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SquareMenuProtocol.h"

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
