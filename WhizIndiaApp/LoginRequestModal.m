//
//  LoginRequestModal.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "LoginRequestModal.h"

@implementation LoginRequestModal
@synthesize email, password,name, isSocial;

- (NSMutableDictionary *)createRequestDictionary {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:email forKey:emailKey];
    
    if (isSocial) {
        [dict setObject:name forKey:usernameKey];
        [dict setObject:@"G" forKey:modeKey];
    }
    else
    [dict setObject:password forKey:passwordKey];
    
    return dict;
}

@end
