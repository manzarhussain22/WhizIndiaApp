//
//  ContentTableViewCell.m
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 08/03/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import "ContentTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation ContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.layer setCornerRadius:(20.0f/568.)*kScreenHeight];
    
    // border
    [self.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.layer setBorderWidth:1.0f];
    
    // drop shadow
    [self.layer setShadowColor:[UIColor redColor].CGColor];
    [self.layer setShadowOpacity:0.8];
    [self.layer setShadowRadius:5.0];
    [self.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [_controllerSwitch setTintColor:[UIColor blackColor]];
    _contentImageLeadingConstraint.constant = (16./320.) * kScreenWidth;
    _contentLabelLeadingConstraint.constant = _contentImageLeadingConstraint.constant;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
