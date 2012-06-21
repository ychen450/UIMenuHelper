//
//  SquareDemoViewController.h
//  UIMenuHelper
//
//  Created by Yan-Ling, Chen on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SquareMenu.h"
#import "SquareMenuProtocol.h"

@interface SquareDemoViewController : UIViewController<SquareMenuProtocol> {
    
    BOOL squareup;
}

@property (nonatomic, strong) SquareMenu *square;

@end
