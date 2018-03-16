//
//  SideMenuInteraction.h
//  AUTOIApp
//
//  Created by Manzar_Hussain on 13/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SideMenuInteraction : UIPercentDrivenInteractiveTransition 

@property BOOL interactionInProgress;
@property BOOL shouldCompleteTransition;
@property (nonatomic, weak) UIViewController* viewController;

- (void) wireToViewController:(UIViewController* )viewController;

@end
