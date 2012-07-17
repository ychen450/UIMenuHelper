//
//  Page1ViewController.m
//  UIMenuHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import "Page1ViewController.h"


@implementation Page1ViewController

@synthesize page1btn;


- (IBAction)page1btnClick:(id)sender {
    if (!btntemp) {
        [page1btn setTitle:@"hello" forState:UIControlStateNormal];
        btntemp = !btntemp;
    } else {
        [page1btn setTitle:@"button" forState:UIControlStateNormal];
        btntemp = !btntemp;
    }
    
    [pie setPieValue:0.9 text1:@"500"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"page1 view did load");
    
    pie = [[PieChart alloc] initWithFrame:CGRectMake(100, 0, 200, 200) 
                                                   value:0.3 
                                                setColor:203./255. green1:51./255. blue1:51./255. red2:250./255. green2:153./255. blue2:51./255. 
                                                setImage:@"circle.png" patternImage:@"pattern.png" 
                                                 setText:@"220" text2:@"POINTS" font:@"Helvetica"];
    [self.view addSubview:pie];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
