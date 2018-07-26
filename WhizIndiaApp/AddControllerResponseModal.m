//
//  AddControllerResponseModal.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 14/03/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "AddControllerResponseModal.h"

@implementation AddControllerResponseModal
@synthesize devices, deviceStatus, response, broadCastDetails;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    if (self == nil) return nil;
    response = dictionary[responseKey];
    deviceStatus = dictionary[deviceStatusKey];
    devices = dictionary[devicesKey];
    broadCastDetails = dictionary[broadCastDetailsKey];
    
    return self;
}


@end
