//
//  RotateDemoViewController.m
//  UIMenuHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import "RotateDemoViewController.h"

@implementation RotateDemoViewController

@synthesize pullRotateBtn;
@synthesize wheel;

@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize delegate = _delegate;
@synthesize selectedViewController = _selectedViewController;
@synthesize rotateMode = _rotateMode;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
	contentContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 384)];
	[self.view addSubview:contentContainerView];
    
    UIViewController *toViewController;
    toViewController = [_viewControllers objectAtIndex:0];
    toViewController.view.frame = contentContainerView.bounds;
    [contentContainerView addSubview:toViewController.view];
    
    if (_rotateMode==0) {
        wheel = [[RotateMenu alloc] initWithFrame:CGRectMake(0, 0 , 320, 320) 
                                      andDelegate:self 
                                     withSections:7
                                     iconFaceDown:YES];
        NSArray *icons = [NSArray arrayWithObjects:@"myicon0.png", @"myicon1.png", @"myicon2.png", @"myicon3.png", @"myicon4.png", @"myicon5.png", @"myicon6.png", nil];
        [wheel setImageFiles:icons  downBtn:@"myrotbtn1.png" upBtn:@"myrotbtn2.png" background:@"myrotbg.png" center:@"myrotcenter.png" sector:@"myrotsec.png" sectorSel:@"myrotsec2.png"];
        wheel.rotateEnable = NO;
        wheel.moveEnable = NO;
        wheel.rotateAutoClose = YES;
        wheel.center = CGPointMake(160, 256);
        wheel.frame = CGRectMake(0, 428, 320, 320);
        [self.view addSubview:wheel];
        
    } else if (_rotateMode==1) {
        wheel = [[RotateMenu alloc] initWithFrame:CGRectMake(0, 0 , 320, 320) 
                                      andDelegate:self 
                                     withSections:7
                                     iconFaceDown:YES];
        NSArray *icons = [NSArray arrayWithObjects:@"myicon0.png", @"myicon1.png", @"myicon2.png", @"myicon3.png", @"myicon4.png", @"myicon5.png", @"myicon6.png", nil];
        [wheel setImageFiles:icons  downBtn:@"myrotbtn1.png" upBtn:@"myrotbtn2.png" background:@"myrotbg.png" center:@"myrotcenter.png" sector:@"myrotsec.png" sectorSel:@"myrotsec2.png"];
        wheel.rotateEnable = NO;
        wheel.center = CGPointMake(160, 256);
        wheel.frame = CGRectMake(0, 428, 320, 320);
        [self.view addSubview:wheel];
        
    } else if (_rotateMode==2) {
        wheel = [[RotateMenu alloc] initWithFrame:CGRectMake(0, 0, 320, 320) 
                                      andDelegate:self 
                                     withSections:7
                                     iconFaceDown:NO];
        NSArray *icons = [NSArray arrayWithObjects:@"myicon0.png", @"myicon1.png", @"myicon2.png", @"myicon3.png", @"myicon4.png", @"myicon5.png", @"myicon6.png", nil];
        [wheel setImageFiles:icons  downBtn:@"myrotbtn1.png" upBtn:@"myrotbtn2.png" background:@"myrotbg.png" center:@"myrotcenter.png" sector:@"myrotsec.png" sectorSel:@"myrotsec2.png"];
        wheel.rotateEnable = YES;
        wheel.center = CGPointMake(160, 256);
        wheel.frame = CGRectMake(0, 428, 320, 320);
        [self.view addSubview:wheel];
    }
    
}


- (void)viewDidUnload {
    [self setPullRotateBtn:nil];
    [super viewDidUnload];
}


- (IBAction)backToMenu:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void) rotateDidChangeValue:(NSNumber *)newValue {
    
    [self setSelectedIndex:[newValue integerValue] animated:YES];
    NSLog(@"did changeValue");
}


- (void)setViewControllers:(NSArray *)newViewControllers
{
    NSLog(@"set view controllers");
    
	NSAssert([newViewControllers count] >= 2, @"RotateController requires at least two view controllers");
    
	UIViewController *oldSelectedViewController = self.selectedViewController;
    
	// Remove the old child view controllers.
	for (UIViewController *viewController in _viewControllers)
	{
		[viewController willMoveToParentViewController:nil];
		[viewController removeFromParentViewController];
	}
    
	_viewControllers = [newViewControllers copy];
    
	// This follows the same rules as UITabBarController for trying to
	// re-select the previously selected view controller.
	NSUInteger newIndex = [_viewControllers indexOfObject:oldSelectedViewController];
	if (newIndex != NSNotFound)
		_selectedIndex = newIndex;
	else if (newIndex < [_viewControllers count])
		_selectedIndex = newIndex;
	else
		_selectedIndex = 0;
    
	// Add the new child view controllers.
	for (UIViewController *viewController in _viewControllers)
	{
		[self addChildViewController:viewController];
		[viewController didMoveToParentViewController:self];
        
        NSLog(@"add child view controller  %@",viewController);
	}
    
    UIViewController *toViewController;
    toViewController = [_viewControllers objectAtIndex:0];
    toViewController.view.frame = contentContainerView.bounds;
    [contentContainerView addSubview:toViewController.view];
    
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex
{
	[self setSelectedIndex:newSelectedIndex animated:YES];
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex animated:(BOOL)animated
{
	NSAssert(newSelectedIndex < [self.viewControllers count], @"View controller index out of bounds");
    
	if (![self isViewLoaded])
	{
        NSLog(@"not view loaded");
		_selectedIndex = newSelectedIndex;
	}
	else if (_selectedIndex != newSelectedIndex)
	{
		UIViewController *fromViewController;
		UIViewController *toViewController;
		
        fromViewController = self.selectedViewController;
        
		NSUInteger oldSelectedIndex = _selectedIndex;
		_selectedIndex = newSelectedIndex;
        
		if (_selectedIndex != NSNotFound)
		{
			toViewController = self.selectedViewController;
		}
            
        toViewController.view.frame = contentContainerView.bounds;
        [contentContainerView addSubview:toViewController.view];
		
		if (animated)
		{
			CGRect rect = contentContainerView.bounds;
			if (oldSelectedIndex < newSelectedIndex)
				rect.origin.x = rect.size.width;
			else
				rect.origin.x = -rect.size.width;
            
			toViewController.view.frame = rect;
            
			[self transitionFromViewController:fromViewController
                              toViewController:toViewController
                                      duration:0.3
                                       options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut
                                    animations:^
             {
                 CGRect rect = fromViewController.view.frame;
                 if (oldSelectedIndex < newSelectedIndex)
                     rect.origin.x = -rect.size.width;
                 else
                     rect.origin.x = rect.size.width;
                 
                 fromViewController.view.frame = rect;
                 toViewController.view.frame = contentContainerView.bounds;
             }
                                    completion:nil];
		}
	}
}

- (UIViewController *)selectedViewController
{
	if (self.selectedIndex != NSNotFound)
		return [self.viewControllers objectAtIndex:self.selectedIndex];
	else
		return nil;
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController
{
	[self setSelectedViewController:newSelectedViewController animated:YES];
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController animated:(BOOL)animated;
{
	NSUInteger index = [self.viewControllers indexOfObject:newSelectedViewController];
	if (index != NSNotFound)
		[self setSelectedIndex:index animated:animated];
}







@end
