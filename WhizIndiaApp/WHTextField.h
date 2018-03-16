//
//  WHTextField.h
//  AUTOIApp
//
//  Created by Manzar_Hussain on 09/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHTextField : UITextField
{
    CALayer *border;
}

-(void)showBelowBorder;
-(void)hideBelowBorder;
-(void)updateBorderWidth;
@end
