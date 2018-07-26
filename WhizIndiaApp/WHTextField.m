//
//  WHTextField.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 09/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "WHTextField.h"

@implementation WHTextField

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    border = [CALayer layer];
    CGFloat borderWidth = 2.;
    border.frame = CGRectMake(0, ((self.frame.size.height - borderWidth)/568.) * kScreenHeight, (self.frame.size.width/320.) * kScreenWidth, (self.frame.size.height/568.) * kScreenHeight);
    border.borderWidth = borderWidth;
    
    [self setTintColor:[UIColor whiteColor]];
    if (self.tag == 2) {
        self.textColor = [UIColor colorWithRed:0 green:164./255 blue:169./255 alpha:1.0];
        self.backgroundColor = [UIColor clearColor];
        border.borderColor = [UIColor colorWithRed:0 green:164./255 blue:169./255 alpha:1.0].CGColor;
        [self setTintColor:[UIColor colorWithRed:0 green:164./255 blue:169./255 alpha:1.0]];
        [self.layer addSublayer:border];
        self.layer.masksToBounds = YES;
    }
    else if (self.tag == 3)
    {
        border.borderColor = [UIColor blackColor].CGColor;
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithRed:241./255. green:64./255. blue:35./255. alpha:1];
        [self setTintColor:[UIColor whiteColor]];
    }
    else
    {
    border.borderColor = [UIColor lightTextColor].CGColor;
    self.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
        [self.layer addSublayer:border];
        self.layer.masksToBounds = YES;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification  object:nil];
    
    return self;
}
- (void) drawPlaceholderInRect:(CGRect)rect {
    UIColor *colour;
    if (self.tag == 2) {
        colour = [UIColor colorWithRed:0 green:164./255 blue:169./255 alpha:1.0];
    }
    else
    {
        colour= [UIColor whiteColor];
    }
    NSDictionary *attributes = @{NSForegroundColorAttributeName: colour, NSFontAttributeName: self.font};
    CGRect boundingRect = [self.placeholder boundingRectWithSize:rect.size options:0 attributes:attributes context:nil];
    [self.placeholder drawAtPoint:CGPointMake(0, (rect.size.height/2)-boundingRect.size.height/2) withAttributes:attributes];
    
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if(self.tag == 1)
    {
        return NO;
    }
    else
    {
        if (action == @selector(cut:))
        {
            return YES;
        }
        if (action == @selector(copy:))
        {
            return YES;
        }
        if (action == @selector(selectAll:))
        {
            return YES;
        }
        if (action == @selector(select:))
        {
            return YES;
        }
        if (action == @selector(paste:))
        {
            return YES;
        }
        return NO;
    }
}

-(void)showBelowBorder
{
    if (self.tag == 2 || self.tag == 3) {
        border.borderColor = [UIColor colorWithRed:0 green:164./255 blue:169./255 alpha:1.0].CGColor;
    }
    else
    {
        border.borderColor = [UIColor whiteColor].CGColor;
       
    }
     border.borderWidth = 4;
}
-(void)hideBelowBorder
{
    if (self.tag == 2 || self.tag == 3) {
        border.borderColor = [UIColor colorWithRed:0 green:235./255 blue:150./255 alpha:1.0].CGColor;
    }
    else
    {
    border.borderColor = [UIColor lightTextColor].CGColor;
    }
    border.borderWidth = 2.;
}

-(void)updateBorderWidth
{
    CGFloat borderWidth = 2;
    border.frame = CGRectMake(0, (self.frame.size.height - borderWidth), (self.frame.size.width/320.) * kScreenWidth, (self.frame.size.height/568.) * kScreenHeight);
}
- (void)orientationChanged:(NSNotification *)notification{
    [self updateBorderWidth];
}

@end
