//
//  iSwitches.h
//  AutoIHomes
//
//  Created by Manzar_Hussain on 27/07/18.
//  Copyright © 2018 AutoI Innovations Pvt. Ltd. All rights reserved.
//

#import <Realm/Realm.h>
#import "Device.h"

@interface iSwitches : RLMObject
@property (strong, nonatomic) NSString *iSwitchId;
@property (strong, nonatomic) NSString *iSwitchName;
@property (strong, nonatomic) NSString *iSwitchTopic;
@property (strong, nonatomic) NSString *iSwitchSecurity;
@property (readonly) RLMLinkingObjects<Device *> *devices;
@end
