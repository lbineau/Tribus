//
//  ColorUIViewController.h
//  Tribus
//
//  Created by lbineau on 20/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum 
{
    small = 0,
    big = 2
} SizeType;

@interface ColorUIViewController : UIViewController{
    SizeType type;    
}

@property (weak, nonatomic) IBOutlet UIView *bigColorView;
@property (weak, nonatomic) IBOutlet UIView *smallColorView;
@property (nonatomic, retain) UIView *currentView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andType:(SizeType)sizeType;
- (void)initializeTextfields;

@end