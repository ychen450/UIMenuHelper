//
//  RotateDemoViewController.m
//  UIMenuHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import "RotateDemoViewController.h"
#import "Page1ViewController.h"
#import "Page2ViewController.h"
#import "Page3ViewController.h"
#import "Page4ViewController.h"
#import "Page5ViewController.h"
#import "Page6ViewController.h"
#import "Page7ViewController.h"

@implementation RotateDemoViewController

@synthesize wheel;

@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize selectedViewController = _selectedViewController;
@synthesize rotateMode = _rotateMode;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    int initViewIndex = 2;
    int initViewIndexChild = 1;
    
    contentContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 384)];
	[self.view addSubview:contentContainerView];
    
    if (_rotateMode==0) {
        wheel = [[RotateMenu alloc] initWithFrame:CGRectMake(0, 0 , 320, 320) 
                                      andDelegate:self 
                                     withSections:7
                                     iconFaceDown:YES];
        wheel.initViewController = initViewIndex;
        NSArray *icons = [NSArray arrayWithObjects:@"myicon0.png", @"myicon1.png", @"myicon2.png", @"myicon3.png", @"myicon4.png", @"myicon5.png", @"myicon6.png", nil];
        NSArray *onicons = [NSArray arrayWithObjects:@"circle.png", @"circle.png", @"circle.png", @"circle.png", @"circle.png", @"circle.png", @"circle.png", nil];
        [wheel setImageFiles:icons onIcons:onicons downBtn:@"myrotbtn1.png" upBtn:@"myrotbtn2.png" background:@"myrotbg.png" center:@"myrotcenter.png" sector:@"myrotsec.png" sectorSel:@"myrotsec2.png"];
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
        wheel.initViewController = initViewIndex;
        NSArray *icons = [NSArray arrayWithObjects:@"myicon0.png", @"myicon1.png", @"myicon2.png", @"myicon3.png", @"myicon4.png", @"myicon5.png", @"myicon6.png", nil];
        NSArray *onicons = [NSArray arrayWithObjects:@"circle.png", @"circle.png", @"circle.png", @"circle.png", @"circle.png", @"circle.png", @"circle.png", nil];
        [wheel setImageFiles:icons onIcons:onicons downBtn:@"myrotbtn1.png" upBtn:@"myrotbtn2.png" background:@"myrotbg.png" center:@"myrotcenter.png" sector:@"myrotsec.png" sectorSel:@"myrotsec2.png"];
        wheel.rotateEnable = NO;
        wheel.center = CGPointMake(160, 256);
        wheel.frame = CGRectMake(0, 428, 320, 320);
        [self.view addSubview:wheel];
        
    } else if (_rotateMode==2) {
        wheel = [[RotateMenu alloc] initWithFrame:CGRectMake(0, 0, 320, 320) 
                                      andDelegate:self 
                                     withSections:7
                                     iconFaceDown:NO];
        wheel.initViewController = initViewIndex;
        NSArray *icons = [NSArray arrayWithObjects:@"myicon0.png", @"myicon1.png", @"myicon2.png", @"myicon3.png", @"myicon4.png", @"myicon5.png", @"myicon6.png", nil];
        NSArray *onicons = [NSArray arrayWithObjects:@"circle.png", @"circle.png", @"circle.png", @"circle.png", @"circle.png", @"circle.png", @"circle.png", nil];
        [wheel setImageFiles:icons onIcons:onicons downBtn:@"myrotbtn1.png" upBtn:@"myrotbtn2.png" background:@"myrotbg.png" center:@"myrotcenter.png" sector:@"myrotsec.png" sectorSel:@"myrotsec2.png"];
        wheel.rotateEnable = YES;
        wheel.center = CGPointMake(160, 256);
        wheel.frame = CGRectMake(0, 428, 320, 320);
        [self.view addSubview:wheel];
    }
    
    // set the child view controller to _viewController array
    Page1ViewController *page1ViewController = [[Page1ViewController alloc] initWithNibName:@"Page1ViewController" bundle:nil];
    Page3ViewController *page3ViewController = [[Page3ViewController alloc] initWithNibName:@"Page3ViewController" bundle:nil];
    Page4ViewController *page4ViewController = [[Page4ViewController alloc] initWithNibName:@"Page4ViewController" bundle:nil];
    Page6ViewController *page6ViewController = [[Page6ViewController alloc] initWithNibName:@"Page6ViewController" bundle:nil];
    Page7ViewController *page7ViewController = [[Page7ViewController alloc] initWithNibName:@"Page7ViewController" bundle:nil];
    _viewControllers = [NSArray arrayWithObjects:page1ViewController, page3ViewController, page4ViewController, page6ViewController, page7ViewController, nil];
	for (UIViewController *viewController in _viewControllers) {
		[self addChildViewController:viewController];
		[viewController didMoveToParentViewController:self];
	}
    
    UIViewController *toViewController = [_viewControllers objectAtIndex:initViewIndexChild];
    toViewController.view.frame = contentContainerView.bounds;
    [contentContainerView addSubview:toViewController.view];
    _selectedViewController = toViewController;
    _selectedIndex = initViewIndexChild;
}


- (void)viewDidUnload {
    [super viewDidUnload];
}


- (IBAction)backToMenu:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void) rotateDidChangeValue:(NSNumber *)newValue {
    
    int btntag = [newValue intValue];
    switch (btntag) {
        case 0: { 
            [self setSelectedIndex:0 animated:YES];
            break;}
        case 1: { 
            // for presenting view controller explicitly, use presentModelViewController or pushViewController
            Page2ViewController *page2ViewController = [[Page2ViewController alloc] initWithNibName:@"Page2ViewController" bundle:nil];
            [self presentModalViewController:page2ViewController animated:YES];
            break;}
        case 2: { 
            // for changing the child view, set the index in the _viewControllers array
            [self setSelectedIndex:1 animated:YES];
            break;}
        case 3: {
            [self setSelectedIndex:2 animated:YES];
            break;}
        case 4: { 
            Page5ViewController *page5ViewController = [[Page5ViewController alloc] initWithNibName:@"Page5ViewController" bundle:nil];
            [self presentModalViewController:page5ViewController animated:YES];
            break;}
        case 5: { 
            [self setSelectedIndex:3 animated:YES];
            break;}
        case 6: { 
            [self setSelectedIndex:4 animated:YES];
            break;}
        default:
            break;
    }
}


- (void)setSelectedIndex:(NSUInteger)newSelectedIndex animated:(BOOL)animated
{
	NSAssert(newSelectedIndex < [self.viewControllers count], @"View controller index out of bounds");
    
	if (_selectedIndex != newSelectedIndex)
	{
		UIViewController *fromViewController;
		UIViewController *toViewController;
		
        fromViewController = self.selectedViewController;
        
		NSUInteger oldSelectedIndex = _selectedIndex;
		_selectedIndex = newSelectedIndex;
        
		if (_selectedIndex != NSNotFound)
		{
			toViewController = [_viewControllers objectAtIndex:_selectedIndex];
		}
        
        toViewController.view.frame = contentContainerView.bounds;
        [contentContainerView addSubview:toViewController.view];
        self.selectedViewController = toViewController;
		
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




@end
