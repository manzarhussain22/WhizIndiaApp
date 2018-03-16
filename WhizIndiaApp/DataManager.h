//
//  DataManager.h
//  AUTOIApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@protocol DataManagerDelegate <NSObject>

-(void) didFinishServiceWithSuccess:(id)responseData;
-(void) didFinishServiceWithFailure:(NSString *)errorMsg;
@optional
-(void) didFinishEditControllerServiceWithSuccess:(id)responseData;

@end

@interface DataManager : NSObject

@property (strong, nonatomic) NSString *serviceKey;
@property (strong, nonatomic) id<DataManagerDelegate> delegate;

-(void)startLoginServiceWithParams:(NSMutableDictionary *)postData;
-(void)startRegisterServiceWithParams:(NSMutableDictionary *)postData;
-(void)startAddControllerServiceWithParams:(NSMutableDictionary *)postData;
-(void)startEditControllerServiceWithParams:(NSMutableDictionary *)postData;
@end
