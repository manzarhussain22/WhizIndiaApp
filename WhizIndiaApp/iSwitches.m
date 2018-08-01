//
//  iSwitches.m
//  AutoIHomes
//
//  Created by Manzar_Hussain on 27/07/18.
//  Copyright © 2018 AutoI Innovations Pvt. Ltd. All rights reserved.
//

#import "iSwitches.h"

@implementation iSwitches

+ (NSDictionary *)linkingObjectsProperties {
    return @{
             @"devices": [RLMPropertyDescriptor descriptorWithClass:Device.class propertyName:@"iSwitch"],
             };
}

@end
