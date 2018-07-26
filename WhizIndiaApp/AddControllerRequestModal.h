//
//  AddControllerRequestModal.h
//  AUTOIApp
//
//  Created by Manzar_Hussain on 14/03/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddControllerRequestModal : NSObject

@property (nonatomic, strong) NSString* controllerId;
@property (nonatomic, strong) NSString* passKey;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* controllerName;
@property (nonatomic, strong) NSString* firstDevice;
@property (nonatomic, strong) NSString* secondDevice;

- (NSMutableDictionary *)createRequestDictionary;

@end
