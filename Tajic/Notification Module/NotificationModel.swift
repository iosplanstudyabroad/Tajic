//
//  NotificationModel.swift
//  CampusFrance
//
//  Created by UNICA on 03/07/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class NotificationModel: NSObject {
    var id                  = ""
    var title                  = ""
    var message             = ""
    var eventId             = ""
    var eventSlotScheduleId = ""
    var senderId            = ""
    var receiverId          = ""
    var senderType          = ""
    var type                = ""
    var status              = ""
    var addDate             = ""
    var updateDate          = ""
    var urlToRedirect       = ""
    var redirectType        = ""
    var partcipantType     = ""
    var notificationCategory = -1
    var notificationId     = ""
    var isUnread           = false
    var index              = -1
    convenience init(with data:[String:Any]) {
        self.init()
        if let title = data["title"] as? String {
            self.title = title
        }
        if let read = data["isUnread"] as? Bool {
            self.isUnread = read
        }
        
        
         if let read = data["isUnread"] as? String {
            if read == "false"{
                self.isUnread = false
            }else{
                self.isUnread = true
            }
                  
               }
        if let notificationId = data["notification_id"] as? String{
            self.notificationId = notificationId
        }
        
        if let notificationId = data["notification_id"] as? Int{
            self.notificationId =  String(describing:notificationId)
        }
        
        if let notificationCategory = data["notification_category"] as? Int {
            self.notificationCategory = notificationCategory
        }
       
        if let notificationCategory = data["notification_category"] as? String {
            if let count = Int(notificationCategory) {
               self.notificationCategory = count
            }
        }
        
        
        if let index = data["aap_redirect_page_id"] as? String,index.isEmpty == false  {
            if let ind = Int(index){
             self.index = ind
            }
               }
             
        
        if let index = data["aap_redirect_page_id"] as? Int  {
           self.index = index
    }
        
        
        if let id = data["id"] as? String {
           self.id = id
        }
       
        if let message = data["message"] as? String {
            self.message =  message
        }
        if let eventId = data["event_id"] as? String {
            self.eventId = eventId
        }
        if let eventSlotScheduleId = data["event_slot_schedule_id"] as? String {
            self.eventSlotScheduleId = eventSlotScheduleId
        }
        if let senderId = data["sender_id"] as? String {
            self.senderId = senderId
        }
        
        if let senderId = data["sender_id"] as? Int {
            self.senderId = String(describing:senderId)
            
        }
        
        if let receiverId = data["receiver_id"] as? String {
           self.receiverId = receiverId
        }
        if let senderType = data["sender_type"] as? String {
           self.senderType = senderType
        }
        
        if let type = data["type"] as? String {
            self.type = type
        }
        if let status = data["status"] as? String {
            self.status = status
        }
        if let addDate = data["add_date"] as? String {
            self.addDate = addDate
        }
      
        if let updateDate = data["update_date"] as? String {
          self.updateDate = updateDate
        }
        if let urlToRedirect = data["unica_redirection_url"] as? String {
            self.urlToRedirect = urlToRedirect
        }
        if let redirectType = data["redirect_type"] as? String {
            self.redirectType = redirectType
        }
        
        if let partcipantType =  data["sender_type"] as? String{
            self.partcipantType = partcipantType
        }
    }
}



/*
 {
 "id": "495",
 "message": "Send request to schedule a meeting",
 "event_id": "20",
 "event_slot_schedule_id": "0",
 "sender_id": "878",
 "receiver_id": "1",
 "sender_type": "I",
 "type": "3",

 }
 
 {
     address = "<null>";
     "event_id" = "";
     id = 2282;
     "image_url" = "https://www.uniagents.com/ga_images/notifications/default_image.png";
     isUnread = false;
     message = " Notification Received From Agent App ";
     "need_action" = "<null>";
     "sender_id" = 17;
     "sender_type" = C;
     title = "<null>";
     "unica_redirection_url" = "";
 }
 
 {
     address = "<null>";
     
     
     "image_url" = "https://www.uniagents.com/ga_images/notifications/default_image.png";
     isUnread = true;
     message = " Notification Received From Agent App ";
     "need_action" = "<null>";
     "sender_id" = 17;
     "sender_type" = C;
     title = "<null>";
     "unica_redirection_url" = "";
 }
 
 
 
 */
