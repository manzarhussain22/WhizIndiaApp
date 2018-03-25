//
//  ContentTableViewCell.h
//  AUTOIApp
//
//  Created by Manzar_Hussain on 08/03/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContentTableViewCellDelegate<NSObject>

-(void)switchTapped:(BOOL)isOn forDeviceID:(NSString *)deviceID;

@end

@interface ContentTableViewCell : UITableViewCell

@property(strong, nonatomic)NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UISwitch *controllerSwitch;
@property (weak, nonatomic) IBOutlet UILabel *detailDescription;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentImageLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelLeadingConstraint;
@property(strong, nonatomic)NSString *deviceID;
@property (weak, nonatomic) id<ContentTableViewCellDelegate> delegate;
@end
