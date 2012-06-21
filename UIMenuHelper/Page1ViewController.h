//
//  Page1ViewController.h
//  UIMenuHelper
//
//  Created by Yan-Ling, Chen on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Page1ViewController : UIViewController {
    
    BOOL btntemp;
}

@property (strong, nonatomic) IBOutlet UIButton *page1btn;

- (IBAction)page1btnClick:(id)sender;

@end
