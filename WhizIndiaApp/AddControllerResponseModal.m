//
//  AddControllerResponseModal.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 14/03/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "AddControllerResponseModal.h"

@implementation AddControllerResponseModal
@synthesize devices;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    if (self == nil) return nil;
    devices = dictionary;
    return self;
}


@end
