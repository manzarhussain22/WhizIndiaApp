//
//  RegisterRequestModal.h
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterRequestModal : NSObject

@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* phoneNumber;
@property (nonatomic, strong) NSString* dateOfBirth;

- (NSMutableDictionary *)createRequestDictionary;

@end
