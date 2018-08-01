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

-(void)parseDataToRealmFrom:(NSDictionary *)response {
    controllers = response[controllersKey];
    [[RealmHelper sharedInstance] persistToProfileRealm:response[ProfileKey]];
    for (NSString *iSwitchId in [controllers allKeys]) {
        NSMutableDictionary *iSwitchDict = [[NSMutableDictionary alloc] init];
        [iSwitchDict setObject:iSwitchId forKey:iSwitchIdKey];
        [iSwitchDict setObject:[controllers valueForKey:iSwitchId] forKey:iSwitchNameKey];
        [iSwitchDict setObject:[response[SecurityKey] valueForKey:iSwitchId] forKey:iSwitchSecurityKey];
        [iSwitchDict setObject:[response[TopicKey] valueForKey:iSwitchId] forKey:iSwitchTopicKey];
        [iSwitchDict setObject:[self createDeviceDictWithDevice:response[iSwitchId] andStatus:[response[iSwitchStatusKey] valueForKey:iSwitchId]] forKey:iSwitchDevicesKey];
        
        [[RealmHelper sharedInstance] persistToiSwitchRealm:iSwitchDict];
    }
}


-(NSArray *)createDeviceDictWithDevice:(NSDictionary *)deviceDict andStatus:(NSString *)deviceStatus {
    NSMutableArray *devicesArr = [[NSMutableArray alloc] init];
    int i = 0;
    for (NSString *deviceId in [deviceDict allKeys]) {
        NSMutableDictionary *devices = [[NSMutableDictionary alloc] init];
        [devices setObject:deviceId forKey:iSwitchDeviceIdKey];
        [devices setObject:deviceDict[deviceId] forKey:iSwitchDeviceNameKey];
        NSString *icharDeviceId  = [NSString stringWithFormat:@"%c", [deviceStatus characterAtIndex:i]];
        if ([icharDeviceId isEqualToString:deviceId]) {
            NSString *icharDeviceStatus  = [NSString stringWithFormat:@"%c", [deviceStatus characterAtIndex:i+1]];
            [devices setObject:icharDeviceStatus forKey:iSwitchDeviceStatusKey];
        }
        [devicesArr addObject:devices];
        i=i+2;
    }
    return devicesArr;
}

@end
