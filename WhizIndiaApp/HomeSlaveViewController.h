//
//  HomeSlaveViewController.h
//  AUTOIApp
//
//  Created by Manzar_Hussain on 08/03/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeSlaveViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString *controllerID;
@property (weak, nonatomic) IBOutlet UILabel *controllerTitle;
@property (strong, nonatomic)NSMutableDictionary *buttonStatus;

@end
