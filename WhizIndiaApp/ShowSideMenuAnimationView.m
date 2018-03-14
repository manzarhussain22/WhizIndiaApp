//
//  ShowSideMenuAnimationView.m
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 13/02/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import "ShowSideMenuAnimationView.h"

@implementation ShowSideMenuAnimationView

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.4;
    
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView* containerView;
    UIViewController* toVC;
    
    CGRect initialFrame;
    
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (fromVC) {
        containerView = [transitionContext containerView];
        toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        initialFrame = [transitionContext initialFrameForViewController:fromVC];
    }
    else {
        return;
    }
    
    UIView* snapshot = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    
    UIView* maskView = [[UIView alloc] initWithFrame:CGRectMake(fromVC.view.frame.origin.x, fromVC.view.frame.origin.y + ((78./568.)*kScreenHeight), fromVC.view.frame.size.width + ((50./320.)*kScreenWidth), fromVC.view.frame.size.height - ((78./568.)*kScreenHeight))];
    maskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    
    [containerView addSubview:snapshot];
    [containerView addSubview:maskView];
    [containerView addSubview:toVC.view];
    
    maskView.hidden = NO;
    maskView.alpha = 0.0;
    
    toVC.view.frame = initialFrame;
    toVC.view.center = CGPointMake(toVC.view.center.x - toVC.view.frame.size.width, toVC.view.center.y);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations: ^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.8 animations:^ {
            maskView.alpha = 1.0;
        }];
        
        //        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.8 animations:^ {
        //            fromVC.view.center = CGPointMake(fromVC.view.center.x - toVC.view.frame.size.width + (toVC.view.frame.size.width*0.20), fromVC.view.center.y);
        //            snapshot.center = CGPointMake(snapshot.center.x - toVC.view.frame.size.width + (toVC.view.frame.size.width*0.20), snapshot.center.y);
        //        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^ {
            toVC.view.center = CGPointMake(toVC.view.center.x + toVC.view.frame.size.width, toVC.view.center.y);
        }];
        
        
    } completion: ^(BOOL finished){
        toVC.view.hidden = NO;
        [[SharedClass sharedInstance] setSharedMaskView:maskView];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
}


@end
