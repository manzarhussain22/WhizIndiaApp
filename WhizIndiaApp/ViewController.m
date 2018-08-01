//
//  ViewController.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 07/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "ViewController.h"
#import "WHTextField.h"
#import "LoginRequestModal.h"
#import "DataManager.h"
#import "RegisterViewController.h"
#import "LoginResponseModal.h"
#import "HomeMasterViewController.h"
#import <GoogleSignIn/GoogleSignIn.h>

@interface ViewController ()<UITextFieldDelegate, DataManagerDelegate,GIDSignInDelegate,GIDSignInUIDelegate>
{
    
    __weak IBOutlet NSLayoutConstraint *logoLabelTopConstraint;
    __weak IBOutlet NSLayoutConstraint *userNameTextFieldTopConstraint;
    __weak IBOutlet NSLayoutConstraint *passwordTextFieldTopConstraint;
    __weak IBOutlet NSLayoutConstraint *forgotPwdButtonTopConstraint;
    __weak IBOutlet NSLayoutConstraint *signUpButtonTopConstraint;
    __weak IBOutlet NSLayoutConstraint *loginButtonTopConstraint;
    __weak IBOutlet NSLayoutConstraint *orImageViewTopConstraint;
    __weak IBOutlet NSLayoutConstraint *socialLoginTopConstraint;

}
@property (weak, nonatomic) IBOutlet WHTextField *userNameField;
@property (weak, nonatomic) IBOutlet WHTextField *passwordField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _userNameField.delegate = self;
    _passwordField.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewtapped:)];
    [self.view addGestureRecognizer:tap];
    [self updateUXConstraints];
    
    
}

-(void)viewtapped:(UITapGestureRecognizer*)recognizer
{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[SharedClass sharedInstance] isRegisterStory]) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Registered Successfully",nil)];
        _userNameField.text = [[SharedClass sharedInstance] username];
        _passwordField.text = [[SharedClass sharedInstance] password];
        [self performSelector:@selector(loginButtonTapped:) withObject:nil afterDelay:1.9];
        [[SharedClass sharedInstance] setIsRegisterStory:NO];
    }
}

-(void)updateUXConstraints
{
    logoLabelTopConstraint.constant = (50./568.) * kScreenHeight;
    userNameTextFieldTopConstraint.constant = (50./568.) * kScreenHeight;
    passwordTextFieldTopConstraint.constant = (10./568.) * kScreenHeight;
    forgotPwdButtonTopConstraint.constant = (15./568.) * kScreenHeight;
    signUpButtonTopConstraint.constant = (10./568.) * kScreenHeight;
    loginButtonTopConstraint.constant = (20./568.) * kScreenHeight;
    orImageViewTopConstraint.constant = (20./568.) * kScreenHeight;
    socialLoginTopConstraint.constant = (20./568.) * kScreenHeight;
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(WHTextField *)textField
{
    [textField showBelowBorder];
    
}

-(void)textFieldDidEndEditing:(WHTextField *)textField
{
    [textField hideBelowBorder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _userNameField) {
        [_passwordField becomeFirstResponder];
    }
    else
    {
        [_passwordField resignFirstResponder];
    }
    return YES;
}

#pragma mark - UIActions
- (IBAction)loginButtonTapped:(id)sender {
    [self.view endEditing:YES];
    [[SharedClass sharedInstance] setIsSocialLogin:NO];
    if ([_userNameField.text isEqualToString:@""] || _userNameField.text==nil) {
        [[SharedClass sharedInstance] showAlertWithMessage:@"Username cannot be empty" onView:self];
        return;
    }
    else if ([_passwordField.text isEqualToString:@""] || _passwordField.text==nil)
    {
        [[SharedClass sharedInstance] showAlertWithMessage:@"Password cannot be empty" onView:self];
        return;
    }
    else
    {
        [[SharedClass sharedInstance] setUsername:_userNameField.text];
        [[SharedClass sharedInstance] setPassword:_passwordField.text];
    }
    [SVProgressHUD showWithStatus:@"Logging In"];
    DataManager *manager = [[DataManager alloc] init];
    manager.serviceKey = LoginService;
    manager.delegate = self;
    [manager startLoginServiceWithParams:[self prepareDictionaryForLogin]];
}

- (IBAction)signUpButtonTapped:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"registerViewController"];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:0 green:171./255. blue:157./255 alpha:1.]];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)showHomeScreen
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HomeMaster" bundle:nil];
    HomeMasterViewController *vc = (HomeMasterViewController *)[sb instantiateViewControllerWithIdentifier:@"homeMaster"];
    [self presentViewController:vc animated:YES completion:^{
        _userNameField.text = @"";
        _passwordField.text = @"";
    }];
}

- (IBAction)googleSignInButtonTapped:(id)sender {
    [self.view endEditing:YES];
    [[SharedClass sharedInstance] setIsSocialLogin:YES];
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].uiDelegate = self;
    [[GIDSignIn sharedInstance] signIn];
}

#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryForLogin {
    
    LoginRequestModal* loginObj = [[LoginRequestModal alloc] init];
    loginObj.email = self.userNameField.text;
    loginObj.password = self.passwordField.text;
    loginObj.isSocial = NO;
    return [loginObj createRequestDictionary];
    
}

- (NSMutableDictionary *) prepareDictionaryForSocialLoginWithEmail:(NSString *)email name:(NSString *)userName {
    LoginRequestModal* socialLoginObj = [[LoginRequestModal alloc] init];
    socialLoginObj.email = email;
    socialLoginObj.name = userName;
    socialLoginObj.isSocial = YES;
    return [socialLoginObj createRequestDictionary];
    
}

#pragma mark - DataManager Delegate

-(void)didFinishServiceWithSuccess {
     [SVProgressHUD dismiss];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:isUserLoggedIn];
    [self showHomeScreen];
}

-(void)didFinishServiceWithSuccess:(LoginResponseModal *)responseData
{
    [SVProgressHUD dismiss];
    [[SharedClass sharedInstance] setUserObj:responseData];
    if ([[[SharedClass sharedInstance] userObj].homeId isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:isUserLoggedIn];
        [self showHomeScreen];
    }
    else
    {
        [[SharedClass sharedInstance] showAlertWithMessage:@"Error in Login" onView:self];
        NSLog(@"Error in login %@",responseData.homeId);
    }
    
}

-(void)didFinishServiceWithFailure:(NSString *)errorMsg
{
    [SVProgressHUD dismiss];
    [[SharedClass sharedInstance] showAlertWithMessage:errorMsg onView:self];
}

#pragma mark - Google SignIn Delegates
- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController
{
    [self presentViewController:viewController animated:YES completion:nil];
}
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    if(!error)
    {
        [SVProgressHUD showWithStatus:@"Logging In"];
        DataManager *manager = [[DataManager alloc] init];
        manager.serviceKey = SocialLoginService;
        manager.delegate = self;
        [manager startLoginServiceWithParams:[self prepareDictionaryForSocialLoginWithEmail:user.profile.email name:user.profile.name]];
    }
    else
    {
        NSLog(@"Google Signin error %@",error.localizedDescription);
    }
}

@end
