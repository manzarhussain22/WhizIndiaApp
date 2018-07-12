//
//  MenuViewController.h
//  AutoIHomes
//
//  Created by Manzar_Hussain on 11/07/18.
//  Copyright © 2018 AutoI Innovations Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewDelegate <NSObject>

-(void)showDetailedControllerFor:(NSString *)controllerID;
-(void)dismissMenuView;

@end

@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) id<MenuViewDelegate> delegate;
@property(strong, nonatomic) NSString *controllerID;
@end
