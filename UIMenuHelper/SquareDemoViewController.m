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
    
    NSLog(@"heyhey");
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
    
    NSLog(@"hey");
    
    // swipe gesture to open square menu
    UISwipeGestureRecognizer *swipeUpRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUpDetected:)];
    swipeUpRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUpRecognizer];
    UISwipeGestureRecognizer *swipeDownRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownDetected:)];
    swipeDownRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDownRecognizer];

}

- (void) squareDidChangeValue:(int)btntag {
   
    
}



@end
