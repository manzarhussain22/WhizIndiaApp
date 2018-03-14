//
//  RegisterResponseModal.h
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterResponseModal : NSObject

@property(strong, nonatomic) NSNumber *registerStatus;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
