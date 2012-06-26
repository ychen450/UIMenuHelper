UIMenuHelper
===============

iOS Rotate and Square Menu Helper

##Features:
* Rotate menu that can scroll circularly or tap to automatically rotate. 
* Square menu that can slide up through swipe gesture and present notification.
* Menus control and present the selected child view controllers. 

##How to use:
* Put RotateMenu and SquareMenu class (.h and .m) into your project. Remember to #import "RotateMenu.h", #import "SquareMenu.h" and <RotateMenuDelegate>, <SquareMenuDelegate> when using.
* Set up in ViewDidLoad:
      ```objc
      contentContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 384)];
      [self.view addSubview:contentContainerView];
    
      UIViewController *toViewController;
      toViewController = [_viewControllers objectAtIndex:0];
      toViewController.view.frame = contentContainerView.bounds;
      [contentContainerView addSubview:toViewController.view];
      ```

* Paste the following code outside of ViewDidLoad, connect your button for pulling up the menu:
      ```objc
      - (IBAction)pullRotate:(id)sender {
    
    if (wheel == nil) {
        // Rotate menu setup
        wheel = [[RotateMenu alloc] initWithFrame:CGRectMake(0, 0 , 320, 320) 
                                         andDelegate:self 
                                        withSections:7];
        NSArray *icons = [NSArray arrayWithObjects:@"myicon0.png", @"myicon1.png", @"myicon2.png", @"myicon3.png", @"myicon4.png", @"myicon5.png", @"myicon6.png", nil];
        [wheel setImageFiles:icons background:@"myrotbg.png" center:@"myrotcenter.png" sector:@"myrotsec.png" sectorSel:@"myrotsec2.png"];
        wheel.center = CGPointMake(160, 256);
        wheel.frame = CGRectMake(0, 428, 320, 320);
        
    }
    if (rotateup == NO) {
        [self.view addSubview:wheel];
        [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             wheel.frame = CGRectMake(0, 140, 320, 320);
                             pullRotateBtn.frame = CGRectMake(0, 140, 320, 32);
                         }
                         completion:nil];
        [self.view bringSubviewToFront:pullRotateBtn];
        [pullRotateBtn setImage:[UIImage imageNamed:@"myrotbtn2.png"] forState:UIControlStateNormal];
        rotateup = YES;
    } else {
        [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             wheel.frame = CGRectMake(0, 428, 320, 320);
                             pullRotateBtn.frame = CGRectMake(0, 428, 320, 32);
                         }
                         completion:nil];
        [pullRotateBtn setImage:[UIImage imageNamed:@"myrotbtn1.png"] forState:UIControlStateNormal];
        rotateup = NO;
    }
}

      ```

