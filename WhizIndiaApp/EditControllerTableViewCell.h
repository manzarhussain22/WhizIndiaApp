//
//  EditControllerTableViewCell.h
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 13/03/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHTextField.h"

@protocol EditControllerCellDelegate<NSObject>

-(void)textFieldEnteredValue:(NSString *)value forCellIndex:(NSIndexPath *)cellIndex;

@end

@interface EditControllerTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet WHTextField *editControllerTextField;
@property NSIndexPath *cellIndex;
@property(weak, nonatomic) id<EditControllerCellDelegate> delegate;

@end
