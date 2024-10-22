//
//  InstituteDetailsModel.swift
//  Unica New
//
//  Created by UNICA on 22/11/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit

class InstituteDetailsModel: NSObject {
    var id             = ""
    var name           = ""
    var about          = ""
    var why            = ""
    var mobile         = ""
    var address        = ""
    var founded        = ""
    var facebookUrl    = ""
    var linkedinUrl    = ""
    var twitterUrl     = ""
    var youtubeUrl     = ""
    var instagramUrl   = ""
    var establish      = ""
    var instituteType  = ""
    var estimateCost   = ""
    var image          = ""
    var videoThumb     = ""
    var isLiked        = false
    var location       = ""
    var videosUrlArray = [[String:Any]]()
    var videoArray     = [VideoModel]()
    var city           = ""
    
    
    var agentId       = ""
    var state         = ""
    
    var totalStudents  = 0
    
    var featuresArray = [FeaturesModel]()
    var financialArray = [FinancialModel]()
    var campusArray = [CampusListModel]()
    var marketingArray = [MarketingModel]()
    convenience init(with data:[String:Any]) {
        self.init()
        if let  id               = data["id"] as? String{
            self.id              = id
        }
           if let name           = data["name"] as? String{
           self.name             = name
           }
           if let about          = data["about"] as? String{
             self.about          = about
           }
           if let why            = data["why"] as? String{
              self.why           = why
           }
           if let mobile         = data["mobile"] as? String{
              self.mobile        = mobile
           }
           if let address        = data["address"] as? String{
              self.address       = address
           }
           if let founded        = data["founded"] as? String{
               self.founded      = founded
           }
           if let facebookUrl    = data["facebook_url"] as? String{
             self.facebookUrl    = facebookUrl
           }
           if let linkedinUrl    = data["linkedin_url"] as? String{
             self.linkedinUrl    = linkedinUrl
           }
           if let twitterUrl     = data["twitter_url"] as? String{
             self.twitterUrl     = twitterUrl
           }
           if let youtubeUrl     = data["youtube_url"] as? String{
              self.youtubeUrl    = youtubeUrl
           }
           if let instagramUrl   = data["instagram_url"] as? String {
            self.instagramUrl    = instagramUrl
           }
           if let establish      = data["establish"] as? String{
              self.establish     = establish
           }
           if let instituteType  = data["institutetype"] as? String{
              self.instituteType = instituteType
           }
           if let estimateCost   = data["estimatecost"] as? String{
              self.estimateCost  = estimateCost
           }
           if let image          = data["institute_image"] as? String{
              self.image         = image
           }
           if let videoThumb     = data["video_default_thumb_image"] as? String{
              self.videoThumb    = videoThumb
           }
           if let isLiked        = data["is_like"] as? Bool{
               self.isLiked      = isLiked
           }
           if let location       = data["location"] as? String{
               self.location     = location
           }
           if let videosUrlArray = data[""] as? [[String:Any]]{
            self.videosUrlArray  = videosUrlArray
        }
        if let videoArray        = data["videos"] as? [[String:Any]]{
            videoArray.forEach { (dict) in
                let model        = VideoModel(dict)
                self.videoArray.append(model)
            }
        }
        
        if let city = data["city"] as? String {
            self.city = city
        }
        
        if let agentId = data["app_agent_id"] as? String {
            self.agentId = agentId
        }
        
        if let state = data["state"] as? String {
            self.state = state
        }
       
        if let studentsCount = data["total_students"] as? String,  studentsCount.isNumeric  {
           self.totalStudents = Int(studentsCount)!
        }
 
        if let studentsCount = data["total_students"] as? Int {
            self.totalStudents = studentsCount
    }
       
        
        if let featuresArr = data["features"] as? [[String:Any]] {
            featuresArr.forEach { (dict) in
               let model =  FeaturesModel(dict)
                self.featuresArray.append(model)
            }
        }
        
        if let financialArr = data["financial"] as? [[String:Any]] {
                   financialArr.forEach { (dict) in
                    let model =  FinancialModel(dict)
                    self.financialArray.append(model)
                   }
               }
        
        
        
        
        if let campusArr = data["institute_campuses"] as? [[String:Any]] {
                  campusArr.forEach { (dict) in
                     let model =  CampusListModel(dict)
                    self.campusArray.append(model)
                  }
              }
              
              if let marketingArr = data["marketing_material"] as? [[String:Any]] {
                         marketingArr.forEach { (dict) in
                          let model =  MarketingModel(dict)
                            self.marketingArray.append(model)
                         }
                     }
        
    }
}

class VideoModel: NSObject {
    var videoTitle                = ""
    var videoUrl                  = ""
    var videoDescription          = ""
    
    convenience init(_ data:[String:Any]) {
        self.init()
        if let videoTitle         = data["title"] as? String {
            self.videoTitle       = videoTitle
        }
        if let videoUrl           = data["videos_url"] as? String{
            self.videoUrl         = videoUrl
        }
        if  let videoDescription  =  data["description"] as? String {
            self.videoDescription = videoDescription
        }
    }
}


class FeaturesModel: NSObject {
    var logo           = ""
    var title          = ""
    var value          = ""
    
    convenience init(_ data:[String:Any]) {
        self.init()
        if let logo    = data["logo"] as? String {
            self.logo  = logo
        }
        if let title   = data["title"] as? String{
            self.title = title
        }
        if  let value  =  data["value"] as? String {
            self.value = value
        }
    }
}

class FinancialModel: NSObject {
    var title          = ""
    var value          = ""
    
    convenience init(_ data:[String:Any]) {
        self.init()
        if let title   = data["title"] as? String{
            self.title = title
        }
        if  let value  =  data["value"] as? String {
            self.value = value
        }
    }
}


class CampusListModel: NSObject {
    var title          = ""
    var desc          = ""
    
    convenience init(_ data:[String:Any]) {
        self.init()
        if let title   = data["name"] as? String{
            self.title = title
        }
        if  let desc  =  data["description"] as? String {
            self.desc = desc
        }
    }
}



class MarketingModel: NSObject {
    var title          = ""
    var prospectus          = ""
    
    convenience init(_ data:[String:Any]) {
        self.init()
        if let title   = data["title"] as? String{
            self.title = title
        }
        if  let prospectus  =  data["prospectus"] as? String {
            self.prospectus = prospectus
        }
    }
}
