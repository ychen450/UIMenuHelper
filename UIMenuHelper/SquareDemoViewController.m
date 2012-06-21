//
//  SquareDemoViewController.m
//  UIMenuHelper
//
//  Created by Yan-Ling, Chen on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SquareDemoViewController.h"

@implementation SquareDemoViewController

@synthesize square;

@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize selectedViewController = _selectedViewController;

- (IBAction)swipeUpDetected:(UISwipeGestureRecognizer *)sender {
    if (square == nil) {
        square = [[SquareMenu alloc] initWithFrame:CGRectMake(0, 0, 320, 200) andDelegate:self withSections:6];
        // set icon image (array)
        // set background image 
    }
    if (squareup == NO) {
        [self.view addSubview:square];
        [square slideup];
        
        [square addNotifAt:3 Number:4];
        [square addNotifAt:1 Number:2];
        squareup = YES;
    } else {
        [square closedown];
        squareup = NO;
    }
}

- (IBAction)swipeDownDetected:(UISwipeGestureRecognizer *)sender {
    if (squareup == YES) {
        [square closedown];
        squareup = NO;
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    squareup = NO;
    
    // swipe gesture to open square menu
    UISwipeGestureRecognizer *swipeUpRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUpDetected:)];
    swipeUpRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUpRecognizer];
    UISwipeGestureRecognizer *swipeDownRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownDetected:)];
    swipeDownRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDownRecognizer];
    
    
    contentContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
	[self.view addSubview:contentContainerView];
    
    UIViewController *toViewController;
    toViewController = [_viewControllers objectAtIndex:0];
    toViewController.view.frame = contentContainerView.bounds;
    [contentContainerView addSubview:toViewController.view];

}

- (void) squareDidChangeValue:(int)btntag {
   
    [self setSelectedIndex:btntag animated:YES];
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
    
    NSLog(@"set selected index");
    
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
            
            NSLog(@"select view animated");
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
