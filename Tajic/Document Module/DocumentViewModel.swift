//
//  DocumentViewModel.swift
//  unitree
//
//  Created by Mohit Kumar  on 17/03/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit
import Alamofire
class DocumentViewModel: NSObject {
    func uplaodDocuments(_ image:UIImage?,_ model:DocumentModel,block:@escaping(_ code:Int,_ dict:[DocumentModel])-> Swift.Void){
        uploadDoc(image, model, block: block)
    }
    
  private  func showAlertMsg(msg: String)
    {
        let alertView = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
    }
}

extension DocumentViewModel{
   private func uploadDoc(_ image:UIImage?,_ model:DocumentModel,block:@escaping(_ code:Int,_ dict:[DocumentModel])-> Swift.Void){
       guard StaticHelper.isInternetConnected else {
        showAlertMsg(msg:"Internet not connected" )
                  return
              }
    ActivityView.show()
        var  imgData    = Data()
        if let userImage = image {
               imgData = userImage.jpegData(compressionQuality: 0.25)!
        }
        
    let url = ServiceConst.BaseUrl  + "upload-documents.php"
    let userId = UserModel.getObject().id
    var tempDocArray = [DocumentModel]()
    
    let   parameters            = ["app_agent_id":UserModel.getObject().agentId,"document_type_id":model.documentTypeId,"user_id":userId] as [String:String?]
    
        Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "documents",fileName: "file.jpg", mimeType: "image/jpg")
            for (key, value) in parameters  {
                    if let keyValue = value  {
                     multipartFormData.append((keyValue).data(using: .utf8)!, withName: key)
                        print("Key:- \(key): value:\(keyValue)")
                    }
                    }
            },
        to:url)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                  
                })
                upload.responseJSON { response in
                    
                    if let json = response.result.value as? [String:Any]{
                        print("URL:- \(url) :- /n")
                        print("Params:- \(parameters) :- /n")
                        print("Response:- \(json) :- \n")
                        if let payload = json["Payload"] as? [String:Any],let docArray = payload["uploded_documents"] as? [[String:Any]],docArray.isEmpty == false  {
                            
                            docArray.forEach({ (dict) in
                                let docModel = DocumentModel(with: dict)
                                tempDocArray.append(docModel)
                            })
                         block(200,tempDocArray)
                        }
                        block(200,tempDocArray)
                    }
                    ActivityView.hide()
                }
            case .failure(let encodingError):
                print(encodingError)
              block(404,tempDocArray)
               ActivityView.hide()
            }
        }
    }
    }




extension DocumentViewModel{
     func uploadpdfDocs(_ fileData:Data,ext:String,_ model:DocumentModel,block:@escaping(_ code:Int,_ dict:[DocumentModel])-> Swift.Void){
    guard StaticHelper.isInternetConnected else {
     showAlertMsg(msg:"Internet not connected" )
               return
           }
 ActivityView.show()
    
     
 let url = ServiceConst.BaseUrl  + "upload-documents.php"
 let userId = UserModel.getObject().id
 var tempDocArray = [DocumentModel]()
 
 let   parameters            = ["app_agent_id":UserModel.getObject().agentId,"document_type_id":model.documentTypeId,"user_id":userId] as [String:String?]
 //"application/\(urlString)"
     Alamofire.upload(multipartFormData: { multipartFormData in
             multipartFormData.append(fileData, withName: "documents",fileName: "file.\(ext)", mimeType: "application/\(ext)")
         for (key, value) in parameters  {
                 if let keyValue = value  {
                  multipartFormData.append((keyValue).data(using: .utf8)!, withName: key)
                     print("Key:- \(key): value:\(keyValue)")
                 }
                 }
         },
     to:url)
     { (result) in
         switch result {
         case .success(let upload, _, _):
             
             upload.uploadProgress(closure: { (progress) in
                 print("Upload Progress: \(progress.fractionCompleted)")
               
             })
             upload.responseJSON { response in
                 
                 if let json = response.result.value as? [String:Any]{
                     print("URL:- \(url) :- /n")
                     print("Params:- \(parameters) :- /n")
                     print("Response:- \(json) :- \n")
                     if let payload = json["Payload"] as? [String:Any],let docArray = payload["uploded_documents"] as? [[String:Any]],docArray.isEmpty == false  {
                         
                         docArray.forEach({ (dict) in
                             let docModel = DocumentModel(with: dict)
                             tempDocArray.append(docModel)
                         })
                      block(200,tempDocArray)
                     }
                     block(200,tempDocArray)
                 }
                 ActivityView.hide()
             }
         case .failure(let encodingError):
             print(encodingError)
           block(404,tempDocArray)
            ActivityView.hide()
         }
     }
 }
 }
