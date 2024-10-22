//
//  VideoCell.swift
//  Unica New
//
//  Created by UNICA on 25/11/19.
//  Copyright © 2019 UNICA. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView
class VideoCell: UITableViewCell {
@IBOutlet var card: UIView!
@IBOutlet var collection: UICollectionView!
@IBOutlet var player: WKYTPlayerView!
@IBOutlet weak var videoTitle:UILabel!
 var model = InstituteDetailsModel()
 var videoArray  = [VideoModel]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with model:InstituteDetailsModel){
        videoArray = model.videoArray
        if videoArray.isEmpty == false,videoArray[0].videoUrl.isEmpty == false  {
           let thumb =  videoArray[0].videoUrl
           self.videoTitle.text = videoArray[0].videoTitle
                 if let  videoId = thumb.split(separator: "=").last {
                    self.configure(videoID: String(videoId))
                 }
        }
        self.collection.reloadData()
    }
    func configure(videoID:String){
        player.load(withVideoId: videoID, playerVars: ["playsinline": "1" ,
               "controls": "0",
               "showinfo": "0",
               "origin": "https://www.youtube.com"
        ])
       
        
        player.delegate = self

    }
}
//***********************************************//
// MARK: Youtube Player Delegate Defined here
//***********************************************//

extension VideoCell:WKYTPlayerViewDelegate {
    func configrueForCourseVideo(_ model:CourseDetailsModel){
        self.videoArray = model.videoArray
        self.collection.reloadData()
    }
}

//***********************************************//
// MARK: Collection View Defined Here
//***********************************************//

extension VideoCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return videoCellForRow(collectionView, cellForItemAt: indexPath)
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoModel       = videoArray[indexPath.item]
        self.videoTitle.text = videoModel.videoTitle
        if videoModel.videoUrl.isEmpty == false  {
                  let thumb =  videoModel.videoUrl
           
                        if let  videoId = thumb.split(separator: "=").last {
                           self.configure(videoID: String(videoId))
                        }
               }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60.0, height: 60.0)
    }
    func videoCellForRow(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)->VideoListCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoListCell", for: indexPath) as! VideoListCell
           cell.configure(thumb:videoArray[indexPath.row].videoUrl)
        
        return cell
    }
    
    
}
