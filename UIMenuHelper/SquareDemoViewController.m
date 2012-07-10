//
//  SquareDemoViewController.m
//  UIMenuHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import "SquareDemoViewController.h"

#import "Page1ViewController.h"
#import "Page2ViewController.h"
#import "Page3ViewController.h"
#import "Page4ViewController.h"
#import "Page5ViewController.h"

#import "PieChart.h"

@implementation SquareDemoViewController

@synthesize square;

@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize selectedViewController = _selectedViewController;

- (IBAction)swipeUpDetected:(UISwipeGestureRecognizer *)sender {
    if (squareup == NO) {
        [self.view addSubview:square];
        [square slideup:0.6];
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
    
    // set up square menu
    if (square == nil) {
        square = [[SquareMenu alloc] initWithFrame:CGRectMake(0, 0, 320, 200) andDelegate:self withSections:6];
        // set images
        NSArray *icons = [NSArray arrayWithObjects:@"myicon0.png", @"", @"myicon1.png", @"myicon2.png", @"myicon3.png", @"myicon4.png", nil];
        [square setImageFiles:icons background:@"mysqabg.png"];
        // set button enable
        [square setEnable:NO btnNumber:1];
    }
    // set enable square menu closing or not
    squareStatic = YES;
    // add notification showing 4 at button 3
    [square addNotifAt:3 Number:4];
    
    // add special view to btn 1
    PieChart *piechart = [[PieChart alloc] initWithFrame:CGRectMake(0, 0, square.frame.size.width/3, square.frame.size.height/2) 
                                                   value:0.6 
                                                setColor:203./255. green1:51./255. blue1:51./255. red2:250./255. green2:153./255. blue2:51./255. 
                                                setImage:@"circle.png" patternImage:@"pattern.png" 
                                                 setText:@"220" text2:@"POINTS" font:@"Helvetica"];
    [square addSpecialView:piechart btnNumber:1];
    
    contentContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
	[self.view addSubview:contentContainerView];
    
    // set the child view controller to _viewController array
    Page1ViewController *page1ViewController = [[Page1ViewController alloc] initWithNibName:@"Page1ViewController" bundle:nil];
    Page3ViewController *page3ViewController = [[Page3ViewController alloc] initWithNibName:@"Page3ViewController" bundle:nil];
    Page4ViewController *page4ViewController = [[Page4ViewController alloc] initWithNibName:@"Page4ViewController" bundle:nil];
    _viewControllers = [NSArray arrayWithObjects:page1ViewController, page3ViewController, page4ViewController, nil];
	for (UIViewController *viewController in _viewControllers) {
		[self addChildViewController:viewController];
		[viewController didMoveToParentViewController:self];
	}
    [self squareDidChangeValue:0];
    _selectedIndex = 0;
    
    // swipe gesture to control square menu
    if (!squareStatic) {
        UISwipeGestureRecognizer *swipeUpRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUpDetected:)];
        swipeUpRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
        [self.view addGestureRecognizer:swipeUpRecognizer];
        UISwipeGestureRecognizer *swipeDownRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownDetected:)];
        swipeDownRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
        [self.view addGestureRecognizer:swipeDownRecognizer];
        squareup = NO;
    } else {
        [self.view addSubview:square];
        [square slideup:0.0];
    }
}

- (void) squareDidChangeValue:(int)btntag {
    
    switch (btntag) {
        case 0: { 
            UIViewController *toViewController;
            toViewController = [_viewControllers objectAtIndex:0];
            toViewController.view.frame = contentContainerView.bounds;
            [contentContainerView addSubview:toViewController.view];
            _selectedViewController = toViewController;
            break;}
        // button 1 is not enabled
        case 2: { 
            // for presenting view controller explicitly, use presentModelViewController or pushViewController
            Page2ViewController *page2ViewController = [[Page2ViewController alloc] initWithNibName:@"Page2ViewController" bundle:nil];
            [self presentModalViewController:page2ViewController animated:YES];
            break;}
        case 3: { 
            // for changing the child view, set the index in the _viewControllers array
            [self setSelectedIndex:1 animated:YES];
            break;}
        case 4: { 
            [self setSelectedIndex:2 animated:YES];
            break;}
        case 5: { 
            Page5ViewController *page5ViewController = [[Page5ViewController alloc] initWithNibName:@"Page5ViewController" bundle:nil];
            [self presentModalViewController:page5ViewController animated:YES];
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
