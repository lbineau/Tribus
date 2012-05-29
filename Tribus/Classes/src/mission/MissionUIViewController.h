//
//  MissionUIViewController.h
//  StoryTest
//
//  Created by lbineau on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GenericUIViewController.h"
#import "iCarousel.h"

@interface MissionUIViewController : GenericUIViewController<iCarouselDataSource,iCarouselDelegate>;
@property (nonatomic, retain) NSMutableDictionary *itemDatas;
@property (weak, nonatomic) IBOutlet iCarousel *icarousel;

@end
