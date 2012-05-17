//
//  ColorUIViewController.h
//  Tribus
//
//  Created by lbineau on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorManager : NSObject

@property (strong, nonatomic) NSMutableDictionary *colorDictionnary;
- (void) addPoints:(int) points forColorId:(NSString*) colorId;
- (void) removePoints:(int) points forColorId:(NSString*) colorId;
- (void) saveColorId:(NSString*) colorId;

@end
