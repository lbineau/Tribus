//
//  ShopUIViewController.h
//  StoryTest
//
//  Created by lbineau on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GenericUIViewController.h"
#import "iCarousel.h"

@interface ShopUIViewController : GenericUIViewController<iCarouselDataSource,iCarouselDelegate>;

@property (weak, nonatomic) IBOutlet iCarousel *icarousel;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSMutableDictionary *itemDatas;
@end
