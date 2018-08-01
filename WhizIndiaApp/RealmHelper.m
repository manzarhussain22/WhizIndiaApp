//
//  RealmHelper.m
//  AutoIHomes
//
//  Created by Manzar_Hussain on 26/07/18.
//  Copyright © 2018 AutoI Innovations Pvt. Ltd. All rights reserved.
//

#import "RealmHelper.h"
#import "UserProfile.h"
#import "iSwitches.h"

@implementation RealmHelper
@synthesize defaultRealm;

static RealmHelper *singletonObject = nil;

+ (id)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonObject = [[self alloc] init];
    });
    return singletonObject;
}

- (id)init
{
    if (! self) {
        self = [super init];
    }
    
    defaultRealm = [RLMRealm defaultRealm];
    NSLog(@"Realm File URL-- %@",[RLMRealmConfiguration defaultConfiguration].fileURL);
    return self;
}

#pragma mark - Save User Profile data to Realm database
-(void)persistToProfileRealm:(NSDictionary *)profileDict {
    [defaultRealm beginWriteTransaction];
    UserProfile *profileObj = [[UserProfile alloc] init];
    profileObj.emailAddress = [profileDict valueForKey:Profile_Email_Key];
    profileObj.userName = [profileDict valueForKey:Profile_User_Name];
    [defaultRealm addObject:profileObj];
    [defaultRealm commitWriteTransaction];
}
#pragma mark - Save iSwitches data to Realm database
-(void)persistToiSwitchRealm:(NSDictionary *)iSwitchDict {
    [defaultRealm beginWriteTransaction];
    iSwitches *iSwitchObj = [[iSwitches alloc] init];
    iSwitchObj.iSwitchId = [iSwitchDict valueForKey:iSwitchIdKey];
    iSwitchObj.iSwitchName = [iSwitchDict valueForKey:iSwitchNameKey];
    iSwitchObj.iSwitchSecurity = [iSwitchDict valueForKey:iSwitchSecurityKey];
    iSwitchObj.iSwitchTopic = [iSwitchDict valueForKey:iSwitchTopicKey];
    [self persistToSwitchDevicesRealm:iSwitchDict[iSwitchDevicesKey] foriSwitch:iSwitchObj];
    [defaultRealm addObject:iSwitchObj];
    [defaultRealm commitWriteTransaction];
}
#pragma mark - Save iSwitch Devices data to Realm database
-(void)persistToSwitchDevicesRealm:(NSArray *)devicesArray foriSwitch:(iSwitches *)iswitch{
    for (NSDictionary *devicesDict in devicesArray) {
        Device *device = [[Device alloc] init];
        device.deviceId = devicesDict[iSwitchDeviceIdKey];
        device.deviceName = devicesDict[iSwitchDeviceNameKey];
        device.status = [devicesDict[iSwitchDeviceStatusKey] boolValue];
        device.iSwitch = iswitch;
        [defaultRealm addObject:device];
    }
}

#pragma mark - Fetch iSwitches from Realm database

-(RLMResults *)fetchiSwitches {
    RLMResults *iSwitchesResult = [iSwitches allObjects];
    iSwitchesResult = [iSwitchesResult sortedResultsUsingKeyPath:@"iSwitchId" ascending:YES];
    return iSwitchesResult;
}

#pragma mark - Fetch devices from Realm database

-(RLMResults *)fetchDevicesForiSwitchId:(NSString *)iSwitchId {
    RLMResults *devicesResult = [Device objectsWhere:@"iSwitch.iSwitchId == %@",iSwitchId];
    return devicesResult;
}

#pragma mark - Fetch User Profile from Realm database

-(RLMResults *)fetchUserProfile
{
    RLMResults *users = [UserProfile allObjects];
    return users;
}

#pragma mark - Clear Realm database on logout
-(void)clearRealmOnLogout {
    [defaultRealm beginWriteTransaction];
    [defaultRealm deleteAllObjects];
    [defaultRealm commitWriteTransaction];
}

//#pragma mark - Save User Profile data to Realm database
//-(void)performMigrationIfNeeded {
//    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
//    // Set the new schema version. This must be greater than the previously used
//    // version (if you've never set a schema version before, the version is 0).
//    config.schemaVersion = config.schemaVersion + 1;
//
//    // Set the block which will be called automatically when opening a Realm with a
//    // schema version lower than the one set above
//    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
//        // We haven’t migrated anything yet, so oldSchemaVersion == 0
//        if (oldSchemaVersion < 1) {
//            // Nothing to do!
//            // Realm will automatically detect new properties and removed properties
//            // And will update the schema on disk automatically
//        }
//    };
//
//    // Tell Realm to use this new configuration object for the default Realm
//    [RLMRealmConfiguration setDefaultConfiguration:config];
//}

@end
