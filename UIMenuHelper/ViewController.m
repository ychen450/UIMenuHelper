//
//  ViewController.m
//  UIMenuHelper
//
//  Created by Yan-Ling, Chen on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize btnPullSquare;
@synthesize btnPullRotate;
@synthesize templabel;
@synthesize wheel,square;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)swipeUpDetected:(UISwipeGestureRecognizer *)sender {
    if (rotateup == NO) {
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
            
            [btnPullSquare setTitle:@"close square" forState:UIControlStateNormal];
            squareup = YES;
        } else {
            [square closedown];
            
            [btnPullSquare setTitle:@"square menu" forState:UIControlStateNormal];
            squareup = NO;
        }
    }
}

- (IBAction)swipeDownDetected:(UISwipeGestureRecognizer *)sender {
    if (squareup == YES) {
        [square closedown];
        
        [btnPullSquare setTitle:@"square menu" forState:UIControlStateNormal];
        squareup = NO;
    }
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    squareup = NO;
    rotateup = NO;
    
//    // swipe gesture to open square menu
//    UISwipeGestureRecognizer *swipeUpRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUpDetected:)];
//    swipeUpRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
//    [self.view addGestureRecognizer:swipeUpRecognizer];
//    UISwipeGestureRecognizer *swipeDownRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownDetected:)];
//    swipeDownRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
//    [self.view addGestureRecognizer:swipeDownRecognizer];
    
    // PieChart usage:
    PieChart *piechart = [[PieChart alloc] initWithFrame:CGRectMake(160, 30, 100, 100)];
    piechart.pievalue = 0.2;
    piechart.color1 = [UIColor redColor];
    piechart.color2 = [UIColor yellowColor];
    piechart.midtext = @"220";
    [self.view addSubview:piechart];
}

- (void)viewDidUnload
{
    [self setBtnPullRotate:nil];
    [self setBtnPullSquare:nil];
    [self setTemplabel:nil];
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

- (IBAction)PullRotate:(id)sender {
    if (wheel == nil) {
        // Rotate menu setup
        wheel = [[SMRotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 320, 320) 
                                         andDelegate:self 
                                        withSections:7];
        NSArray *icons = [NSArray arrayWithObjects:@"myicon0.png", @"myicon1.png", @"myicon2.png", @"myicon3.png", @"myicon4.png", @"myicon5.png", @"myicon6.png", nil];
        [wheel setImageFiles:icons background:@"myrotbg.png" center:@"myrotcenter.png" sector:@"myrotsec.png" sectorSel:@"myrotsec2.png"];
        wheel.center = CGPointMake(160, 300);
        wheel.frame = CGRectMake(0, 428, 320, 320);
        
    }
    if (rotateup == NO) {
        [self.view addSubview:wheel];
        [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             wheel.frame = CGRectMake(0, 140, 320, 320);
                             btnPullRotate.frame = CGRectMake(0, 140, 320, 32);
                         }
                         completion:nil];
        [self.view bringSubviewToFront:btnPullRotate];
        [btnPullRotate setImage:[UIImage imageNamed:@"myrotbtn2.png"] forState:UIControlStateNormal];
        rotateup = YES;
    } else {
        [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             wheel.frame = CGRectMake(0, 428, 320, 320);
                             btnPullRotate.frame = CGRectMake(0, 428, 320, 32);
                         }
                         completion:nil];
        [btnPullRotate setImage:[UIImage imageNamed:@"myrotbtn1.png"] forState:UIControlStateNormal];
        rotateup = NO;
    }
}

- (IBAction)PullSquare:(id)sender {
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
        
        [btnPullSquare setTitle:@"close square" forState:UIControlStateNormal];
        squareup = YES;
    } else {
        [square closedown];
        
        [btnPullSquare setTitle:@"square menu" forState:UIControlStateNormal];
        squareup = NO;
    }
}

- (void) rotateDidChangeValue:(NSString *)newValue {
    
    templabel.text = [NSString stringWithFormat:@"rotate page: %@", newValue];
    
}

- (void) squareDidChangeValue:(int)btntag {
    
    templabel.text = [NSString stringWithFormat:@"square page: %d", btntag];
    
}


@end
