//
//  ColorUIViewController.m
//  Tribus
//
//  Created by lbineau on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ColorManager.h"
#import "Color.h"
#import "SBJson.h"

@implementation ColorManager
@synthesize colorDictionnary;

- (id)init
{
    self = [super init];
    colorDictionnary = [[NSMutableDictionary alloc] init];
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    
    // Creation du parser
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"color" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    // On récupère le JSON en NSString depuis la réponse
    NSString *json_string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // on parse la reponse JSON
    NSArray *res = [parser objectWithString:json_string error:nil];
    for (NSDictionary *obj in res){

        Color *color = [[Color alloc] initWithId:[obj valueForKey:@"id"] andCode:[obj valueForKey:@"code"] andLabel:[obj valueForKey:@"label"]];

        if([pref boolForKey:@"resetApp"] || [pref valueForKey:color.colorId] == nil){
            [pref setValue:[obj valueForKey:@"defaultValue"] forKey:color.colorId];            
            [pref synchronize];
        }
        
        color.colorValue = [pref valueForKey:color.colorId];
        NSLog(@"%@",color.colorValue);
        
        [colorDictionnary setValue:color forKey:color.colorId];
    }
    
    return self;
}

- (void) addPoints:(int) points forColorId:(NSString*) colorId{
    Color *color = [colorDictionnary valueForKey:colorId];
    color.colorValue = [NSNumber numberWithInt:(color.colorValue.integerValue + points)];
    [self saveColorId:colorId];
}

- (void) removePoints:(int) points forColorId:(NSString*) colorId{
    Color *color = [colorDictionnary valueForKey:colorId];
    // 0 security
    if(color.colorValue.integerValue - points >= 0)
        color.colorValue = [NSNumber numberWithInt:(color.colorValue.integerValue - points)];
    else
        color.colorValue = [NSNumber numberWithInt:0];
    [self saveColorId:colorId];
}

- (void) saveColorId:(NSString*) colorId{
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    Color *color = [colorDictionnary valueForKey:colorId];
    [pref setValue:color.colorValue forKey:color.colorId];            
    [pref synchronize];
}

@end
