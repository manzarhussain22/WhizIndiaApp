//
//  MQTTHelper.h
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 25/03/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQTTClient.h"
typedef void(^subscribedSuccess)(BOOL);
@protocol MQTTHelperDelegate<NSObject>

@optional
-(void)connectedSuccessfully;
-(void)connectionRefused:(NSError *)error;
-(void)connectionClosed;
-(void)connectionError:(NSError *)error;
-(void)protocolError:(NSError *)error;
-(void)messageDeliveredForTopic:(NSString *)topic;
-(void)newMessageRecived:(NSData *)data forTopic:(NSString *)topic;

@end


@interface MQTTHelper : NSObject<MQTTSessionDelegate>
{
    MQTTSession *session;
}

@property(strong, nonatomic)NSString *topic;
@property(weak, nonatomic) id<MQTTHelperDelegate> delegate;

-(void)initiateConnection;
-(void)subscribeToTopic:(NSString *)topic completionhandler:(subscribedSuccess)success;
-(void)publishMessage:(NSData *)message;

@end
