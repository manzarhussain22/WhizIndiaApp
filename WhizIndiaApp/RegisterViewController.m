//
//  RegisterViewController.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "RegisterViewController.h"
#import "WHTextField.h"
#import "DataManager.h"
#import "RegisterRequestModal.h"
#import "RegisterResponseModal.h"

typedef void(^allFieldsVerified)(BOOL);

@interface RegisterViewController ()<UITextFieldDelegate, DataManagerDelegate>
{
    BOOL isUsernameVerified;
    BOOL isPasswordVerified;
    BOOL isEmailIDVerified;
    BOOL isPhoneVerified;
    WHTextField *activeField;
    __weak IBOutlet NSLayoutConstraint *brandLogoTopConstraint;
    __weak IBOutlet NSLayoutConstraint *textFieldViewTopConstraint;
    __weak IBOutlet NSLayoutConstraint *registerButtonTopConstraint;
}
@property (weak, nonatomic) IBOutlet WHTextField *passwordField;
@property (weak, nonatomic) IBOutlet WHTextField *emailField;
@property (weak, nonatomic) IBOutlet WHTextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet WHTextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *alreadyHaveAccountButton;
@property (weak, nonatomic) IBOutlet UIScrollView *registerScrollView;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _passwordField.delegate = self;
    _emailField.delegate = self;
    _phoneNumberField.delegate = self;
    _nameField.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tap];
    _alreadyHaveAccountButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _alreadyHaveAccountButton.titleLabel.numberOfLines = 2;
    _alreadyHaveAccountButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_alreadyHaveAccountButton setTitle:@"Already have an account?\nClick Here" forState:UIControlStateNormal];
    activeField = [[WHTextField alloc] init];
    _registerScrollView.scrollEnabled = NO;
    [self registerForKeyboardNotifications];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[SharedClass sharedInstance] setIsRegisterStory:YES];
}
-(void)updateUIConstraint {
    brandLogoTopConstraint.constant = (50./568.) * kScreenHeight;
    textFieldViewTopConstraint.constant = (50./568.) * kScreenHeight;
    registerButtonTopConstraint.constant = (25./568.) * kScreenHeight;
}
-(void)viewTapped:(UITapGestureRecognizer *)tapped
{
    [self.view endEditing:YES];
}

#pragma mark - UIActions

- (IBAction)registerButtonTapped:(id)sender {
    [self.view endEditing:YES];
    [self enableDisableRegisterButton:^(BOOL verified){
        if (verified) {
            DataManager *manager = [[DataManager alloc] init];
            manager.serviceKey = RegisterService;
            manager.delegate = self;
            [manager startRegisterServiceWithParams:[self prepareDictionaryForRegister]];
        }
        else
        {
            return;
        }
    }];
}

- (IBAction)signInButtonTapped:(id)sender {
    [[SharedClass sharedInstance] setIsRegisterStory:NO];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(WHTextField *)textField
{
    [textField showBelowBorder];

}

-(void)textFieldDidEndEditing:(WHTextField *)textField
{
    [textField hideBelowBorder];
    [[SharedClass sharedInstance] setUsername:_emailField.text];
    [[SharedClass sharedInstance] setPassword:_passwordField.text];
    if (_nameField.text !=nil && ![_nameField.text isEqualToString:@""]) {
        isUsernameVerified = YES;
    }
    else
    {
        isUsernameVerified = NO;
    }
    if (_passwordField.text !=nil && ![_passwordField.text isEqualToString:@""])
    {
      isPasswordVerified = YES;
    }
    else
    {
        isPasswordVerified = NO;
    }
    if (_emailField.text !=nil && ![_emailField.text isEqualToString:@""])
    {
        isEmailIDVerified = YES;
    }
    else
    {
        isEmailIDVerified = NO;
    }
    if (_phoneNumberField.text !=nil && ![_phoneNumberField.text isEqualToString:@""])
    {
        isPhoneVerified = YES;
    }
    else
    {
        isPhoneVerified = NO;
    }
}

-(BOOL)textFieldShouldReturn:(WHTextField *)textField
{
    if (textField == _emailField) {
        [_passwordField becomeFirstResponder];
    }
    else if (textField == _passwordField)
    {
        [_nameField becomeFirstResponder];
    }
    else if (textField == _nameField)
    {
        [_phoneNumberField becomeFirstResponder];
    }
    else if (textField == _phoneNumberField)
    {
        [textField resignFirstResponder];
    }

    return YES;
}

-(void)enableDisableRegisterButton:(allFieldsVerified)verified
{
    int totalFields = 4;
    int count = 0;
    if (isEmailIDVerified) {
        count++;
    }
    if (isPasswordVerified) {
        count++;
    }
    if (isUsernameVerified) {
        count++;
    }
    if (isPhoneVerified) {
        count++;
    }
    if (count == totalFields) {
        verified(YES);
    }
    else
    {
        verified(NO);
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Error!!!"
                                     message:@"All fields are mandatory"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:nil];
        
        //Add your buttons to alert controller
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryForRegister {
    
    RegisterRequestModal* registerObj = [[RegisterRequestModal alloc] init];
    registerObj.username = _nameField.text;
    registerObj.password = _passwordField.text;
    registerObj.email = _emailField.text;
    registerObj.phoneNumber = _phoneNumberField.text;
    return [registerObj createRequestDictionary];
}

#pragma mark - Datamanager Delegates
-(void)didFinishServiceWithSuccess:(RegisterResponseModal *)responseData
{
    if ([responseData.registerStatus isEqualToString:@"1"] ) {
        if (self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Failed"
                                     message:@"An issue occured. Please try again"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:nil];
        
        //Add your buttons to alert controller
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)didFinishServiceWithFailure:(NSString *)errorMsg
{
    [[SharedClass sharedInstance] dismissProgressView];
}

#pragma mark - Form scroll for Keyboard Show/Hide
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    self.registerScrollView.scrollEnabled = YES;
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.registerScrollView.contentInset = contentInsets;
    self.registerScrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [self.registerScrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
    self.registerScrollView.scrollEnabled = NO;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.registerScrollView.contentInset = contentInsets;
    self.registerScrollView.scrollIndicatorInsets = contentInsets;
}

@end
