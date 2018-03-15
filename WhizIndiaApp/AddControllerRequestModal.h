//
//  AddControllerRequestModal.h
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 14/03/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddControllerRequestModal : NSObject

@property (nonatomic, strong) NSString* controllerId;
@property (nonatomic, strong) NSString* passKey;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* controllerName;

- (NSMutableDictionary *)createRequestDictionary;

@end
