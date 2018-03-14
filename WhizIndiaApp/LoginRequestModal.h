//
//  LoginRequestModal.h
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginRequestModal : NSObject

@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* password;

- (NSMutableDictionary *)createRequestDictionary;


@end
