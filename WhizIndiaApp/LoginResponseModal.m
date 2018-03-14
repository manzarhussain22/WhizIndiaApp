//
//  LoginResponseModal.m
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import "LoginResponseModal.h"

@implementation LoginResponseModal
@synthesize controllers, homeId, detailedController,userDict;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    if (self == nil) return nil;
    userDict = dictionary;
    detailedController = [[NSMutableDictionary alloc] init];
    controllers = dictionary[controllersKey];
    for (NSString *key in [controllers allKeys]) {
        [detailedController setValue:dictionary[key] forKey:key];
    }
    NSDictionary *dict = dictionary[homeIDKey];
    homeId = dict[homeIDKey];
    return self;
}

@end
