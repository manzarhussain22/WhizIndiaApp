//
//  AddEditCOntrollerViewController.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 12/03/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "AddEditCOntrollerViewController.h"
#import "EditControllerTableViewCell.h"
#import "DataManager.h"
#import "AddControllerRequestModal.h"
#import "AddControllerResponseModal.h"
#import "EditControllerRequestModal.h"
#import "EditControllerResponseModal.h"

@interface AddEditCOntrollerViewController ()<UITableViewDelegate, UITableViewDataSource,DataManagerDelegate,EditControllerCellDelegate>
{
    __weak IBOutlet NSLayoutConstraint *iSwitchPassKeyTxtFieldTopConstraint;
    __weak IBOutlet NSLayoutConstraint *iSwitchRoomNameTxtFieldTopConstraint;
    __weak IBOutlet NSLayoutConstraint *iSwitchFirstDeviceTxtFieldTopConstraint;
    __weak IBOutlet NSLayoutConstraint *iSwitchSecondDeviceTxtFieldTopConstraint;
    __weak IBOutlet NSLayoutConstraint *controllerNumberTxtFieldTopConstraint;
    
    __weak IBOutlet NSLayoutConstraint *addScrollViewBottomConstraint;
    __weak IBOutlet NSLayoutConstraint *addControllerButtonTopConstraint;
    __weak IBOutlet NSLayoutConstraint *editControllerTableViewTopConstraint;
    __weak IBOutlet NSLayoutConstraint *updateButtonTopConstraint;
    __weak IBOutlet NSLayoutConstraint *editCancelButtonTopConstraint;
    __weak IBOutlet NSLayoutConstraint *cancelButtonBottomConstraint;
    NSArray *deviceIDArr;
    NSMutableArray *deviceNameArr;
    NSString *controllerName;
    NSMutableDictionary *updateDeviceDetail;
    NSMutableDictionary *updateControllerDetail;
    WHTextField *activeField;
}


@end

@implementation AddEditCOntrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    updateDeviceDetail = [[NSMutableDictionary alloc] init];
    _iSwitchIdTxtField.delegate = _iSwitchPasskeyTxtField.delegate = _iSwitchRoomNameTxtField.delegate = _firstDeviceTxtField.delegate = _secondDeviceTxtField.delegate = self;
    [self setUpUIConstraint];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tap];
    
    if(_controllerID != nil && ![_controllerID isEqualToString:@""])
    {
        NSDictionary *controllerDescriptor = [[[SharedClass sharedInstance] userObj].userDict objectForKey:_controllerID];
        deviceIDArr = [[controllerDescriptor allKeys] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"" ascending:YES]]];
        deviceNameArr = [[NSMutableArray alloc] init];
        [deviceNameArr addObject:[[[SharedClass sharedInstance] userObj].controllers objectForKey:_controllerID]];
        for (NSString *key in deviceIDArr) {
            [deviceNameArr addObject:[controllerDescriptor objectForKey:key]];
        }
    }
    activeField = [[WHTextField alloc] init];
    _addControllerScrollView.scrollEnabled = NO;
    [self registerForKeyboardNotifications];
}

-(void)viewTapped:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
}

