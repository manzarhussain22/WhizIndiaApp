//
//  HomeSlaveViewController.h
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 08/03/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeSlaveViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString *controllerID;
@property (weak, nonatomic) IBOutlet UILabel *controllerTitle;

@end
