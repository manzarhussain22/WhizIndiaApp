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
    
    __weak IBOutlet NSLayoutConstraint *controllerNumberTxtFieldTopConstraint;
    __weak IBOutlet NSLayoutConstraint *addControllerButtonTopConstraint;
    __weak IBOutlet NSLayoutConstraint *cancelButtonTopConstraint;
    __weak IBOutlet NSLayoutConstraint *editControllerTableViewTopConstraint;
    __weak IBOutlet NSLayoutConstraint *updateButtonTopConstraint;
    __weak IBOutlet NSLayoutConstraint *editCancelButtonTopConstraint;
    __weak IBOutlet NSLayoutConstraint *cancelButtonBottomConstraint;
    NSArray *deviceIDArr;
    NSMutableArray *deviceNameArr;
    NSString *controllerName;
    NSMutableDictionary *updateDeviceDetail;
    NSMutableDictionary *updateControllerDetail;
}


@end

@implementation AddEditCOntrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    updateDeviceDetail = [[NSMutableDictionary alloc] init];
    _controllerNameTxtField.delegate = _controllerNumberTxtField.delegate = _controllerPasskeyTxtField.delegate = self;
    [self setUpUIConstraint];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tap];
    
    NSDictionary *controllerDescriptor = [[[SharedClass sharedInstance] userObj].userDict objectForKey:_controllerID];
    deviceIDArr = [[controllerDescriptor allKeys] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"" ascending:YES]]];
    deviceNameArr = [[NSMutableArray alloc] init];
    [deviceNameArr addObject:[[[SharedClass sharedInstance] userObj].controllers objectForKey:_controllerID]];
    for (NSString *key in deviceIDArr) {
        [deviceNameArr addObject:[controllerDescriptor objectForKey:key]];
    }
    
}

-(void)viewTapped:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
}

-(void)setUpUIConstraint
{
    controllerNumberTxtFieldTopConstraint.constant = (30./568.) * kScreenHeight; addControllerButtonTopConstraint.constant = (67./568.) * kScreenHeight;
    cancelButtonTopConstraint.constant = (6./568.) * kScreenHeight;
    _addControllerButton.layer.cornerRadius = (15./568.) * kScreenHeight;
    _updateControllerButton.layer.cornerRadius = (15./568.) * kScreenHeight;
    editControllerTableViewTopConstraint.constant = updateButtonTopConstraint.constant = editCancelButtonTopConstraint.constant = cancelButtonBottomConstraint.constant = (10./568.) * kScreenHeight;
    
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
    _controllerNameTxtField.tag = _controllerNumberTxtField.tag = _controllerPasskeyTxtField.tag = 2;
    [_controllerNameTxtField showBelowBorder];
    [_controllerNumberTxtField showBelowBorder];
    [_controllerPasskeyTxtField showBelowBorder];

}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _controllerNameTxtField.text = _controllerNumberTxtField.text = _controllerPasskeyTxtField.text = @"";
}

-(void)textFieldDidBeginEditing:(WHTextField *)textField
{
    textField.tag = 0;
    [textField showBelowBorder];
}

-(void)textFieldDidEndEditing:(WHTextField *)textField
{
    textField.tag = 2;
    [textField showBelowBorder];
}

-(BOOL)textFieldShouldReturn:(WHTextField *)textField
{
    if (textField == _controllerNumberTxtField) {
        [_controllerNameTxtField becomeFirstResponder];
    }
    else if (textField == _controllerNameTxtField)
    {
        [_controllerPasskeyTxtField becomeFirstResponder];
    }
    else if (textField == _controllerPasskeyTxtField)
    {
        [_controllerPasskeyTxtField resignFirstResponder];
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
    manager.delegate = self;
    [manager startAddControllerServiceWithParams:[self prepareDictionaryToAddController]];
}

- (IBAction)updateControllerButtonTapped:(id)sender {
    [self.view endEditing:YES];
    [SVProgressHUD showWithStatus:@"Updating...."];
    DataManager *manager = [[DataManager alloc] init];
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
    
    request.controllerId = self.controllerNumberTxtField.text;
    request.controllerName = self.controllerNameTxtField.text;
    request.passKey = self.controllerPasskeyTxtField.text;
    request.email = [[SharedClass sharedInstance] username];
    
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
    if (responseData.devices.count>0) {
        if ([self.delegate respondsToSelector:@selector(addEditControllerSuccess)]) {
            [self.delegate addEditControllerSuccess];
        }
    }
    else
    {
        NSLog(@"Error in Add Controller");
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
        NSLog(@"Error in Edit Controller");
    }
}

-(void)didFinishServiceWithFailure:(NSString *)errorMsg
{
    [SVProgressHUD dismiss];
    if ([self.delegate respondsToSelector:@selector(addEditControllerFailure)]) {
        [self.delegate addEditControllerFailure];
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

@end
