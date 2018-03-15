//
//  EditControllerResponseModal.h
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 15/03/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditControllerResponseModal : NSObject

@property(strong, nonatomic) NSString *editStatus;
- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
