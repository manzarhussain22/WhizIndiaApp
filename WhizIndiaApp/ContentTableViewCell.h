//
//  ContentTableViewCell.h
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 08/03/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *controllerSwitch;
@property (weak, nonatomic) IBOutlet UILabel *detailDescription;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentImageLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelLeadingConstraint;

@end
