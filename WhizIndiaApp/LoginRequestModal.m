//
//  LoginRequestModal.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "LoginRequestModal.h"

@implementation LoginRequestModal
@synthesize email, password;

- (NSMutableDictionary *)createRequestDictionary {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:email forKey:emailKey];
    [dict setObject:password forKey:passwordKey];
    
    return dict;
}

@end
