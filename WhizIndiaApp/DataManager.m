//
//  DataManager.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "DataManager.h"
#import "LoginResponseModal.h"
#import "RegisterResponseModal.h"
#import "AddControllerResponseModal.h"
#import "EditControllerResponseModal.h"

@implementation DataManager
@synthesize serviceKey, baseUrl, reachability, addControllerDetail;

- (id)init
{
    if (! self) {
        
        self = [super init];
    }
    baseUrl = [NSURL URLWithString:WebServiceURL];
    return self;
}

-(void)startLoginServiceWithParams:(NSMutableDictionary *)postData
{
    if ([self isInternetReachable]) {
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
        manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        manager.requestSerializer.timeoutInterval = 30;
        //    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 350)];
        
        [manager POST:self.serviceKey parameters:postData progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"Response:- %@",responseObject);
            
            if ([[[responseObject valueForKey:homeIDKey] valueForKey:homeIDKey] isEqualToString:Status_Success]) {
                [self prepareLoginResponseObjectForServiceKey:self.serviceKey withData:responseObject];
                if ([self.delegate respondsToSelector:@selector(didFinishServiceWithSuccess)]) {
                    [self.delegate didFinishServiceWithSuccess];
                }
            }
            else if ([[[responseObject valueForKey:homeIDKey] valueForKey:homeIDKey] isEqualToString:Status_Failure_999])
            {
                if ([self.delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
                    [self.delegate didFinishServiceWithFailure:@"Credential Combination is invalid"];
                }
            }
            else
            {
                if ([self.delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
                    [self.delegate didFinishServiceWithFailure:API_Failure_MSG];
                }
            }
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error :- %@",error);
            if ([self.delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
                [self.delegate didFinishServiceWithFailure:API_Failure_MSG];
            }
        }];
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
            [self.delegate didFinishServiceWithFailure:No_Connection_MSG];
        }
    }
    
}
-(void)startRegisterServiceWithParams:(NSMutableDictionary *)postData
{
    if ([self isInternetReachable]) {
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
        manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        manager.requestSerializer.timeoutInterval = 30;
        //    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 350)];
        
        [manager POST:self.serviceKey parameters:postData progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"Response:- %@",responseObject);
            if ([[responseObject valueForKey:statusKey] isEqualToString:Status_Success]) {
                if ([self.delegate respondsToSelector:@selector(didFinishServiceWithSuccess)]) {
                    [self.delegate didFinishServiceWithSuccess];
                }
            }
            else if ([[responseObject valueForKey:statusKey] isEqualToString:Status_Failure_999])
            {
                if ([self.delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
                    [self.delegate didFinishServiceWithFailure:@"User already registered. Log In now."];
                }
            }
            else
            {
                if ([self.delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
                    [self.delegate didFinishServiceWithFailure:API_Failure_MSG];
                }
            }
            
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error :- %@",error);
            if ([self.delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
                [self.delegate didFinishServiceWithFailure:API_Failure_MSG];
            }
        }];
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
            [self.delegate didFinishServiceWithFailure:No_Connection_MSG];
        }
    }
    
}

-(void)startAddControllerServiceWithParams:(NSMutableDictionary *)postData
{
    if ([self isInternetReachable]) {
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
        manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        manager.requestSerializer.timeoutInterval = 30;
        //    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 350)];
        
        [manager POST:self.serviceKey parameters:postData progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"Response:- %@",responseObject);
            if ([[[responseObject valueForKey:responseKey] valueForKey:@"status"] isEqualToString:Status_Success]) {
                [self prepareLoginResponseObjectForServiceKey:self.serviceKey withData:responseObject];
                if ([self.delegate respondsToSelector:@selector(didFinishServiceWithSuccess:)]) {
                    [self.delegate didFinishServiceWithSuccess];
                }
            }
            else if ([[[responseObject valueForKey:responseKey] valueForKey:@"status"] isEqualToString:Status_Failure_999])
            {
                if ([self.delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
                    [self.delegate didFinishServiceWithFailure:@"Controller already added."];
                }
            }
            else
            {
                if ([self.delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
                    [self.delegate didFinishServiceWithFailure:@"Invalid Id and passkey."];
                }
            }
    
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error :- %@",error);
            if ([self.delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
                [self.delegate didFinishServiceWithFailure:API_Failure_MSG];
            }
        }];
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
            [self.delegate didFinishServiceWithFailure:No_Connection_MSG];
        }
    }
    
}

-(void)startEditControllerServiceWithParams:(NSMutableDictionary *)postData
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer.timeoutInterval = 30;
    //    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 350)];
    
    [manager POST:self.serviceKey parameters:postData progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Response:- %@",responseObject);
        if ([self.delegate respondsToSelector:@selector(didFinishEditControllerServiceWithSuccess:)]) {
            [self.delegate didFinishEditControllerServiceWithSuccess:[self prepareResponseObjectForServiceKey:self.serviceKey withData:responseObject]];
        }
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error :- %@",error);
        if ([self.delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
            [self.delegate didFinishServiceWithFailure:@"An issue occured. Please try again later"];
        }
    }];
}

- (id) prepareResponseObjectForServiceKey:(NSString *) responseServiceKey withData:(id)responseObj
{
    if ([responseServiceKey isEqualToString:LoginService] || [responseServiceKey isEqualToString:SocialLoginService]) {
        LoginResponseModal *loginResponse = [[LoginResponseModal alloc] init];
        return loginResponse;
    }
    else if ([responseServiceKey isEqualToString:AddControllerService])
    {
        AddControllerResponseModal *addControllerResponse = [[AddControllerResponseModal alloc] init];
        addControllerResponse.iSwitchIDAndName = addControllerDetail;
        [addControllerResponse parseDataToRealmDatabaseFromResponse:responseObj];
        return nil;
    }
    else if ([responseServiceKey isEqualToString:EditControllerService])
    {
        EditControllerResponseModal *editControllerResponse = [[EditControllerResponseModal alloc] initWithDictionary:responseObj];
        return editControllerResponse;
    }
    return nil;
}

-(BOOL)isInternetReachable {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}

-(void) prepareLoginResponseObjectForServiceKey:(NSString *) responseServiceKey withData:(id)responseObj {
    if ([responseServiceKey isEqualToString:LoginService] || [responseServiceKey isEqualToString:SocialLoginService]) {
        LoginResponseModal *loginResponse = [[LoginResponseModal alloc] init];
        [loginResponse parseDataToRealmFrom:responseObj];
    }
    else if ([responseServiceKey isEqualToString:AddControllerService]) {
        AddControllerResponseModal *addControllerResponse = [[AddControllerResponseModal alloc] init];
        addControllerResponse.iSwitchIDAndName = addControllerDetail;
        [addControllerResponse parseDataToRealmDatabaseFromResponse:responseObj];
    }
}

@end
