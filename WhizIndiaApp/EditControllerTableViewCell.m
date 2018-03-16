//
//  EditControllerTableViewCell.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 13/03/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "EditControllerTableViewCell.h"

@implementation EditControllerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.editControllerTextField showBelowBorder];
    self.editControllerTextField.delegate = self;
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
    if ([self.delegate respondsToSelector:@selector(textFieldEnteredValue:forCellIndex:)])
    {
        [self.delegate textFieldEnteredValue:textField.text forCellIndex:_cellIndex];
    }
}

-(BOOL)textFieldShouldReturn:(WHTextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(textFieldEnteredValue:forCellIndex:)])
    {
        [self.delegate textFieldEnteredValue:textField.text forCellIndex:_cellIndex];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
