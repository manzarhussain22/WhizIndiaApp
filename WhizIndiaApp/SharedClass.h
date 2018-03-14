//
//  SharedClass.h
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LoginResponseModal.h"

@interface SharedClass : NSObject

+ sharedInstance;


@property (strong, nonatomic) LoginResponseModal *userObj;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) UIView* sharedMaskView;
@property BOOL isRegisterStory;
@property BOOL isSideMenuOpened;
-(void)showProgressView:(UIViewController *)viewController;
-(void)dismissProgressView;
@end
