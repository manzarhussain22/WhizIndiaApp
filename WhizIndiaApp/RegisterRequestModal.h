//
//  RegisterRequestModal.h
//  AUTOIApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterRequestModal : NSObject

@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* phoneNumber;

- (NSMutableDictionary *)createRequestDictionary;

@end
