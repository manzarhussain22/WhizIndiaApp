//
//  DataManager.m
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import "DataManager.h"
#import "LoginResponseModal.h"
#import "RegisterResponseModal.h"
#import "AddControllerResponseModal.h"
#import "EditControllerResponseModal.h"

@implementation DataManager
@synthesize serviceKey;

-(void)startLoginServiceWithParams:(NSMutableDictionary *)postData
{
    NSURL* url;
    url = [NSURL URLWithString:LoginService];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer.timeoutInterval = 30;
    //    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 350)];
    
    [manager POST:LoginService parameters:postData progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Response:- %@",responseObject);
        if ([self.delegate respondsToSelector:@selector(didFinishServiceWithSuccess:)]) {
            [self.delegate didFinishServiceWithSuccess:[self prepareResponseObjectForServiceKey:LoginService withData:responseObject]];
        }
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error :- %@",error);
        if ([self.delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
            [self.delegate didFinishServiceWithFailure:@"Credential Combination is invalid"];
        }
    }];
}
-(void)startRegisterServiceWithParams:(NSMutableDictionary *)postData
{
    NSURL* url;
    url = [NSURL URLWithString:RegisterService];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer.timeoutInterval = 30;
    //    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 350)];
    
    [manager POST:RegisterService parameters:postData progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Response:- %@",responseObject);
        if ([self.delegate respondsToSelector:@selector(didFinishServiceWithSuccess:)]) {
            [self.delegate didFinishServiceWithSuccess:[self prepareResponseObjectForServiceKey:RegisterService withData:responseObject]];
        }
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error :- %@",error);
        if ([self.delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
            [self.delegate didFinishServiceWithFailure:@"An issue occured. Please try again later"];
        }
    }];
}

-(void)startAddControllerServiceWithParams:(NSMutableDictionary *)postData
{
    NSURL* url;
    url = [NSURL URLWithString:AddControllerService];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer.timeoutInterval = 30;
    //    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 350)];
    
    [manager POST:AddControllerService parameters:postData progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Response:- %@",responseObject);
        if ([self.delegate respondsToSelector:@selector(didFinishServiceWithSuccess:)]) {
            [self.delegate didFinishServiceWithSuccess:[self prepareResponseObjectForServiceKey:AddControllerService withData:responseObject]];
        }
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error :- %@",error);
        if ([self.delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
            [self.delegate didFinishServiceWithFailure:@"An issue occured. Please try again later"];
        }
    }];
}

-(void)startEditControllerServiceWithParams:(NSMutableDictionary *)postData
{
    NSURL* url;
    url = [NSURL URLWithString:EditControllerService];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer.timeoutInterval = 30;
    //    manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 350)];
    
    [manager POST:EditControllerService parameters:postData progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Response:- %@",responseObject);
        if ([self.delegate respondsToSelector:@selector(didFinishEditControllerServiceWithSuccess:)]) {
            [self.delegate didFinishEditControllerServiceWithSuccess:[self prepareResponseObjectForServiceKey:EditControllerService withData:responseObject]];
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
    if ([responseServiceKey isEqualToString:LoginService]) {
        LoginResponseModal *loginResponse = [[LoginResponseModal alloc] initWithDictionary:responseObj];
        return loginResponse;
    }
    else if ([responseServiceKey isEqualToString:RegisterService])
    {
        RegisterResponseModal *registerResponse = [[RegisterResponseModal alloc] initWithDictionary:responseObj];
        return registerResponse;
    }
    else if ([responseServiceKey isEqualToString:AddControllerService])
    {
        AddControllerResponseModal *addControllerResponse = [[AddControllerResponseModal alloc] initWithDictionary:responseObj];
        return addControllerResponse;
    }
    else if ([responseServiceKey isEqualToString:EditControllerService])
    {
        EditControllerResponseModal *editControllerResponse = [[EditControllerResponseModal alloc] initWithDictionary:responseObj];
        return editControllerResponse;
    }
    return nil;
}

@end
