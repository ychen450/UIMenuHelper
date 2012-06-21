//
//  SquareDemoViewController.h
//  UIMenuHelper
//
//  Created by Yan-Ling, Chen on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SquareMenu.h"
#import "SquareMenuProtocol.h"

@interface SquareDemoViewController : UIViewController<SquareMenuProtocol> {
    
    BOOL squareup;
    
    UIView *contentContainerView;
}

@property (nonatomic, strong) SquareMenu *square;

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, weak) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setSelectedViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
