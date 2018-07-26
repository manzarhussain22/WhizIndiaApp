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
-(void)addEditControllerFailure:(NSString *)failureMsg;
@end


@interface AddEditCOntrollerViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) id<AddEditCOntrollerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *addControllerView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *editCancelButton;
@property (weak, nonatomic) IBOutlet WHTextField *iSwitchIdTxtField;
@property (weak, nonatomic) IBOutlet WHTextField *iSwitchPasskeyTxtField;
@property (weak, nonatomic) IBOutlet WHTextField *iSwitchRoomNameTxtField;
@property (weak, nonatomic) IBOutlet WHTextField *firstDeviceTxtField;
@property (weak, nonatomic) IBOutlet WHTextField *secondDeviceTxtField;
@property (weak, nonatomic) IBOutlet UIButton *addControllerButton;
@property (weak, nonatomic) IBOutlet UIButton *updateControllerButton;
@property (weak, nonatomic) IBOutlet UIScrollView *addControllerScrollView;

@property (weak, nonatomic) IBOutlet UIView *editControllerView;
@property (weak, nonatomic) IBOutlet UITableView *editControllerTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editViewHeightConstraint;
@property (strong, nonatomic) NSString *controllerID;
@end
