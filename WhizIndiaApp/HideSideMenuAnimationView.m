//
//  HideSideMenuAnimationView.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 13/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "HideSideMenuAnimationView.h"

@implementation HideSideMenuAnimationView

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.4;
    
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    [[SharedClass sharedInstance] setIsSideMenuOpened:YES];
    
    UIView* containerView;
    UIViewController* toVC;
    
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (fromVC) {
        containerView = [transitionContext containerView];
        toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    }
    else {
        return;
    }
    
    UIView* snapshot = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    
//    UIView* maskView = [[SharedClass sharedInstance] sharedMaskView];
    
    [containerView addSubview:toVC.view];
//    [containerView addSubview:maskView];
    [containerView addSubview:snapshot];
    
    
    fromVC.view.hidden = YES;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations: ^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.7 animations:^ {
//            maskView.alpha = 0.0;
        }];
        
        //        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.8 animations:^ {
        //            toVC.view.center = CGPointMake(toVC.view.center.x + snapshot.frame.size.width - (snapshot.frame.size.width*0.20), toVC.view.center.y);
        //        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^ {
            snapshot.center = CGPointMake(snapshot.center.x - snapshot.frame.size.width, snapshot.center.y);
        }];
        
    } completion: ^(BOOL finished){
        
        fromVC.view.hidden = NO;
        [snapshot removeFromSuperview];
        [containerView bringSubviewToFront:fromVC.view];
        //        [maskView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [[SharedClass sharedInstance] setIsSideMenuOpened:NO];
        
    }];
    
    
}

@end
