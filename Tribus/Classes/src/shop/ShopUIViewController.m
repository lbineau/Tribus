//
//  IslandUIViewController.m
//  Tribus
//
//  Created by lbineau on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShopUIViewController.h"

@implementation ShopUIViewController

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
                          [[NSArray alloc] initWithObjects:UIColorFromRGB(0x445132), @"ile_verte.png",@"<b>Hilja</b>, l'île dansante",nil] forKeys:
                          [[NSArray alloc] initWithObjects:@"color", @"path",@"title",nil]]
                  forKey:[items objectAtIndex:0]];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                          [[NSArray alloc] initWithObjects:UIColorFromRGB(0xA8510C), @"ile_orange.png",@"<b>Oren</b>, l'île dormante",nil] forKeys:
                          [[NSArray alloc] initWithObjects:@"color", @"path",@"title",nil]]
                  forKey:[items objectAtIndex:1]];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                          [[NSArray alloc] initWithObjects:UIColorFromRGB(0x8D5D2E), @"ile_jaune.png",@"<b>Isfar</b>, l'île sablonneuse",nil] forKeys:
                          [[NSArray alloc] initWithObjects:@"color", @"path",@"title",nil]]
                  forKey:[items objectAtIndex:2]];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                          [[NSArray alloc] initWithObjects:UIColorFromRGB(0xAD2304), @"ile_rouge.png",@"<b>Tneera</b>, l'île fumante",nil] forKeys:
                          [[NSArray alloc] initWithObjects:@"color", @"path",@"title",nil]]
                  forKey:[items objectAtIndex:3]];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                          [[NSArray alloc] initWithObjects:UIColorFromRGB(0x3B4444), @"ile_bleue.png",@"<b>Pancada</b>, l'île cristaline",nil] forKeys:
                          [[NSArray alloc] initWithObjects:@"color", @"path",@"title",nil]]
                  forKey:[items objectAtIndex:4]];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                          [[NSArray alloc] initWithObjects:UIColorFromRGB(0x582E97), @"ile_violette.png",@"<b>Bahlû</b>, l'île sombre",nil] forKeys:
                          [[NSArray alloc] initWithObjects:@"color", @"path",@"title",nil]]
                  forKey:[items objectAtIndex:5]];
    
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configure carousel
    icarousel.type = iCarouselTypeLinear;
    CGFloat width = [UIScreen mainScreen].bounds.size.height;
    CGFloat height = [UIScreen mainScreen].bounds.size.width;
    islandTitle = [[NMCustomLabel alloc] initWithFrame:CGRectMake(0, height - 50, width, 100)];
    islandTitle.ctTextAlignment = kCTCenterTextAlignment;
    [islandTitle setBackgroundColor:[UIColor clearColor]];
    //    islandTitle.textAlignment = UITextAlignmentCenter;
    //[islandTitle setTextAlignment:UITextAlignmentCenter];
    islandTitle.font = [UIFont fontWithName:@"Kohicle25" size:25];
    islandTitle.fontBold = [UIFont fontWithName:@"Kohicle25" size:40];
    [self.view addSubview:islandTitle];
}

- (void)viewDidUnload
{
    [self setIslandTitle:nil];
    
    //free up memory by releasing subviews
    icarousel.delegate = nil;
    icarousel.dataSource = nil;
    
    icarousel = nil;
    [items removeAllObjects];
    items = nil;
    [itemDatas removeAllObjects];
    itemDatas = nil;
    
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

- (void)carouselDidScroll:(iCarousel *)carousel{
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    NSMutableDictionary *currentItem = [itemDatas objectForKey:[items objectAtIndex:carousel.currentItemIndex]];
    islandTitle.text = [currentItem valueForKey:@"title"];
    
    islandTitle.textColor = [currentItem valueForKey:@"color"];
    //    [[NSColor alloc] initWithCIColor:<#(CIColor *)#>]
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
