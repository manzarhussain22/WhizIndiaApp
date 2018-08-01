//
//  UserProfile.h
//  AutoIHomes
//
//  Created by Manzar_Hussain on 26/07/18.
//  Copyright © 2018 AutoI Innovations Pvt. Ltd. All rights reserved.
//

#import <Realm/Realm.h>

@interface UserProfile : RLMObject

@property (strong, nonatomic) NSString *emailAddress;
@property (strong, nonatomic) NSString *userName;

@end
