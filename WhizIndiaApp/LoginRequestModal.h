//
//  LoginRequestModal.h
//  AUTOIApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginRequestModal : NSObject

@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSString* name;
@property (nonatomic) BOOL isSocial;

- (NSMutableDictionary *)createRequestDictionary;


@end