-(void)setUpUIConstraint
{
    controllerNumberTxtFieldTopConstraint.constant = (47./568.) * kScreenHeight;
    addControllerButtonTopConstraint.constant = (374./568.) * kScreenHeight;
    addScrollViewBottomConstraint.constant = (109./568.) * kScreenHeight;
    iSwitchPassKeyTxtFieldTopConstraint.constant = iSwitchRoomNameTxtFieldTopConstraint.constant = iSwitchFirstDeviceTxtFieldTopConstraint.constant = iSwitchSecondDeviceTxtFieldTopConstraint.constant = (30./568.) * kScreenHeight;
    _updateControllerButton.layer.cornerRadius = (15./568.) * kScreenHeight;
    editControllerTableViewTopConstraint.constant = updateButtonTopConstraint.constant = editCancelButtonTopConstraint.constant = cancelButtonBottomConstraint.constant = (10./568.) * kScreenHeight;
    cancelButtonBottomConstraint.constant = (17./568.) * kScreenHeight;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _editControllerView.alpha = 0.0;
    _addControllerView.alpha = 0.0;
    [self.editControllerTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGFloat editViewHeight = self.editControllerTableView.contentSize.height + (100./568.)*kScreenHeight;
    if (editViewHeight>kScreenHeight) {
        self.editViewHeightConstraint.constant = kScreenHeight - (100./568.) *kScreenHeight;
    }
    else
    {
        self.editViewHeightConstraint.constant = editViewHeight;
    }
    if (_editControllerView.isHidden) {
        _addControllerView.transform = CGAffineTransformScale(_addControllerView.transform, 0.3, 0.3);
        [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^
         {
             _addControllerView.transform = CGAffineTransformIdentity;
             _addControllerView.alpha = 1.;
         }
                         completion:nil];
    }
    else
    {
        _editControllerView.transform = CGAffineTransformScale(_editControllerView.transform, 0.3, 0.3);
        [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^
         {
             _editControllerView.transform = CGAffineTransformIdentity;
             _editControllerView.alpha = 1.;
         }
                         completion:nil];
    }
    _iSwitchIdTxtField.tag = _iSwitchPasskeyTxtField.tag = _iSwitchRoomNameTxtField.tag = _firstDeviceTxtField.tag = _secondDeviceTxtField.tag = 2;
    [_iSwitchIdTxtField hideBelowBorder];
    [_iSwitchPasskeyTxtField hideBelowBorder];
    [_iSwitchRoomNameTxtField hideBelowBorder];
    [_firstDeviceTxtField hideBelowBorder];
    [_secondDeviceTxtField hideBelowBorder];

}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _iSwitchIdTxtField.text = _iSwitchPasskeyTxtField.text = _iSwitchRoomNameTxtField.text = _firstDeviceTxtField.text = _secondDeviceTxtField.text =  @"";
}

-(void)textFieldDidBeginEditing:(WHTextField *)textField
{
    activeField = textField;
    [textField showBelowBorder];
}

-(void)textFieldDidEndEditing:(WHTextField *)textField
{
    [textField hideBelowBorder];
}

