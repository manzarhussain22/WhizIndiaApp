//
//  Device.h
//  AutoIHomes
//
//  Created by Manzar_Hussain on 27/07/18.
//  Copyright © 2018 AutoI Innovations Pvt. Ltd. All rights reserved.
//

#import <Realm/Realm.h>

@class iSwitches;

@interface Device : RLMObject
@property (strong, nonatomic) NSString *deviceId;
@property (strong, nonatomic) NSString *deviceName;
@property (nonatomic) BOOL status;
@property iSwitches *iSwitch;
@end
