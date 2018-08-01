//
//  Constants.h
//  AUTOIApp
//
//  Created by Manzar_Hussain on 09/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#ifndef Constants_h
#define Constants_h
#define IS_PROD_ENV 0

#define menuSection2Array [NSArray arrayWithObjects:@"Schedules",@"Metrics",@"Logout", nil]

#define isUserLoggedIn @"isUserLoggedIn"

//Cells
#define MenuCellIdentifier @"menuCell"
#define ContentCellIdentifier @"contentCell"
#define editControllerCellIdentifier @"editControllerCell"

//Device Frame
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#if (IS_PROD_ENV)
#define WebServiceURL @"http://www.autoiinnovations.com.com/rest"
#else
#define WebServiceURL @"http://autoiinnovations.com/Test/rest"
#endif

//Login/Register Service
#define LoginService @"login/authenticateUserWH"
#define SocialLoginService @"register/googleSingInWH"
#define RegisterService @"register/registerMemberWH"

//Login/Register Request Modal Keys
#define emailKey @"email"
#define passwordKey @"password"
#define usernameKey @"name"
#define phoneNumberKey @"phone"
#define modeKey @"mode"
#define DOBKey @"DOB"
#define ProfileKey @"profile"
#define SecurityKey @"security"
#define iSwitchStatusKey @"status"
#define TopicKey @"topic"

//Login Response Modal Keys
#define controllersKey @"controllers"
#define homeIDKey @"homeId"

//Register Response Modal Keys
#define statusKey @"key"

//Add Controller Service
#define AddControllerService @"controller/verifyController"
//Add Controller Service Keys
#define add_controllerIdKey @"controllerId"
#define add_controllerPassKey @"passKey"
#define add_controllerUsernameKey @"userName"
#define add_controllerNameKey @"controllerName"
#define add_firstDeviceNameKey @"device1"
#define add_secondDeviceNameKey @"device2"

#define EditControllerService @"controller/updateController"

//AddController Response Keys
#define devicesKey @"devices"
#define broadCastDetailsKey @"broadcastDetails"
#define deviceStatusKey @"deviceStatus"

//API success/failure code
#define Status_Failure_0 @"0"
#define Status_Success @"1"
#define Status_Failure_999 @"-999"
#define messageKey @"message"

#define responseKey @"response"

//Profile object keys
#define Profile_Email_Key @"email"
#define Profile_User_Name @"userName"

//iSwitch Realm Object Keys
#define iSwitchIdKey @"iSwitchId"
#define iSwitchNameKey @"iSwitchName"
#define iSwitchTopicKey @"iSwitchTopic"
#define iSwitchSecurityKey @"iSwitchSecurity"
#define iSwitchDevicesKey @"iSwitchDevices"
#define iSwitchDeviceIdKey @"iSwitchDeviceId"
#define iSwitchDeviceNameKey @"iSwitchDeviceName"
#define iSwitchDeviceStatusKey @"iSwitchDeviceStatus"

//No Internet Connection Message

#define No_Connection_MSG @"No Internet Connection. Please connect to Internet and try again"
#define API_Failure_MSG @"There seems to be some problem with our server. Please try later."
#endif /* Constants_h */
