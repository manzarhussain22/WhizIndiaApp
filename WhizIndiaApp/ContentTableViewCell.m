//
//  ContentTableViewCell.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 08/03/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "ContentTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation ContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.layer setCornerRadius:(5.0f/568.)*kScreenHeight];
    // drop shadow
    [self.layer setShadowColor:[UIColor redColor].CGColor];
    [self.layer setShadowOpacity:0.8];
    [self.layer setShadowRadius:5.0];
    [self.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [_controllerSwitch setTintColor:[UIColor blackColor]];
    _contentImageLeadingConstraint.constant = (16./320.) * kScreenWidth;
    _contentLabelLeadingConstraint.constant = _contentImageLeadingConstraint.constant;
}
- (IBAction)deviceButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(switchTapped:forDeviceID:)]) {
        [self.delegate switchTapped:[sender isOn] forDeviceID:_deviceID];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
