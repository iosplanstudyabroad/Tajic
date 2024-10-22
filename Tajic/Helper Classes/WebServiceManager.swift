//
//  WebServiceManager.swift
//  dexschoolparent
//
//  Created by Dex_Mac2 on 5/4/17.
//  Copyright © 2017 Dex_Mac2. All rights reserved.

import UIKit
import Alamofire
import CoreLocation
import RxSwift
import RxAlamofire
import MBProgressHUD
class WebServiceManager: NSObject {
    static let instance       = WebServiceManager()
    typealias CompletionBlock = (Int,[String:Any]) -> Swift.Void
    private let disposeBag    = DisposeBag()
    private var manager: SessionManager!
    
    //===========================================================
    //MARK: - Initialization Methods
    //===========================================================
    private override init() {
        super.init()
        self.configureManager()
    }
    static var headers: [String: String]?{
        if let t = AppSession.authToken {
            return [ServiceConst.Authorization:t]
        }
        return nil
    }
    }

//***********************************************//
// MARK: Student Webservices
//***********************************************//
extension WebServiceManager {
    func getShortListedFeatureCourseDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
              let completeUrl = ServiceConst.BaseUrl+"crm-student-fav-courses.php"
              callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
          }
       
    
    func getFeaturInstuteDetails(params:[String:Any], withCompletionBlock block:@escaping CompletionBlock){
                   let completeUrl = ServiceConst.BaseUrl+"crm-institute-detail.php"
                   callPostRequestWithCompleteUrl(url: completeUrl, andData:params , withCompletionBlock: block)
               }
    
    
    func getFeatureCourseDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
                let completeUrl = ServiceConst.BaseUrl+"crm-course-detail.php"
                callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
            }
    
    func getinstituteCourseList(params:[String:Any], withCompletionBlock block:@escaping CompletionBlock){
                 let completeUrl = ServiceConst.BaseUrl+"institute-course.php"
                 callPostRequestWithCompleteUrl(url: completeUrl, andData:params , withCompletionBlock: block)
             }
    
       func getInstuteDetails(params:[String:Any], withCompletionBlock block:@escaping CompletionBlock){
              let completeUrl = ServiceConst.BaseUrl+"institute-detail.php"
              callPostRequestWithCompleteUrl(url: completeUrl, andData:params , withCompletionBlock: block)
          }
    
    
    ///crm-institute-courses.php
    
    func getFeatureinstituteCourseList(params:[String:Any], withCompletionBlock block:@escaping CompletionBlock){
                    let completeUrl = ServiceConst.BaseUrl+"crm-institute-courses.php"
                    callPostRequestWithCompleteUrl(url: completeUrl, andData:params , withCompletionBlock: block)
                }
    
    
    
    //***********************************************//
    // MARK: Student Login  1
    //***********************************************//
    func studentGetInquiryWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"enquiry-detail.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
  func  studentGetEventIistWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"latest-events.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
 func   studentGetCountryOfStudyWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"country-to-study.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    
    //***********************************************//
    // MARK: Change Password   31
    //***********************************************//
    func readNotificationWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"read-notification.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    

    func   getDocumentsListWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
           let completeUrl = ServiceConst.BaseUrl+"documents-type-list.php"
           callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
       }
       


    //***********************************************//
    // MARK: Student Search country based on keyword 2
    //***********************************************//
    func studentSearchCountryWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"search-country.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    func studentSearchInstitutionWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
           let completeUrl = ServiceConst.BaseUrl+"event-institutes-suggestion-list.php"
           callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
       }
    
    
    
    func getYearAndCourseType(params:[String:Any], withCompletion block:@escaping CompletionBlock){
              let completeUrl = ServiceConst.BaseUrl+"interested-year.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
          }
    
   
    
    func getjobsWithDetails(_ params:[String:Any], withCompletion block:@escaping CompletionBlock){
              let completeUrl = ServiceConst.BaseUrl+"job-abroad.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
          }
    
    
    
    
    
    //***********************************************//
    // MARK: Student Registration 3
    //***********************************************//
    func studentRegistrationWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"registration-student.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    //***********************************************//
    // MARK: Student Login  from Social 4
    //***********************************************//
    func studentSocialLoginStatusWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"login-social-student.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
   
    //***********************************************//
    // MARK:  Student Profile update 5
    //***********************************************//
    func studentProfileUpdateWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"update-profile.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    //***********************************************//
    // MARK: Student event List 6
    //***********************************************//
    func studentEventListWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"event-list.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    //***********************************************//
    // MARK: Student  Profile Image Update 7
    //***********************************************//
    func studentProfileImageUpdateWithDetails(image:UIImage,params:[String:String], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"update-profile-photo.php"
        callUploadImageRequestWithCompleteUrl(url: completeUrl, imageToUpload:image , andParams: params, withCompletionBlock: block)
    }
    
  
    
    //***********************************************//
    // MARK: Student  Reset Password 9
    //***********************************************//
    func studentResetPasswordWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"forgot_password.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Student Verify OTP 10
    //***********************************************//
    func studentVerifyOtpWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"otp_verify.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Student Resend OTP 11
    //***********************************************//
    func studentResendOtpWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"otp-resend.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Update Student Password 12
    //***********************************************//
    func studentUpdatePasswordWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"update-forgot-password.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Mini Porfile Student 13
    //***********************************************//
    func studentMiniProfileFetchWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-mini-profile-get.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Get highest level education 14
    //***********************************************//
    func studentGetHighestLevelWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"highest_level.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Get Grades 15
    //***********************************************//
    func studentGetGradesWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"grade.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Get Course Type 16
    //***********************************************//
    func studentFetchCousreTypeWithDetails(block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"course_type.php"
        callGetRequestWithCompleteUrl(url:completeUrl , withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Get valid exams Dtails 17
    //***********************************************//
    func studentFetchValidWithDetails(block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"valid-exams.php"
        callGetRequestWithCompleteUrl(url:completeUrl , withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: French Language Proficiency 18
    //***********************************************//
    func studentGetLanguageProficiencyWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"language-proficiency.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: French Language Proficiency 19
    //***********************************************//
    func studentSourceOfInformationWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"source-of-information.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Budget Preference 20
    //***********************************************//
    func studentGetBudgetPreferenceWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"budget-preference.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
   
    func updateDeviceToken(params:[String:Any], block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl +
        "update_device_token.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }

    //***********************************************//
    // MARK: Budget Preference 21
    //***********************************************//
    func studentUpdateMiniProfileWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-mini-profile.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Search course subcategory 22
    //***********************************************//
    func studentSearchCourseSubcategoryWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"subcategory_search.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: GetLeft And DashBoard Menu 23
    //***********************************************//
    func studentGetLeftAndDashBoardMenuWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-menus.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: GetLeft And DashBoard Menu 24
    //***********************************************//
    func studentGetQRCodeWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-unica-code.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
  
    //***********************************************//
    // MARK: Search Courses        25
    //***********************************************//
    func studentSearchCoursesWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"search-course.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    func referFriendContent(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"refer-friend-content.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    func applicationList(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-application-status.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Search Courses        25
    //***********************************************//
    func referFriend(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-refer-friends.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
  
    //***********************************************//
    // MARK: Sort Listed Courses        26
    //***********************************************//
    func studentSortListedCoursesWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-fav-courses.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Get banner for home       27
    //***********************************************//
    func studentGetBannersWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"dashboard-banners.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
   

    func getAppConfiguration(block:@escaping CompletionBlock){
        let completeUrl = AppDelegate.shared.base()
        callGetRequestWithCompleteUrl(url:completeUrl , withCompletionBlock: block)
    }
    //***********************************************//
    // MARK: Student Like Course      28
    //***********************************************//
    func studentLikeCourseWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-like-course.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Student Like Course      29
    //***********************************************//
    func studentGetCourseWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"course-detail.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Interested or Not Interested     30
    //***********************************************//
    func studentInterestedOrNotInterestedWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-interested-course-add.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Interested or Not Interested     31
    //***********************************************//
    func studentGetNotificationListWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        ///notification-list.php
        let completeUrl = ServiceConst.BaseUrl+"notification-messages.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    
    
    //***********************************************//
       // MARK: Interested or Not Interested     31
       //***********************************************//
       func studentGetReachUsListWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
           ///notification-list.php
           let completeUrl = ServiceConst.BaseUrl+"reach-us.php"
           callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
       }
    
    
   
    //***********************************************//
    // MARK: Event Direction Service      32
    //***********************************************//
    func studentGetEventDirectionsWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"direction.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    
    func getLatLongFromPlaceId(placeId:String,block:@escaping CompletionBlock){
          
          let url = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeId)&key=AIzaSyCy9I5GYw7ci3W9HtMKtenwaYlynXl0Els"
          
          callGetRequestWithCompleteUrl(url: url, withCompletionBlock: block)
          /**/
      }
    
    //***********************************************//
    // MARK: Get InterView  Details    33
    //***********************************************//
    func studentGetInterViewWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-interviews.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Park free slot       34
    //***********************************************//
    func studentParkFreeSlotWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"park-free-slot-students.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }

    //***********************************************//
    // MARK: Park free slot       35
    //***********************************************//
    func studentUnParkFreeSlotWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"unpark-free-slot-students.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Search Event InstituteIist       36
    //***********************************************//
    func studentSearchEventInstituteIistWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"search-event-institute-list.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    //***********************************************//
    // MARK: Send Request To Institute      37
    //***********************************************//
    func studentSendRequestToInstituteWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-send-request.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Get Time Slot for Send Request      38
    //***********************************************//
    func studentGetTimeSlotWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-time-slots.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    //***********************************************//
    // MARK: Cancel Request To Institute      39
    //***********************************************//
    func studentCancelRequestToInstituteWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-cancel-request.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: Event Institute Details      40
    //***********************************************//
    func studentGetEventInstituteWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"institute-detail.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    
    //***********************************************//
    // MARK: Institute Videos      41
    //***********************************************//
    func studentGetInstituteVideosWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"institute-videos.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    
    //***********************************************//
    // MARK:  Participant Course List      42
    //***********************************************//
    func studentGetPartcipiantCourseListWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"institute-course.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
      
    func registerForeventWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-event-register.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    
    //*******************************************************************//
    // MARK:  Events List  for request all recviced sent confirmed   43
    //*******************************************************************//
    func studentGetEventsInstitutesListWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"event-institute-list.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    
    
    //*******************************************************************//
    // MARK:  Read Notification  Service  44
    //*******************************************************************//
    func studentReadNotificationWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"read-notification.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
  func getSearchCourseFeatureListWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
      let completeUrl = ServiceConst.BaseUrl+"crm-match-courses.php"
      callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
  }
    
    
    
    func getSearchMatchedCoursesStatusWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
                let completeUrl = ServiceConst.BaseUrl+"student-matched-courses.php"
                callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
            }

    //*******************************************************************//
    // MARK: UnRead Notification Count  45
    //*******************************************************************//
    func studentUnReadNotificationCountWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"unread-notification-count.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    
    //*******************************************************************//
    // MARK: Accept Institute Request 46
    //*******************************************************************//
    func studentAcceptRequestWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-accept-request.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
   
    
    //*******************************************************************//
    // MARK: Event Regiteration Status  47
    //*******************************************************************//
    func studentEventRegiterationStatusWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"check-student-event-register.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
   
    //*******************************************************************//
    // MARK: Event Regiteration Status  48
    //*******************************************************************//
    func studentGetMatchedCoursesStatusWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-matched-courses.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
  
    func featureCourseListWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"crm-match-courses.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    

    
    func studentLikeFeatureCourseWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
           let completeUrl = ServiceConst.BaseUrl+"crm-course-like.php"
           callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
       }
    
    
    
    
    
    //*******************************************************************//
    // MARK: Event Regiteration Status  49
    //*******************************************************************//
    func studentGetIntersetedCoursesStatusWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-interested-courses.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    
    
    //*******************************************************************//
    // MARK: Event Regiteration Status  50
    //*******************************************************************//
    func studentGetProfileDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"get-profile.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
   
    
    //*******************************************************************//
    // MARK: Get Mini  51
    //*******************************************************************//
    func studentGetMiniProfileStatusWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"get-mini-profile.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //*******************************************************************//
    // MARK: Record Expression   52
    //*******************************************************************//
    func studentRecordExpressionWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"student-record-expression.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    
    
    //*******************************************************************//
    // MARK: Filter by event list  53
    //*******************************************************************//
    func filterByEventWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"scanned-student-event-filter.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
  
    
    //***********************************************//
    // MARK: Notification Action    54
    //***********************************************//
    func bannerResponseRequestWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"banner-responses.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    //***********************************************//
    // MARK: student Scan QR Code     55
    //***********************************************//
       func studentScanQRCodeWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
           let completeUrl = ServiceConst.BaseUrl+"institute-scan-code.php"
           callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
       }
    
    //***********************************************//
    // MARK: student Save Scanned QR Code     56
    //***********************************************//
    func studentSaveScanedInstituteWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
        let completeUrl = ServiceConst.BaseUrl+"institute-scan-code-save.php"
        callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
    }
    
    //***********************************************//
    // MARK: student Get Scaned Institute List    57
    //***********************************************//
       func studentGetScanedInstituteListWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
           let completeUrl = ServiceConst.BaseUrl+"institute-scan-list.php"
           callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
       }
    
    //***********************************************//
       // MARK: Get Filter Country List
       //***********************************************//
          func studentGetFilterCountryListWithDetails(params:[String:Any], withCompletion block:@escaping CompletionBlock){
              let completeUrl = ServiceConst.BaseUrl+"student-interested-countries.php"
              callPostRequestWithCompleteUrl(url: completeUrl, andData: params, withCompletionBlock: block)
          }
}

