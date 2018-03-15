//
//  EditControllerRequestModal.h
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 16/03/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditControllerRequestModal : NSObject

@property(strong, nonatomic)NSDictionary *controllerDetail;
@property(strong, nonatomic)NSDictionary *deviceDetail;


- (NSMutableDictionary *)createRequestDictionary;

@end
