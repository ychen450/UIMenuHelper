//
//  ViewController.h
//  UIMenuHelper
//
//  Created by Yan-Ling, Chen on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMRotaryWheel.h"
#import "SMRotaryProtocol.h"
#import "SquareMenu.h"
#import "SquareMenuProtocol.h"
#import "PieChart.h"

@interface ViewController : UIViewController <SMRotaryProtocol> {
    
    BOOL squareup;
    BOOL rotateup;
}

@property (nonatomic, strong) SMRotaryWheel *wheel;
@property (nonatomic, strong) SquareMenu *square;

@property (strong, nonatomic) IBOutlet UIButton *btnPullSquare;
@property (strong, nonatomic) IBOutlet UIButton *btnPullRotate;
@property (strong, nonatomic) IBOutlet UILabel *templabel;

- (IBAction)PullRotate:(id)sender;
- (IBAction)PullSquare:(id)sender;

@end

