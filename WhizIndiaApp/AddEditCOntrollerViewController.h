//
//  AddEditCOntrollerViewController.h
//  AUTOIApp
//
//  Created by Manzar_Hussain on 12/03/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHTextField.h"

@protocol AddEditCOntrollerDelegate<NSObject>

-(void)addEditControllerSuccess;
-(void)addEditControllerFailure;
@end


@interface AddEditCOntrollerViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet id<AddEditCOntrollerDelegate> delegate;
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
@property (strong, nonatomic) NSString *controllerID;
@end
