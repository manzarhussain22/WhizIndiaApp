//
//  AddControllerResponseModal.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 14/03/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "AddControllerResponseModal.h"

@implementation AddControllerResponseModal
@synthesize iSwitchIDAndName;

-(void)parseDataToRealmDatabaseFromResponse:(NSDictionary *)dictionary {
    NSMutableDictionary *iSwitchDict = [[NSMutableDictionary alloc] init];
    [iSwitchDict setObject:[iSwitchIDAndName valueForKey:iSwitchIdKey] forKey:iSwitchIdKey];
    [iSwitchDict setObject:[iSwitchIDAndName valueForKey:iSwitchNameKey] forKey:iSwitchNameKey];
    [iSwitchDict setObject:[dictionary[broadCastDetailsKey] valueForKey:SecurityKey] forKey:iSwitchSecurityKey];
    [iSwitchDict setObject:[dictionary[broadCastDetailsKey] valueForKey:TopicKey] forKey:iSwitchTopicKey];
    [iSwitchDict setObject:[self createDeviceDictWithDevice:dictionary[devicesKey] andStatus:dictionary[deviceStatusKey]] forKey:iSwitchDevicesKey];
    [[RealmHelper sharedInstance] persistToiSwitchRealm:iSwitchDict];
}

-(NSArray *)createDeviceDictWithDevice:(NSDictionary *)deviceDict andStatus:(NSDictionary *)deviceStatus {
    NSMutableArray *devicesArr = [[NSMutableArray alloc] init];
    
    for (NSString *deviceId in [deviceDict allKeys]) {
        NSMutableDictionary *devices = [[NSMutableDictionary alloc] init];
        [devices setObject:deviceId forKey:iSwitchDeviceIdKey];
        [devices setObject:deviceDict[deviceId] forKey:iSwitchDeviceNameKey];
        [devices setObject:deviceStatus[deviceId] forKey:iSwitchDeviceStatusKey];
        [devicesArr addObject:devices];
    }
    return devicesArr;
}

@end
