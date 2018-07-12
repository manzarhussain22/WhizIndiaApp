//
//  SideMenuInteraction.h
//  AutoIHomes
//
//  Created by Manzar_Hussain on 11/07/18.
//  Copyright © 2018 AutoI Innovations Pvt. Ltd. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface SideMenuInteraction : UIPercentDrivenInteractiveTransition 

@property BOOL interactionInProgress;
@property BOOL shouldCompleteTransition;
@property (nonatomic, weak) UIViewController* viewController;

- (void) wireToViewController:(UIViewController* )viewController;

@end
