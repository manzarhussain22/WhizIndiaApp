//
//  LoginResponseModal.h
//  AUTOIApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginResponseModal : NSObject

@property(strong, nonatomic) NSDictionary *controllers;
@property(strong, nonatomic) NSString *homeId;
@property(strong, nonatomic) NSMutableDictionary *detailedController;
@property(strong, nonatomic) NSMutableDictionary *userDict;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
