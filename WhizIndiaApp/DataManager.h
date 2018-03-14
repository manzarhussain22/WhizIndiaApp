//
//  DataManager.h
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@protocol DataManagerDelegate <NSObject>

-(void) didFinishServiceWithSuccess:(id)responseData;
-(void) didFinishServiceWithFailure:(NSString *)errorMsg;

@end

@interface DataManager : NSObject

@property (strong, nonatomic) NSString *serviceKey;
@property (strong, nonatomic) id<DataManagerDelegate> delegate;

-(void)startLoginServiceWithParams:(NSMutableDictionary *)postData;
-(void)startRegisterServiceWithParams:(NSMutableDictionary *)postData;

@end
