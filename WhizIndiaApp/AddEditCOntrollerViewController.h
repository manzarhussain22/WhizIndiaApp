//
//  AddEditCOntrollerViewController.h
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 12/03/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHTextField.h"

@interface AddEditCOntrollerViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *addControllerView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *editCancelButton;
@property (weak, nonatomic) IBOutlet WHTextField *controllerNumberTxtField;
@property (weak, nonatomic) IBOutlet WHTextField *controllerNameTxtField;
@property (weak, nonatomic) IBOutlet WHTextField *controllerPasskeyTxtField;
@property (weak, nonatomic) IBOutlet UIButton *addControllerButton;
@property (weak, nonatomic) IBOutlet UIButton *updateControllerButton;

@property (weak, nonatomic) IBOutlet UIView *editControllerView;
@property (weak, nonatomic) IBOutlet UITableView *editControllerTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editViewHeightConstraint;
@end