-(BOOL)textFieldShouldReturn:(WHTextField *)textField
{
    if (textField == _iSwitchIdTxtField) {
        [_iSwitchPasskeyTxtField becomeFirstResponder];
    }
    else if (textField == _iSwitchPasskeyTxtField)
    {
        [_iSwitchRoomNameTxtField becomeFirstResponder];
    }
    else if (textField == _iSwitchRoomNameTxtField)
    {
        [_firstDeviceTxtField becomeFirstResponder];
    }
    else if (textField == _firstDeviceTxtField)
    {
        [_secondDeviceTxtField becomeFirstResponder];
    }
    else if (textField == _secondDeviceTxtField)
    {
        [_secondDeviceTxtField resignFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return YES;
}

- (IBAction)addControllerButtonTapped:(id)sender {
    [self.view endEditing:YES];
    [SVProgressHUD showWithStatus:@"Adding...."];
    DataManager *manager = [[DataManager alloc] init];
    manager.serviceKey = AddControllerService;
    manager.delegate = self;
    [manager startAddControllerServiceWithParams:[self prepareDictionaryToAddController]];
}

- (IBAction)updateControllerButtonTapped:(id)sender {
    [self.view endEditing:YES];
    [SVProgressHUD showWithStatus:@"Updating...."];
    DataManager *manager = [[DataManager alloc] init];
    manager.serviceKey = EditControllerService;
    [manager startEditControllerServiceWithParams:[self prepareDictionaryToEditController]];
    manager.delegate = self;
}

#pragma mark - Edit Controller TableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return deviceNameArr.count - 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditControllerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:editControllerCellIdentifier];
    
    if (indexPath.section == 0) {
        [cell.editControllerTextField setPlaceholder:@"Controller Name"];
        cell.editControllerTextField.text = [deviceNameArr objectAtIndex:indexPath.row];
    }
    else{
        [cell.editControllerTextField setPlaceholder:[NSString stringWithFormat:@"Device %ld",(long)indexPath.row +1]];
        cell.editControllerTextField.text = [deviceNameArr objectAtIndex:indexPath.row + 1];
    }
    cell.cellIndex = indexPath;
    cell.delegate = self;
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return (8./568.) * kScreenHeight; // you can have your own choice, of course
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = [UIColor clearColor];
//    return headerView;
//}

#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryToAddController {
    
    AddControllerRequestModal *request = [[AddControllerRequestModal alloc] init];
    
    request.controllerId = self.iSwitchIdTxtField.text;
    request.controllerName = self.iSwitchRoomNameTxtField.text;
    request.passKey = self.iSwitchPasskeyTxtField.text;
    request.firstDevice = self.firstDeviceTxtField.text;
    request.secondDevice = self.secondDeviceTxtField.text;
    request.email = [[[SharedClass sharedInstance] profileDetails] valueForKey:@"email"];
    
    return [request createRequestDictionary];
}

- (NSMutableDictionary *) prepareDictionaryToEditController {
    
    EditControllerRequestModal *request = [[EditControllerRequestModal alloc] init];
    request.controllerDetail = updateControllerDetail;
    request.deviceDetail = updateDeviceDetail;
    return [request createRequestDictionary];
}

#pragma mark - DataManager Delegate

-(void)didFinishServiceWithSuccess:(AddControllerResponseModal *)responseData
{
    if ([[responseData.response valueForKey:@"status"] isEqualToString:Status_Success]) {
        if ([self.delegate respondsToSelector:@selector(addEditControllerSuccess)]) {
            [self.delegate addEditControllerSuccess];
        }
    }
    else
    {
        [SVProgressHUD dismiss];
        if ([self.delegate respondsToSelector:@selector(addEditControllerFailure:)]) {
            [self.delegate addEditControllerFailure:[responseData.response valueForKey:messageKey]];
        }
        NSLog(@"Error in adding");
    }
}
-(void)didFinishEditControllerServiceWithSuccess:(EditControllerResponseModal *)responseData
{
    if ([responseData.editStatus isEqualToString:@"1"]) {
        if ([self.delegate respondsToSelector:@selector(addEditControllerSuccess)]) {
            [self.delegate addEditControllerSuccess];
        }
    }
    else
    {
        [SVProgressHUD dismiss];
        if ([self.delegate respondsToSelector:@selector(addEditControllerFailure)]) {
           // [self.delegate addEditControllerFailure];
        }
        NSLog(@"Error in Editing");
    }
}

-(void)didFinishServiceWithFailure:(NSString *)errorMsg
{
    [SVProgressHUD dismiss];
    if ([self.delegate respondsToSelector:@selector(addEditControllerFailure)]) {
//        [self.delegate addEditControllerFailure];
    }
    NSLog(@"%@",errorMsg);
}

#pragma mark - EditControllerCellDelegate

-(void)textFieldEnteredValue:(NSString *)value forCellIndex:(NSIndexPath *)cellIndex
{
    updateControllerDetail = [[NSMutableDictionary alloc] init];
    [updateControllerDetail setValue:[[[SharedClass sharedInstance] userObj].controllers objectForKey:_controllerID] forKey:_controllerID];
    if (cellIndex.section == 0) {
        
        [updateControllerDetail setValue:value forKey:_controllerID];
    }
    else
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict = [[[[SharedClass sharedInstance] userObj].userDict objectForKey:_controllerID] mutableCopy];
        [dict setObject:value forKey:[deviceIDArr objectAtIndex:cellIndex.row]];
        updateDeviceDetail = dict;
    }
    
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
    if (activeField == _iSwitchIdTxtField || activeField == _iSwitchRoomNameTxtField || activeField == _iSwitchPasskeyTxtField) {
        return;
    }
    
    self.addControllerScrollView.scrollEnabled = YES;
    CGFloat controllerOffset = self.view.frame.size.height - self.addControllerView.frame.size.height;
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height - controllerOffset, 0.0);
    self.addControllerScrollView.contentInset = contentInsets;
    self.addControllerScrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.addControllerView.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [self.addControllerScrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
    self.addControllerScrollView.scrollEnabled = NO;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.addControllerScrollView.contentInset = contentInsets;
    self.addControllerScrollView.scrollIndicatorInsets = contentInsets;
}

@end
