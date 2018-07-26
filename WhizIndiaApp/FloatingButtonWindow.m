//
//  FloatingButtonWindow.m
//  AutoIHomes
//
//  Created by Manzar_Hussain on 23/07/18.
//  Copyright © 2018 AutoI Innovations Pvt. Ltd. All rights reserved.
//

#import "FloatingButtonWindow.h"

@implementation FloatingButtonWindow

-(id)init {
  self =  [super initWithFrame:[UIScreen mainScreen].bounds];
    self.backgroundColor = [UIColor clearColor];
    return self;

}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    UIButton *button = self.button;
    CGPoint buttonPoint = [button.superview convertPoint:button.center toView:button];
    return [button pointInside:buttonPoint withEvent:event];
}

@end
