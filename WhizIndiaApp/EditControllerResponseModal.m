//
//  EditControllerResponseModal.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 15/03/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "EditControllerResponseModal.h"

@implementation EditControllerResponseModal
@synthesize editStatus;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    if (self == nil) return nil;
    NSDictionary *dict = dictionary[@"response"];
    editStatus = dict[@"status"];
    return self;
}

@end
