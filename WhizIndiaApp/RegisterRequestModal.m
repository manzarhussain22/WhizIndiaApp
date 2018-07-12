//
//  RegisterRequestModal.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "RegisterRequestModal.h"

@implementation RegisterRequestModal
@synthesize username, password, email, phoneNumber;

- (NSMutableDictionary *)createRequestDictionary {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:email forKey:emailKey];
    [dict setObject:password forKey:passwordKey];
    [dict setObject:username forKey:usernameKey];
    [dict setObject:phoneNumber forKey:phoneNumberKey];
    [dict setObject:@"C" forKey:modeKey];

    return dict;
}

@end
