//
//  IslandUIViewController.h
//  Tribus
//
//  Created by lbineau on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface IslandUIViewController : UIViewController<iCarouselDataSource,iCarouselDelegate>;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, retain) NSMutableArray *items;
@end
