//
//  IslandUIViewController.m
//  Tribus
//
//  Created by lbineau on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShopUIViewController.h"

@implementation ShopUIViewController

@synthesize productDetail;
@synthesize icarousel;
@synthesize items;
@synthesize itemDatas;

- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    self.items = [NSMutableArray arrayWithObjects:
                  @"green",
                  @"blue",
                  nil];
    
    self.itemDatas = [[NSMutableDictionary alloc] init];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                          [[NSArray alloc] initWithObjects:UIColorFromRGB(0x445132), @"item2.png",@"<b>Hilja</b>, l'île dansante",nil] forKeys:
                          [[NSArray alloc] initWithObjects:@"color", @"path",@"title",nil]]
                  forKey:[items objectAtIndex:0]];
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                          [[NSArray alloc] initWithObjects:UIColorFromRGB(0x445132), @"item2.png",@"<b>Hilja</b>, l'île dansante",nil] forKeys:
                          [[NSArray alloc] initWithObjects:@"color", @"path",@"title",nil]]
                  forKey:[items objectAtIndex:1]];
    
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configure carousel
    icarousel.type = iCarouselTypeLinear;
    [icarousel setContentOffset:CGSizeMake(-50, 0)];
}

- (void)viewDidUnload
{    
    //free up memory by releasing subviews
    icarousel.delegate = nil;
    icarousel.dataSource = nil;
    
    icarousel = nil;
    [items removeAllObjects];
    items = nil;
    [itemDatas removeAllObjects];
    itemDatas = nil;
    
    [self setProductDetail:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark iCarousel methods
- (CGFloat)carousel:(iCarousel *)carousel valueForTransformOption:(iCarouselTranformOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselTranformOptionArc:
        {
            return 2 * M_PI * 1;
        }
        case iCarouselTranformOptionRadius:
        {
            return value * 1.5;
        }
        default:
        {
            return value;
        }
    }
}
- (void)carouselWillBeginScrollingAnimation:(iCarousel *)carousel{
    
    //[productDetail removeFromSuperview];
    NSLog(@"scroll");
}
- (void)carouselDidScroll:(iCarousel *)carousel{
    
    NSMutableDictionary *currentItem = [itemDatas objectForKey:[items objectAtIndex:carousel.currentItemIndex]];

}
-(CGFloat)carouselItemWidth:(iCarousel *)carousel{
    return 300.0;
}
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [items count];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    //3. now add animation
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];    if(index == carousel.currentItemIndex){
        
        [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight 
                                   forView:carousel.currentItemView cache:YES];
            
        [productDetail removeFromSuperview];
        [carousel.currentItemView addSubview:self.productDetail];
    } else {
    }
    [UIView commitAnimations];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{    
    NSMutableDictionary *currentItem = [itemDatas objectForKey:[items objectAtIndex:index]];
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[currentItem valueForKey:@"path"]]];
        view.layer.doubleSided = NO; //prevent back side of view from showing
    }
    
    return view;
}

@end