//***********************************************//
// MARK: Alamofire Calling Methods
//***********************************************//
extension WebServiceManager {
    
    //===========================================================
    //MARK: - Alamofire Methods
    //===========================================================
    /**
     *  Configure Alamofire Manger
     */
    private func configureManager() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = ServiceConst.TimeOut
        manager = Alamofire.SessionManager(configuration: configuration)
    }
    
    
    
    
    /**
     *  This function is use to get data from server using HTTP GET method.
     *  @param completeUrl BaseUrl with ServicePath.
     *  @param dictData    Params in json(NSDictionary).
     *  @param block       CompletionBlock.
     */
    private func callGetRequestWithCompleteUrl(url:String, andData data:[String:Any]? = nil,withCompletionBlock block:@escaping CompletionBlock) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        manager.rx.responseJSON(.get, url,parameters :data,encoding : URLEncoding.default,headers : WebServiceManager.headers)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {  (r, json) in
                switch r.statusCode {
                case 200 :
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    print("RequestUrl:\(url)\nRequestParams:\("")\nResponseCode:\(r.statusCode)\nResponseData:\(json))")
                    block(r.statusCode,json as! [String : Any])
                    
                case 201...502:
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    print("RequestUrl:\(url)\nRequestParams:\("")\nResponseCode:\(r.statusCode)\nResponseData:\(json))")
                    block(r.statusCode,json as! [String : Any])
                    break
                default :
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let statusCode = r.statusCode
                    print("RequestUrl:\(url)\nRequestParams:\("")\nResponseCode:\(r.statusCode)\nError:\(0)")
                    block(statusCode,["error":"Faliure"])
                    break
                }
            }, onError: { (error) in
                let mode  = error.localizedDescription
                print(mode)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                print("RequestUrl:\(url)\nRequestParams:\("")\nResponseCode:\(0)\nError:\(error)")
                block(0,["error":error.localizedDescription])
            })
            .disposed(by: disposeBag)
        
    }
    /**
     *  This function is use to get data from server using HTTP POST method.
     *
     *  @param completeUrl BaseUrl with ServicePath.
     *  @param dictData    Params in json(NSDictionary).
     *  @param block       CompletionBlock.
     */
    private func callPostRequestWithCompleteUrl(url:String, andData data:[String:Any],withCompletionBlock block:@escaping CompletionBlock) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        
        manager.rx.responseJSON(.post, url,parameters :data,encoding : URLEncoding.default,headers : WebServiceManager.headers)
            
            .debounce(.milliseconds(5), scheduler: MainScheduler.instance)
            .subscribe(onNext: {  (r, json) in
                switch r.statusCode {
                case 200 :
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    print("RequestUrl:\(url)\nRequestParams:\(data)\nResponseCode:\(r.statusCode)\nResponseData:\(json))")
                    block(r.statusCode,json as! [String : Any])
                    
                case 201...502:
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    print("RequestUrl:\(url)\nRequestParams:\(data)\nResponseCode:\(r.statusCode)\nResponseData:\(json))")
                    block(r.statusCode,json as! [String : Any])
                    break
                default :
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let statusCode = r.statusCode
                    print("RequestUrl:\(url)\nRequestParams:\(data)\nResponseCode:\(r.statusCode)\nError:\(0)")
                    block(statusCode,["error":"Faliure"])
                    break
                }
            }, onError: { (error) in
                let errorCode = error.localizedDescription
                
                print(errorCode)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                print("RequestUrl:\(url)\nRequestParams:\("")\nResponseCode:\(0)\nError:\(error)")
                block(0,["error":error.localizedDescription])
            })
            .disposed(by: disposeBag)
    }
    
    
    //***********************************************//
    // MARK: Private Service to access Scaned card data 9
    //***********************************************//
    private func cardCallPostRequestWithCompleteUrl(url:String, andData data:[String:Any],withCompletionBlock block:@escaping CompletionBlock) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        manager.rx.responseJSON(.post, url,parameters :data,encoding : JSONEncoding.default,headers : WebServiceManager.headers)
            .debounce(.milliseconds(0), scheduler: MainScheduler.instance)
            .subscribe(onNext: {  (r, json) in
                switch r.statusCode {
                case 200 :
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    print("RequestUrl:\(url)\nRequestParams:\(data)\nResponseCode:\(r.statusCode)\nResponseData:\(json))")
                    block(r.statusCode,json as! [String : Any])
                    
                case 201...502:
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    print("RequestUrl:\(url)\nRequestParams:\(data)\nResponseCode:\(r.statusCode)\nResponseData:\(json))")
                    block(r.statusCode,json as! [String : Any])
                    break
                default :
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let statusCode = r.statusCode
                    print("RequestUrl:\(url)\nRequestParams:\(data)\nResponseCode:\(r.statusCode)\nError:\(0)")
                    block(statusCode,["error":"Faliure"])
                    break
                }
            }, onError: { (error) in
                let errorCode = error.localizedDescription
                
                print(errorCode)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                print("RequestUrl:\(url)\nRequestParams:\("")\nResponseCode:\(0)\nError:\(error)")
                block(0,["error":error.localizedDescription])
            })
            .disposed(by: disposeBag)
    }
    
    
    
    
    func callUploadDocumentsRequestWithCompleteUrl(url:String, documentUrl:URL, andParams parameters:[String:String],withCompletionBlock block:@escaping CompletionBlock) {
        manager.upload(multipartFormData: { multipartFormData in
            
             let documentData = try! Data(contentsOf: documentUrl)
            
            if    let urlString = documentUrl.absoluteString.split(separator: ".").last {
                
                 multipartFormData.append(documentData, withName: "profile_cv", fileName: "MyCV.\(urlString)", mimeType: "application/\(urlString)")
            }

            for (key, value) in parameters {
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }}, to: url, method: .post, headers: nil,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.response {  response in
                            upload.uploadProgress { progress in
                                
                                print(progress.fractionCompleted)
                            }
                            
                            if let data = response.data {
                                do{
                                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]{
                                        block(response.response!.statusCode,json)
                                        print("RequestUrl:\(url)\nRequestParams:\(parameters)\nResponseCode:200 \n ResponseData:\(json))")
                                        let model = UserModel.getObject()
                                        if let data = json["Payload"] as? [String:Any],let url = data["profile_image"] as? String {
                                            model.profileImage = url
                                            model.profileCompleted = "Y"
                                            model.saved()
                                        }
                                        
                                    }
                                }catch{ print("erroMsg")
                                }
                            }
                           
                            
                            
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                    case .failure(let encodingError):
                        block(0,["error":encodingError.localizedDescription])
                    }
        })
    }
    
    
    
    
    /**
    * This function is use to Upload Image to server using multipart.
    **/
    func callUploadImageRequestWithCompleteUrl(url:String, imageToUpload:UIImage, andParams parameters:[String:String],withCompletionBlock block:@escaping CompletionBlock) {
        manager.upload(multipartFormData: { multipartFormData in
            if let imageData = imageToUpload.jpegData(compressionQuality: 1.0) {
                multipartFormData.append(imageData, withName: "profile_image", fileName: "profile_image.jpg", mimeType: "image/jpg")
            }
            
            for (key, value) in parameters {
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }}, to: url, method: .post, headers: nil,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.response {  response in
                            if let data = response.data {
                                do{
                                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]{
                                        block(response.response!.statusCode,json)
                                        print("RequestUrl:\(url)\nRequestParams:\(parameters)\nResponseCode:200 \n ResponseData:\(json))")
                                        let model = UserModel.getObject()
                                        if let data = json["Payload"] as? [String:Any],let url = data["profile_image"] as? String {
                                            model.profileImage = url
                                            model.profileCompleted = "Y"
                                            model.saved()
                                        }
                                       
                                    }
                                }catch{ print("erroMsg")
                                }
                            }
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                    case .failure(let encodingError):
                        block(0,["error":encodingError.localizedDescription])
                    }
        })
    }
    
    
    
    func callUploadBusinessCardRequestWithCompleteUrl(url:String, imageToUpload:UIImage, andParams parameters:[String:String],withCompletionBlock block:@escaping CompletionBlock) {
        manager.upload(multipartFormData: { multipartFormData in
            if let imageData = imageToUpload.jpegData(compressionQuality: 1.0) {
                multipartFormData.append(imageData, withName: "card_image", fileName: "card_image.jpg", mimeType: "image/jpg")
            }
            
            for (key, value) in parameters {
                multipartFormData.append((value.data(using: .utf8))!, withName: key)
            }}, to: url, method: .post, headers: nil,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.response {  response in
                            if let data = response.data {
                                do{
                                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]{
                                        block(response.response!.statusCode,json)
                                        print("RequestUrl:\(url)\nRequestParams:\(parameters)\nResponseCode:200 \n ResponseData:\(json))")
                                        let model = UserModel.getObject()
                                        if let data = json["Payload"] as? [String:Any],let url = data["profile_image"] as? String {
                                            model.profileImage = url
                                            model.profileCompleted = "Y"
                                            model.saved()
                                        }
                                       
                                    }
                                }catch{ print("erroMsg")
                                }
                            }
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                    case .failure(let encodingError):
                        block(0,["error":encodingError.localizedDescription])
                    }
        })
    }
    
    
    /**
     *  Cancel All Alamofire Operation.
     */
    func cancelAllOperations() {
        manager.rx.base.session.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
    }
}
