UIMenuHelper
===============

iOS Rotate and Square Menu Helper

##Features:
* Rotate menu that can scroll circularly or tap to automatically rotate. 
* Square menu that can slide up through swipe gesture and present notification.
* Menus control and present the selected child view controllers. 

![Screenshot](https://github.com/ychen450/UIMenuHelper/raw/master/screenShot1.png)
![Screenshot](https://github.com/ychen450/UIMenuHelper/raw/master/screenShot2.png)


##How to use:
* Put RotateMenu and SquareMenu class (.h and .m) into your project. Remember to #import "RotateMenu.h", #import "SquareMenu.h" and <RotateMenuDelegate>, <SquareMenuDelegate> when using.
* Rotate Menu - set up in ViewDidLoad:
      ```objc
      contentContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 384)];
      [self.view addSubview:contentContainerView];
    
      UIViewController *toViewController;
      toViewController = [_viewControllers objectAtIndex:0];
      toViewController.view.frame = contentContainerView.bounds;
      [contentContainerView addSubview:toViewController.view];

      wheel = [[RotateMenu alloc] initWithFrame:CGRectMake(0, 0 , 320, 320) 
                                      andDelegate:self 
                                     withSections:7
                                     iconFaceDown:YES];
      NSArray *icons = [NSArray arrayWithObjects:@"myicon0.png", @"myicon1.png", @"myicon2.png", @"myicon3.png", @"myicon4.png", @"myicon5.png", @"myicon6.png", nil];
      [wheel setImageFiles:icons  downBtn:@"myrotbtn1.png" upBtn:@"myrotbtn2.png" background:@"myrotbg.png" center:@"myrotcenter.png" sector:@"myrotsec.png" sectorSel:@"myrotsec2.png"];
      wheel.rotateEnable = NO;
      wheel.center = CGPointMake(160, 256);
      wheel.frame = CGRectMake(0, 428, 320, 320);
      [self.view addSubview:wheel];
      ```

