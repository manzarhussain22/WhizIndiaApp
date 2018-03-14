//
//  ViewController.m
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 07/02/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import "ViewController.h"
#import "WHTextField.h"
#import "LoginRequestModal.h"
#import "DataManager.h"
#import "RegisterViewController.h"
#import "LoginResponseModal.h"
#import "HomeMasterViewController.h"

@interface ViewController ()<UITextFieldDelegate, DataManagerDelegate>
{
    
    __weak IBOutlet NSLayoutConstraint *logoLabelTopConstraint;

    __weak IBOutlet NSLayoutConstraint *loginRegisterButtonViewTopConstraint;
    __weak IBOutlet NSLayoutConstraint *textFieldViewTopConstraint;

    __weak IBOutlet NSLayoutConstraint *socialLoginViewTopConstraint;
    __weak IBOutlet UIButton *loginButton;
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
    }
}

-(void)updateUXConstraints
{
    logoLabelTopConstraint.constant = (20./568.) * kScreenHeight;
    loginRegisterButtonViewTopConstraint.constant = (50./568.) * kScreenHeight;
    textFieldViewTopConstraint.constant = (96./568.) * kScreenHeight;
    socialLoginViewTopConstraint.constant = (72./568.) * kScreenHeight;
    loginButton.layer.cornerRadius = (15./568.) * kScreenHeight;
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
    if ([_userNameField.text isEqualToString:@""] || _userNameField.text==nil) {
        [self showAlertWithMessage:@"Username cannot be empty"];
        return;
    }
    else if ([_passwordField.text isEqualToString:@""] || _passwordField.text==nil)
    {
       [self showAlertWithMessage:@"Password cannot be empty"];
        return;
    }
    [SVProgressHUD showWithStatus:@"Logging In"];
    DataManager *manager = [[DataManager alloc] init];
    manager.delegate = self;
    [manager startLoginServiceWithParams:[self prepareDictionaryForLogin]];
}

- (IBAction)signUpButtonTapped:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"registerViewController"];
    [self presentViewController:vc animated:YES completion:NULL];
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

#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryForLogin {
    
    LoginRequestModal* loginObj = [[LoginRequestModal alloc] init];
    loginObj.email = self.userNameField.text;
    loginObj.password = self.passwordField.text;
    
    return [loginObj createRequestDictionary];
    
}

#pragma mark - DataManager Delegate
-(void)didFinishServiceWithSuccess:(LoginResponseModal *)responseData
{
    [SVProgressHUD dismiss];
    [[SharedClass sharedInstance] setUserObj:responseData];
    if ([[[SharedClass sharedInstance] userObj].homeId isEqualToString:@"1"]) {
        [self showHomeScreen];
    }
    else
    {
        NSLog(@"Error in login %@",responseData.homeId);
    }
    
}

-(void)didFinishServiceWithFailure:(NSString *)errorMsg
{
    [SVProgressHUD dismiss];
}

-(void)showAlertWithMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error!!!" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
