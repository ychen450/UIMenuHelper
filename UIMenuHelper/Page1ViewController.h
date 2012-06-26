//
//  Page1ViewController.h
//  UIMenuHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import <UIKit/UIKit.h>

@interface Page1ViewController : UIViewController {
    
    BOOL btntemp;
}

@property (strong, nonatomic) IBOutlet UIButton *page1btn;

- (IBAction)page1btnClick:(id)sender;

@end
