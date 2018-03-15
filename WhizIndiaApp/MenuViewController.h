//
//  MenuViewController.h
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 13/02/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
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
