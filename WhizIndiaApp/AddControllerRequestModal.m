//
//  AddControllerRequestModal.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 14/03/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "AddControllerRequestModal.h"

@implementation AddControllerRequestModal
@synthesize controllerId,controllerName,email, passKey, firstDevice, secondDevice;

- (NSMutableDictionary *)createRequestDictionary {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:email forKey:add_controllerUsernameKey];
    [dict setObject:passKey forKey:add_controllerPassKey];
    [dict setObject:controllerId forKey:add_controllerIdKey];
    [dict setObject:controllerName forKey:add_controllerNameKey];
    [dict setObject:firstDevice forKey:add_firstDeviceNameKey];
    [dict setObject:secondDevice forKey:add_secondDeviceNameKey];
    
    return dict;
}


@end
