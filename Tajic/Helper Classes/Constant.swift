//
//  Constant.swift
//  Comm-Konnect
//
//  Created by Dex_Mac2 on 7/5/17.
//  Copyright © 2017 Dex_Mac2. All rights reserved.
//

import UIKit

//===========================================================
//MARK: - GoogleMap Const
//===========================================================
struct GoogleConst {
    static let MapAPIKey       = "AIzaSyBWbuTBxT1eGWCTNM1wftSD-MdV47IojYE"
    static let PlaceAPIKey     = "AIzaSyBq6MHxYI6SPACHAJjNxkxftzhm3cgxnfI"
    static let DirectionAPIKey = "AIzaSyAL3FFcZESvPE_bQAOHXc3ruIKHI6jtsCU"
    static let ClientId        = "690042780110-7ea5bp9g7fvk94sdn5fllaqhr71ir4l7.apps.googleusercontent.com"
     /*"305258711011-7cj7maktg5g49pvqvil08hjqrtev0ui3.apps.googleusercontent.com"*/
    
}
//===========================================================
//MARK: - Number Constant
//===========================================================
struct NumberConst {
    //Zoom for level
    static let DefaultZoom:CFloat       = 16.0
    static let NameLimit:Int            = 20
    static let PhoneNumberLimit:Int     = 10
    static let EmailLimit:Int           = 56
    static let PasswordHighLimit:Int    = 18
    static let ImageSelectionLimit:Int  = 4
}

struct codes {
    static let kDepoTypeId   = 2901;
    static let kSchoolTypeId = 2903;
    static let kRoleId       = 200;
}
//===========================================================
//MARK: - dialog Constant
//===========================================================
struct DailogConst {
    //Zoom for level
    static let EventStartTag            = 10
    static let EventEndTag              = 20
    static let EventStartTimeTag        = 30
    static let NameLimit:Int            = 20
    static let PhoneNumberLimit:Int     = 10
    static let EmailLimit:Int           = 56
    static let PasswordHighLimit:Int    = 18
    static let ImageSelectionLimit:Int  = 4
}

//===========================================================
//MARK: - Hockey App Const
//===========================================================
struct HockeyAppConst {
    static let appId = "919f4474b15443adafbc1cc8fa159e19"
}
//===========================================================
//MARK: - Localization Const
//===========================================================
struct LocalizationConst {
    static let LanguageKey = "LanguageKey"
}

//===========================================================
//MARK: - UserDefault Constant
//===========================================================
struct UDConst {
    static let DeviceToken              = "DeviceToken"
    static let UserAuthToken            = "UserAuthToken"
    static let User                     = "User"
    static let Notification             = "Notification"
    static let userId                   = "UserId"
    static let userLogin                = "UserLogin"
    static let UserModel                = "UserModel"
    static let InstituteUserModel       = "InstituteUserModel"
    static let AdminUserModel           = "AdminUserModel"
    static let CommonModel              =  "CommonModel"
    static let ConfigureModel           = "ConfigureModel"
    static let StudentModel             = "StudentModel"
    static let kUDBaseUrl               = "ServiceBaseUrl"
    static let kUDAuthorization         = "Authorization"
    static let kUDDeviceToken           = "DeviceToken"
    static let kUDUserID                = "UserID"
    static let kUDIsLoggedIn            = "IsLogin"
    static let kUDWalkThrough           = "WalkThrough"
    static let kUDHelpScreen            = "HelpScreen"
    static let kUDTimeFormat            = "TimeFormat"
    static let kUDPhoneNumber           = "SavePhone"
    static let kUDVerifyDate            = "SaveDate"
    static let kUDRouteCacheDate        = "RouteCacheDate"
    static let kUDRouteStopCacheDate    = "RouteStopCacheDate"
    static let kUDRouteLatLongCacheDate = "RouteLatLongCacheDate"
    static let userLoginType            = "userLoginType"
}
//===========================================================
//MARK: - NotificationKey
//===========================================================
struct NotifConst{
    static let RemoteNotification   = "RemoteNotification"
    static let kRemoteNotification  = "RemoteNotification"
    static let kUpdateKidNofication = "UpdateKidNofication"
}
//===========================================================
//MARK: - ServiceURLs
//===========================================================
struct ServiceConst{
    static let TimeOut       = 30.0
    static let Authorization = "Authorization"
  
   // Live URL >>>>> https://www.uniagents.com/apknew/rest/agents/unitree/
    
    // Live
 static let BaseUrl          = "https://www.uniagents.com/apknew/rest/agents/unitree/"
    
    // Staging
    
 //  static let BaseUrl     = "https://www.uniagents.com/apktest/rest/agents/unitree/"

    
}
struct StatusCode {
    static let Success      = 200
    static let Fail         = 0
    static let BedRequest   = 400
    static let Unauthorized = 401
    static let Conflict     = 409
}

struct  shortList {
    static let featuredSearch            = "featureSearch"
    static let featuredSearchDismiss     = "featureSearchDissmiss"
     
    static let featuredFilterApplied     = "featuredFilterApplied"
    static let featuredFilterClear       = "featuredFilterClear"
    static let perfectMatchFilterApplied = "perfectFilterApplied"
    static let perfectMatchFilterClear   = "perfectFilterClear"
     
    static let prefectSearch             = "prefectSearch"
    static let prefectSearchDismiss      = "prefectSearchDismiss"
}

struct  searchList {
    static let searchFilterApplied = "searchFilterApplied"
    static let searchFilterClear   = "searchFilterClear"
    static let searchResetFeatureFilter          = "searchResetFeatureFilter"
    static let searchPerfectFilterApplied = "searchPerfectFilterApplied"
    static let searchResetPerfectFilter   = "searchResetPerfectFilter"
}




//===========================================================
//MARK: - Alert Constants
//===========================================================
struct AlertMsg{
    static let InternectDisconnectError = "Sorry, no internet connectivity detected. Please reconnect and try again."
    static let logoutMessage            = "Are you sure you want to log out?"
    static let deleteMessage            = "Are you sure you want to delete?"
    static let VersionAlert             = "A new version of ez enRoute parent app is available on app store. Please update it now."
    static let UnauthorizedError        = "You have entered either invalid username or password. If you have forgotten your password, use the Reset Password link. If you want to register, please use Register Now link."
    static let RegistrationMsg          = "A link has been sent to the email address. Please click on the link and follow the instruction to register."
    static let  ResetPasswordMsg        = "Password has been changed successfully."
    
    static let VerificationError        = "Please enter correct verification code"
    static let TokenExpireError         = "Your session has expired. Please login again."
    static let TimeoutError             = "The request timed out."
    static let ApplicationError         = "You are not authorized to use this application. Please contact your school or customer support."
    static let TrackBusError            = "Currently there is no active route tracked."
    static let DefaultError             = "Please try again and if problem still persist contact the ez enRoute administrator."
    
    static let kWaitingAlert  = "Please wait..."
    static let kBusStartAlert = "Currently there is no active route tracked."
}


