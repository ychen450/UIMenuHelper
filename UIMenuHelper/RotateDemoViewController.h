//
//  RotateDemoViewController.h
//  UIMenuHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import <UIKit/UIKit.h>
#import "RotateMenu.h"

@interface RotateDemoViewController : UIViewController<RotateMenuDelegate> {
    BOOL rotateup;
    UIView *contentContainerView;
}

@property (nonatomic, strong) RotateMenu *wheel;

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, weak) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign) NSInteger rotateMode;

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;

- (IBAction)backToMenu:(id)sender; 

@end

