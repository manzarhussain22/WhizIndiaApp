//
//  SharedClass.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "SharedClass.h"

@implementation SharedClass
@synthesize userObj, progressView, isRegisterStory, username, password, isSideMenuOpened, sharedMaskView;

static SharedClass *singletonObject = nil;

+ (id)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonObject = [[self alloc] init];
    });
    return singletonObject;
}

- (id)init
{
    if (! singletonObject) {
        
        singletonObject = [super init];
    }
    return singletonObject;
}

-(void)showProgressView:(UIViewController *)viewController
{
    
    progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.progressTintColor = [UIColor colorWithRed:187.0/255 green:160.0/255 blue:209.0/255 alpha:1.0];
    [[progressView layer]setFrame:CGRectMake(20, 50, 200, 200)];
    [[progressView layer]setBorderColor:[UIColor redColor].CGColor];
    progressView.trackTintColor = [UIColor clearColor];
    [progressView setProgress:(float)(50/100) animated:YES];  ///15
    
    [[progressView layer]setCornerRadius:progressView.frame.size.width / 2];
    [[progressView layer]setBorderWidth:3];
    [[progressView layer]setMasksToBounds:TRUE];
    progressView.clipsToBounds = YES;
    
    [viewController.view addSubview:progressView];
}

-(void)dismissProgressView
{
    [progressView removeFromSuperview];
}

-(void)createSharedMaskView
{
    
}

@end
