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

@protocol RotateControllerDelegate;

@interface RotateDemoViewController : UIViewController<RotateMenuDelegate> {
    BOOL rotateup;
    UIView *contentContainerView;
}

@property (strong, nonatomic) IBOutlet UIButton *pullRotateBtn;
@property (nonatomic, strong) RotateMenu *wheel;

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, weak) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, weak) id <RotateControllerDelegate> delegate;
@property (nonatomic, assign) NSInteger rotateMode;

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setSelectedViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (IBAction)backToMenu:(id)sender; 

@end


@protocol RotateControllerDelegate <NSObject>

@optional
- (BOOL) rotateController:(RotateDemoViewController*)rotateController shouldSelectViewController:(UIViewController*)viewController atIndex:(NSUInteger)index;
- (void) rotateController:(RotateDemoViewController*)rotateController didSelectViewController:(UIViewController*)viewController atIndex:(NSUInteger)index;

@end

