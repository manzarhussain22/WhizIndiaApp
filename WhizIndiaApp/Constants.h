//
//  Constants.h
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 09/02/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

//Cells
#define MenuCellIdentifier @"menuCell"
#define ContentCellIdentifier @"contentCell"
#define editControllerCellIdentifier @"editControllerCell"

//Device Frame
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//Login/Register Service
#define LoginService @"http://www.whizindia.com/rest/login/authenticateUserWH"
#define RegisterService @"http://www.whizindia.com/rest/register/registerMemberWH"

//Login/Register Request Modal Keys
#define emailKey @"email"
#define passwordKey @"password"
#define usernameKey @"name"
#define phoneNumberKey @"phone"
#define modeKey @"mode"
#define DOBKey @"DOB"

//Login Response Modal Keys
#define controllersKey @"controllers"
#define homeIDKey @"homeId"

//Register Response Modal Keys
#define statusKey @"key"

#endif /* Constants_h */
