//
//  RealmHelper.h
//  AutoIHomes
//
//  Created by Manzar_Hussain on 26/07/18.
//  Copyright © 2018 AutoI Innovations Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>



@interface RealmHelper : NSObject
+ sharedInstance;
@property (strong, nonatomic) RLMRealm *defaultRealm;

-(void)persistToProfileRealm:(NSDictionary *)profileDict;
-(void)persistToiSwitchRealm:(NSDictionary *)iSwitchDict;
-(RLMResults *)fetchiSwitches;
-(RLMResults *)fetchDevicesForiSwitchId:(NSString *)iSwitch;
-(void)clearRealmOnLogout;
-(void)performMigrationIfNeeded;
-(RLMResults *)fetchUserProfile;
@end
