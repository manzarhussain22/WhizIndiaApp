//
//  EditControllerRequestModal.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 16/03/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "EditControllerRequestModal.h"

@implementation EditControllerRequestModal
@synthesize controllerDetail, deviceDetail;

- (NSMutableDictionary *)createRequestDictionary {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:controllerDetail forKey:controllersKey];
    [dict setObject:deviceDetail forKey:devicesKey];
    return dict;
}


@end
