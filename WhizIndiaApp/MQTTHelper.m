//
//  MQTTHelper.m
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 25/03/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import "MQTTHelper.h"

@implementation MQTTHelper

-(void)initiateConnection
{
    MQTTCFSocketTransport *transport = [[MQTTCFSocketTransport alloc] init];
    transport.host = @"45.113.138.18";
    transport.port = 1883;
    
    session = [[MQTTSession alloc] init];
    session.transport = transport;
    
    session.delegate = self;
    [session connectAndWaitTimeout:30];
}

-(void)subscribeToTopic:(NSString *)topic completionhandler:(subscribedSuccess)success
{
    _topic = topic;
    [session subscribeToTopic:topic atLevel:2 subscribeHandler:^(NSError *error, NSArray<NSNumber *> *gQoss){
        if (error) {
            NSLog(@"Subscription failed %@", error.localizedDescription);
            success(NO);
        } else {
            NSLog(@"Subscription sucessfull! Granted Qos: %@", gQoss);
            success(YES);
        }
    }];
}

-(void)publishMessage:(NSData *)message
{
    [session publishAndWaitData:message
                        onTopic:_topic
                         retain:NO
                            qos:MQTTQosLevelAtLeastOnce];
}

#pragma mark - MQTTSession Delegates

- (void)connected:(MQTTSession *)session
{
    if ([self.delegate respondsToSelector:@selector(connectedSuccessfully)]) {
        [self.delegate connectedSuccessfully];
    }
}

- (void)connectionRefused:(MQTTSession *)session error:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(connectionRefused:)]) {
        [self.delegate connectionRefused:error];
    }
}

- (void)connectionClosed:(MQTTSession *)session
{
    if ([self.delegate respondsToSelector:@selector(connectionClosed)]) {
        [self.delegate connectionClosed];
    }
}

- (void)connectionError:(MQTTSession *)session error:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(connectionError:)]) {
        [self.delegate connectionError:error];
    }
}

- (void)protocolError:(MQTTSession *)session error:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(protocolError:)]) {
        [self.delegate protocolError:error];
    }
}

- (void)messageDelivered:(MQTTSession *)session
                   msgID:(UInt16)msgID
                   topic:(NSString *)topic
                    data:(NSData *)data
                     qos:(MQTTQosLevel)qos
              retainFlag:(BOOL)retainFlag
{
    if ([self.delegate respondsToSelector:@selector(messageDeliveredForTopic:)]) {
        [self.delegate messageDeliveredForTopic:topic];
    }
}

- (void)newMessage:(MQTTSession *)session
              data:(NSData *)data
           onTopic:(NSString *)topic
               qos:(MQTTQosLevel)qos
          retained:(BOOL)retained
               mid:(unsigned int)mid
{
    if ([self.delegate respondsToSelector:@selector(newMessageRecived:forTopic:)]) {
        [self.delegate newMessageRecived:data forTopic:topic];
    }
}

@end
