//
//  CustomUITabBarController.m
//  Tribus
//
//  Created by lbineau on 05/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomUITabBarController.h"

@implementation CustomUITabBarController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Remove the tabBar
    [self.tabBar setHidden:YES];
    [self.tabBar removeFromSuperview];
    UIView *contentView;
    if ([[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
        contentView = [self.view.subviews objectAtIndex:1];
    } else {
        contentView = [self.view.subviews objectAtIndex:0];
    }
    contentView.frame = self.view.bounds;

    // Add the same number of buttons as in the tabBar
    for( int i = 0; i < [self.viewControllers count]; i++ ) {
        UIButton* aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        aButton.frame = CGRectMake(i * 100.0, 0.0, 100.0, 40.0);
        UIViewController *item = [self.viewControllers objectAtIndex:i];
        [aButton setTitle:item.title forState:UIControlStateNormal];
        [aButton setTag:i];
        [aButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:aButton];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)buttonClicked:(UIButton*)button
{
    // Get views. controllerIndex is passed in as the controller we want to go to. 
    // Get the views.
    int controllerIndex = (int)[button tag];
    if(controllerIndex != self.selectedIndex){
        self.selectedIndex = controllerIndex;
        /*UIView * fromView = self.selectedViewController.view;
        UIView * toView = [[self.viewControllers objectAtIndex:controllerIndex] view];
        
        [UIView transitionFromView:fromView
                            toView:toView
                          duration:1.0
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        completion:^(BOOL finished) {self.selectedIndex = controllerIndex;}
         ];*/
    }

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
@end
