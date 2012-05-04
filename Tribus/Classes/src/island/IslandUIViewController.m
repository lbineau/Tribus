//
//  IslandUIViewController.m
//  Tribus
//
//  Created by lbineau on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IslandUIViewController.h"

@implementation IslandUIViewController

@synthesize islandTitle;
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
                  @"orange",
                  @"yellow",
                  @"red",
                  @"blue",
                  @"purple",
                  nil];
    
    self.itemDatas = [[NSMutableDictionary alloc] init];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
      [[NSArray alloc] initWithObjects:@"ile_verte.png",@"Hilja, l'île sinueuse",nil] forKeys:
      [[NSArray alloc] initWithObjects:@"path",@"title",nil]]
                forKey:[items objectAtIndex:0]];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                      [[NSArray alloc] initWithObjects:@"ile_orange.png",@"Oren, l'île dormante",nil] forKeys:
                      [[NSArray alloc] initWithObjects:@"path",@"title",nil]]
              forKey:[items objectAtIndex:1]];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                      [[NSArray alloc] initWithObjects:@"ile_jaune.png",@"Isfar, l'île sablonneuse",nil] forKeys:
                      [[NSArray alloc] initWithObjects:@"path",@"title",nil]]
              forKey:[items objectAtIndex:2]];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                      [[NSArray alloc] initWithObjects:@"ile_rouge.png",@"Tneera, l'île fumante",nil] forKeys:
                      [[NSArray alloc] initWithObjects:@"path",@"title",nil]]
              forKey:[items objectAtIndex:3]];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                      [[NSArray alloc] initWithObjects:@"ile_bleue.png",@"Pancada, l'île cristaline",nil] forKeys:
                      [[NSArray alloc] initWithObjects:@"path",@"title",nil]]
              forKey:[items objectAtIndex:4]];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                      [[NSArray alloc] initWithObjects:@"ile_violette.png",@"Bahlû, l'île sombre",nil] forKeys:
                      [[NSArray alloc] initWithObjects:@"path",@"title",nil]]
              forKey:[items objectAtIndex:5]];
    
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configure carousel
    icarousel.type = iCarouselTypeRotary;
    islandTitle.font = [UIFont fontWithName:@"Kohicle25" size:30];
}

- (void)viewDidUnload
{
    [self setIslandTitle:nil];
    [super viewDidUnload];
    
    //free up memory by releasing subviews
    icarousel.delegate = nil;
    icarousel.dataSource = nil;
    
    icarousel = nil;
    [items removeAllObjects];
    items = nil;
    [itemDatas removeAllObjects];
    itemDatas = nil;
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

- (void)carouselDidScroll:(iCarousel *)carousel{
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    NSMutableDictionary *currentItem = [itemDatas objectForKey:[items objectAtIndex:carousel.currentItemIndex]];
    islandTitle.text = [[currentItem valueForKey:@"title"] uppercaseString];
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [items count];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if(index == carousel.currentItemIndex){
        //NSLog(@"Island selected : %@",[itemDatas objectAtIndex:index]);
    }
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
