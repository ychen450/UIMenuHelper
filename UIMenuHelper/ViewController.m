//
//  ViewController.m
//  UIMenuHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import "ViewController.h"
#import "Page1ViewController.h"
#import "Page2ViewController.h"
#import "Page3ViewController.h"
#import "Page4ViewController.h"
#import "Page5ViewController.h"
#import "Page6ViewController.h"
#import "Page7ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

//- (IBAction)swipeUpDetected:(UISwipeGestureRecognizer *)sender {
//    if (rotateup == NO) {
//        if (square == nil) {
//            square = [[SquareMenu alloc] initWithFrame:CGRectMake(0, 0, 320, 200) andDelegate:self withSections:6];
//            // set icon image (array)
//            // set background image 
//        }
//        if (squareup == NO) {
//            [self.view addSubview:square];
//            [square slideup];
//            
//            [square addNotifAt:3 Number:4];
//            [square addNotifAt:1 Number:2];
//            
//            [btnPullSquare setTitle:@"close square" forState:UIControlStateNormal];
//            squareup = YES;
//        } else {
//            [square closedown];
//            
//            [btnPullSquare setTitle:@"square menu" forState:UIControlStateNormal];
//            squareup = NO;
//        }
//    }
//}
//
//- (IBAction)swipeDownDetected:(UISwipeGestureRecognizer *)sender {
//    if (squareup == YES) {
//        [square closedown];
//        
//        [btnPullSquare setTitle:@"square menu" forState:UIControlStateNormal];
//        squareup = NO;
//    }
//}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    squareup = NO;
//    rotateup = NO;
//    
//    // swipe gesture to open square menu
//    UISwipeGestureRecognizer *swipeUpRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUpDetected:)];
//    swipeUpRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
//    [self.view addGestureRecognizer:swipeUpRecognizer];
//    UISwipeGestureRecognizer *swipeDownRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownDetected:)];
//    swipeDownRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
//    [self.view addGestureRecognizer:swipeDownRecognizer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"GoRotate0"]) {
        
        RotateDemoViewController *rotateDemoViewController = [segue destinationViewController];
        rotateDemoViewController.rotateMode = 0;
    } else if ([[segue identifier] isEqualToString:@"GoRotate1"]) {
        
        RotateDemoViewController *rotateDemoViewController = [segue destinationViewController];
        rotateDemoViewController.rotateMode = 1;
    } else if ([[segue identifier] isEqualToString:@"GoRotate2"]) {
        
        RotateDemoViewController *rotateDemoViewController = [segue destinationViewController];
        rotateDemoViewController.rotateMode = 2;
    } else if ([[segue identifier] isEqualToString:@"GoSquare"]) {
        
//        SquareDemoViewController *squareDemoViewController = [segue destinationViewController];
//        NSArray *viewControllers = [NSArray arrayWithObjects:page1ViewController, page2ViewController, page3ViewController, page4ViewController, page5ViewController, page6ViewController, nil];
//        squareDemoViewController.viewControllers = viewControllers;
    }
               
}



@end
