//
//  RegisterViewController.m
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 10/02/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import "RegisterViewController.h"
#import "WHTextField.h"
#import "DataManager.h"
#import "RegisterRequestModal.h"
#import "RegisterResponseModal.h"

@interface RegisterViewController ()<UITextFieldDelegate, DataManagerDelegate>
@property (weak, nonatomic) IBOutlet WHTextField *usernameField;
@property (weak, nonatomic) IBOutlet WHTextField *passwordField;
@property (weak, nonatomic) IBOutlet WHTextField *emailField;
@property (weak, nonatomic) IBOutlet WHTextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet WHTextField *DOBField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _usernameField.delegate = self;
    _passwordField.delegate = self;
    _emailField.delegate = self;
    _phoneNumberField.delegate = self;
    _DOBField.delegate = self;
    
    [self addDatePickerViewToTextField:_DOBField];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tap];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[SharedClass sharedInstance] setIsRegisterStory:YES];
}

-(void)viewTapped:(UITapGestureRecognizer *)tapped
{
    [self.view endEditing:YES];
}

#pragma mark - UIActions

- (IBAction)registerButtonTapped:(id)sender {
    DataManager *manager = [[DataManager alloc] init];
    manager.delegate = self;
    [manager startRegisterServiceWithParams:[self prepareDictionaryForRegister]];
    
}

- (IBAction)signInButtonTapped:(id)sender {
    [[SharedClass sharedInstance] setIsRegisterStory:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
}

-(BOOL)textFieldShouldReturn:(WHTextField *)textField
{
    if (textField == _usernameField) {
        [_passwordField becomeFirstResponder];
    }
    else if (textField == _passwordField)
    {
        [_emailField becomeFirstResponder];
    }
    else if (textField == _emailField)
    {
        [_phoneNumberField becomeFirstResponder];
    }
    else if (textField == _phoneNumberField)
    {
        [_DOBField becomeFirstResponder];
    }
    else if (textField == _DOBField)
    {
        [_DOBField resignFirstResponder];
    }
    return YES;
}



- (void) addDatePickerViewToTextField:(UITextField *)txtField {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.backgroundColor = [UIColor blackColor];
    [datePicker setValue:[UIColor whiteColor] forKey:@"textColor"];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setDate:[NSDate date]];
    
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleBlackTranslucent];
    [toolBar setBackgroundColor:[UIColor lightGrayColor]];
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.frame = CGRectMake(0, 0, 60, 33);
    
    customButton.showsTouchWhenHighlighted = YES;
    [customButton setTitle:NSLocalizedString(@"Done",nil) forState:UIControlStateNormal];
    [customButton.titleLabel setFont:[UIFont fontWithName:@"System-Bold" size:(12./568.)*kScreenHeight]];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 33)];
    [lbl setText:NSLocalizedString(@"Select Date", nil)];
    [lbl setTextColor:[UIColor whiteColor]];
    lbl.textAlignment = NSTextAlignmentCenter;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:lbl];
    UIBarButtonItem *barCustomButton =[[UIBarButtonItem alloc] initWithCustomView:customButton];
    UIBarButtonItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(0, 0, 60, 33);
        cancelButton.showsTouchWhenHighlighted = YES;
        [cancelButton setTitle:NSLocalizedString(@"Cancel",nil) forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:[UIFont fontWithName:@"GothamRounded-Bold" size:(12./568.)*kScreenHeight]];
        UIBarButtonItem *barCancelButton =[[UIBarButtonItem alloc] initWithCustomView:cancelButton];
        toolBar.items = [[NSArray alloc] initWithObjects:barCancelButton,flexibleSpace,item,flexibleSpace,barCustomButton,nil];
        
        [cancelButton addTarget:self action:@selector(childBirthDatePickerViewCancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [customButton addTarget:self action:@selector(childBirthDatePickerViewDoneButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [datePicker addTarget:self action:@selector(updateChildBirthDateTextField:) forControlEvents:UIControlEventValueChanged];
        
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:-18];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [datePicker setMaximumDate:maxDate];
    
    [comps setYear:1900];
    [comps setMonth:01];
    // NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    NSDate *minDate = [calendar dateFromComponents:comps];
    [datePicker setMinimumDate:minDate];
    
    
    NSDateComponents *birthComp = [[NSDateComponents alloc] init];
    [birthComp setYear:1980];
    [birthComp setMonth:01];
    NSDate *defaultDate = [calendar dateFromComponents:birthComp];
    
    [datePicker setDate:defaultDate];
    
        [txtField setInputView:datePicker];
        [txtField setInputAccessoryView:toolBar];
    
}
-(void)childBirthDatePickerViewDoneButtonTapped:(id)sender{
    
    UIDatePicker *picker = (UIDatePicker*)self.DOBField.inputView;
    
    self.DOBField.text = [self formatDate:picker.date];
    [self.DOBField resignFirstResponder];
    
}

-(void)childBirthDatePickerViewCancelButtonTapped:(id)sender{
    
    self.DOBField.text = @"";
    [self.DOBField resignFirstResponder];
    
}
-(void)updateChildBirthDateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.DOBField.inputView;
    self.DOBField.text = [self formatDate:picker.date];
    
}

// Formats the date chosen with the date picker.
- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryForRegister {
    
    RegisterRequestModal* registerObj = [[RegisterRequestModal alloc] init];
    registerObj.username = _usernameField.text;
    registerObj.password = _passwordField.text;
    registerObj.email = _emailField.text;
    registerObj.phoneNumber = _phoneNumberField.text;
    registerObj.dateOfBirth = _DOBField.text;
    
    return [registerObj createRequestDictionary];
    
}

#pragma mark - Datamanager Delegates
-(void)didFinishServiceWithSuccess:(RegisterResponseModal *)responseData
{
    if ([responseData.registerStatus isEqual:[NSNumber numberWithInt:1]] ) {
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

@end
