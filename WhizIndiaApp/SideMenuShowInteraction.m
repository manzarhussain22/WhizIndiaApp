//
//  SideMenuShowInteraction.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 13/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "SideMenuShowInteraction.h"

@implementation SideMenuShowInteraction

@synthesize interactionInProgress,shouldCompleteTransition;

- (void) wireToViewController:(UIViewController* )viewController withFinalViewController:(UIViewController *)finalViewController {
    self.viewController = viewController;
    self.finalViewController = finalViewController;
    [self prepareGestureRecognizerInView:(viewController.view)];
}

- (void) prepareGestureRecognizerInView:(UIView* )view {
    
    UIPanGestureRecognizer* gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
    
}

- (void) handleGesture:(UIPanGestureRecognizer* ) gestureRecognizer{
    
    CGPoint translation = [gestureRecognizer translationInView:[gestureRecognizer.view superview]];
    CGFloat progress = (-1*translation.x / 250.);
    progress = fminf(fmaxf(progress, 0.0), 1.0);
    
    NSLog(@"progress %f",progress);
    
    switch (gestureRecognizer.state) {
            
        case UIGestureRecognizerStateBegan:
            NSLog(@"UIGestureRecognizerStateBegan");
            interactionInProgress = true;
            [self.viewController presentViewController:self.finalViewController animated:YES completion:nil];
            break;
            
        case UIGestureRecognizerStateChanged:
            NSLog(@"UIGestureRecognizerStateChanged");
            shouldCompleteTransition = (progress > 0.5)?YES:NO;
            [self updateInteractiveTransition:progress];
            break;
            
        case UIGestureRecognizerStateCancelled:
            NSLog(@"UIGestureRecognizerStateCancelled");
            interactionInProgress = false;
            [self cancelInteractiveTransition];
            break;
            
        case UIGestureRecognizerStateEnded:
            NSLog(@"UIGestureRecognizerStateEnded");
            interactionInProgress = false;
            
            if (!shouldCompleteTransition) {
                NSLog(@"cancelInteractiveTransition");
                [self cancelInteractiveTransition];
            } else {
                NSLog(@"finishInteractiveTransition");
                [self finishInteractiveTransition];
            }
            break;
            
        default:
            NSLog(@"Unsupported");
            break;
    }
}

@end
