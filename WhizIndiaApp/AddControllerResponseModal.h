//
//  AddControllerResponseModal.h
//  AUTOIApp
//
//  Created by Manzar_Hussain on 14/03/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddControllerResponseModal : NSObject

@property(strong, nonatomic) NSDictionary *devices;
@property(strong, nonatomic) NSDictionary *response;
@property(strong, nonatomic) NSDictionary *broadCastDetails;
@property(strong, nonatomic) NSDictionary *deviceStatus;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
