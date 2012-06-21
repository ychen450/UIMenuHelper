//
//  RotateDemoViewController.h
//  UIMenuHelper
//
//  Created by Yan-Ling, Chen on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMRotaryWheel.h"
#import "SMRotaryProtocol.h"

@protocol RotateControllerDelegate;

@interface RotateDemoViewController : UIViewController<SMRotaryProtocol> {
    BOOL rotateup;
    UIView *contentContainerView;
}

@property (strong, nonatomic) IBOutlet UIButton *pullRotateBtn;
@property (nonatomic, strong) SMRotaryWheel *wheel;

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, weak) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, weak) id <RotateControllerDelegate> delegate;

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setSelectedViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (IBAction)pullRotate:(id)sender;
- (IBAction)backToMenu:(id)sender; 

@end


@protocol RotateControllerDelegate <NSObject>

@optional
- (BOOL) rotateController:(RotateDemoViewController*)rotateController shouldSelectViewController:(UIViewController*)viewController atIndex:(NSUInteger)index;
- (void) rotateController:(RotateDemoViewController*)rotateController didSelectViewController:(UIViewController*)viewController atIndex:(NSUInteger)index;

@end

