//
//  RegisterResponseModal.m
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import "RegisterResponseModal.h"

@implementation RegisterResponseModal
@synthesize registerStatus;
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    if (self == nil) return nil;
    
    registerStatus = dictionary[statusKey];
    return self;
}

@end
