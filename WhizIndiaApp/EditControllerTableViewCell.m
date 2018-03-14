//
//  EditControllerTableViewCell.m
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 13/03/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import "EditControllerTableViewCell.h"

@implementation EditControllerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.editControllerTextField showBelowBorder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
