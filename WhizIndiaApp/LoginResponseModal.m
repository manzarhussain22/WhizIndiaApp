//
//  LoginResponseModal.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "LoginResponseModal.h"

@implementation LoginResponseModal
@synthesize controllers, homeId, detailedController,userDict;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    if (self == nil) return nil;
    userDict = [dictionary mutableCopy];
    detailedController = [[NSMutableDictionary alloc] init];
    controllers = dictionary[controllersKey];
    for (NSString *key in [controllers allKeys]) {
        [detailedController setValue:dictionary[key] forKey:key];
    }
    NSDictionary *dict = dictionary[homeIDKey];
    homeId = dict[homeIDKey];
    [[SharedClass sharedInstance] setProfileDetails:dictionary[ProfileKey]];
    [[SharedClass sharedInstance] setSecurityDetails:dictionary[SecurityKey]];
    [[SharedClass sharedInstance] setISwitchStatus:dictionary[iSwitchStatusKey]];
    [[SharedClass sharedInstance] setTopicDetails:dictionary[TopicKey]];
    return self;
}

@end
