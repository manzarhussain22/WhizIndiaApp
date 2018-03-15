//
//  AddControllerResponseModal.h
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 14/03/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddControllerResponseModal : NSObject

@property(strong, nonatomic) NSDictionary *devices;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
