//
//  IslandUIViewController.m
//  Tribus
//
//  Created by lbineau on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShopUIViewController.h"

@implementation ShopUIViewController

@synthesize carousel;
@synthesize pageControl;
@synthesize items;

- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    self.items = [NSMutableArray arrayWithObjects:@"island-green.png",
                  @"island-orange.png",
                  @"island-yellow.png",
                  @"island-green.png",
                  @"island-orange.png",
                  @"island-yellow.png",
                  nil];
    [pageControl setNumberOfPages:items.count];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configure carousel
    carousel.type = iCarouselTypeLinear;
}

- (void)viewDidUnload
{
    [self setPageControl:nil];
    [super viewDidUnload];
    
    //free up memory by releasing subviews
    carousel.delegate = nil;
    carousel.dataSource = nil;
    
    carousel = nil;
    items = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
/*
 // Override width of carouselItems
- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return 400;
}
 */
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if(index == carousel.currentItemIndex){
        NSLog(@"Tap on the current item");        
    }
}
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [items count];
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    [pageControl setCurrentPage:index];
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[items objectAtIndex:index]]];
        view.layer.doubleSided = NO; //prevent back side of view from showing
        /*label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        [view addSubview:label];*/
    }
    else
    {
        label = [[view subviews] lastObject];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    //label.text = [[items objectAtIndex:index] stringValue];
    return view;
}

@end
