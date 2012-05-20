//
//  ColorUIViewController.m
//  Tribus
//
//  Created by lbineau on 20/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ColorUIViewController.h"

@implementation ColorUIViewController
@synthesize bigColorView, smallColorView,currentView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andType:(SizeType)sizeType
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        type = sizeType;
    }
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(eventHandler:)
     name:@"addedPoints"
     object:nil ];
    
    return self;
}

-(void)eventHandler: (NSNotification *) notification
{
    NSLog(@"event triggered");
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [smallColorView setHidden:YES];
    [bigColorView setHidden:YES];
    switch (type) {
        case small:
            currentView = smallColorView;
            break;
        case big:
            currentView = bigColorView;
            break;
            
        default:
            currentView = self.view;
            break;
    }
    [currentView setHidden:NO];
    //[self initTextfields];
    //[self.view setCenter:[currentView center]];
}
- (void) initTextfields{
    
}
- (void)viewDidUnload
{
    [self setBigColorView:nil];
    [self setSmallColorView:nil];
    [self setCurrentView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
