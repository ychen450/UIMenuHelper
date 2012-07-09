//
//  Page1ViewController.m
//  UIMenuHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import "Page1ViewController.h"
#import "PieChart.h"

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
    
    PieChart *piechart = [[PieChart alloc] initWithFrame:CGRectMake(100, 0, 200, 200)];
    piechart.pievalue = 0.3;
    piechart.color1 = [UIColor redColor];
    piechart.color2 = [UIColor yellowColor];
    piechart.midtext = @"220";
    [self.view addSubview:piechart];
    
    
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
