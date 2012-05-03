//
//  IslandUIViewController.h
//  Tribus
//
//  Created by lbineau on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GenericUIViewController.h"
#import "iCarousel.h"

@interface IslandUIViewController : GenericUIViewController<iCarouselDataSource,iCarouselDelegate>;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSMutableArray *itemDatas;
@end
