//
//  SideMenuShowInteraction.h
//  AUTOIApp
//
//  Created by Manzar_Hussain on 13/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SideMenuShowInteraction : UIPercentDrivenInteractiveTransition

@property BOOL interactionInProgress;
@property BOOL shouldCompleteTransition;
@property (nonatomic, weak) UIViewController* viewController;
@property (nonatomic, weak) UIViewController* finalViewController;

- (void) wireToViewController:(UIViewController* )viewController withFinalViewController:(UIViewController *)finalViewController;
@end
