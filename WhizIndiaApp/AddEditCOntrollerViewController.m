//
//  AddEditCOntrollerViewController.m
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 12/03/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import "AddEditCOntrollerViewController.h"
#import "EditControllerTableViewCell.h"

@interface AddEditCOntrollerViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    
    __weak IBOutlet NSLayoutConstraint *controllerNumberTxtFieldTopConstraint;
    __weak IBOutlet NSLayoutConstraint *addControllerButtonTopConstraint;
    __weak IBOutlet NSLayoutConstraint *cancelButtonTopConstraint;
    __weak IBOutlet NSLayoutConstraint *editControllerTableViewTopConstraint;
    __weak IBOutlet NSLayoutConstraint *updateButtonTopConstraint;
    __weak IBOutlet NSLayoutConstraint *editCancelButtonTopConstraint;
    __weak IBOutlet NSLayoutConstraint *cancelButtonBottomConstraint;
    
}


@end

@implementation AddEditCOntrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _controllerNameTxtField.delegate = _controllerNumberTxtField.delegate = _controllerPasskeyTxtField.delegate = self;
    [self setUpUIConstraint];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tap];
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
    _controllerNameTxtField.tag = _controllerNumberTxtField.tag = _controllerPasskeyTxtField.tag = 2;
    [_controllerNameTxtField showBelowBorder];
    [_controllerNumberTxtField showBelowBorder];
    [_controllerPasskeyTxtField showBelowBorder];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGFloat editViewHeight = self.editControllerTableView.contentSize.height + (100./568.)*kScreenHeight;
    //CGRect frame = CGRectMake(addEditView.editControllerView.frame.origin.x, addEditView.editControllerView.frame.origin.y, addEditView.editControllerView.frame.size.width, editViewHeight);
    if (editViewHeight>kScreenHeight) {
        self.editViewHeightConstraint.constant = kScreenHeight - (100./568.) *kScreenHeight;
    }
    else
    {
        self.editViewHeightConstraint.constant = editViewHeight;
    }
    
    _editControllerView.alpha = 0.0;
    _addControllerView.alpha = 0.0;
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
}
- (IBAction)updateControllerButtonTapped:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - Edit Controller TableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditControllerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:editControllerCellIdentifier];
    cell.editControllerTextField.tag = indexPath.section;
    cell.editControllerTextField.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (8./568.) * kScreenHeight; // you can have your own choice, of course
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}


@end
