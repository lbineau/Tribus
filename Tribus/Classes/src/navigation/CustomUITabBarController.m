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
        UIImage *buttonImage = [UIImage imageNamed:@"main-button-normal.png"];
        
        UIButton* aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aButton.frame = CGRectMake(20 + i * 120.0, 0.0, buttonImage.size.width,buttonImage.size.height);
        UIViewController *item = [self.viewControllers objectAtIndex:i];
        aButton.titleLabel.font = [UIFont fontWithName:@"Kohicle25" size:25];
        [aButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [aButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
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
        
        //Transition
        [UIView beginAnimations:@"animation" context:nil];
        //[myNavigationController pushViewController:myViewController animated:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
        [UIView setAnimationDuration:0.5];
        [UIView commitAnimations];
        
        self.selectedIndex = controllerIndex;
    }

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
@end
