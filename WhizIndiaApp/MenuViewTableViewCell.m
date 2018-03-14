//
//  MenuViewTableViewCell.m
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 12/02/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import "MenuViewTableViewCell.h"

@implementation MenuViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = (13./568.) * kScreenHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
