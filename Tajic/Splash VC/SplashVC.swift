//
//  SplashVC.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 20/04/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit
import AVKit

class SplashVC: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
             configure()
    }
    
    override func viewDidLayoutSubviews() {
        
       }
    
    
    
    func configure(){
        DispatchQueue.main.async{
            self.autoPlayVideo()
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+4.0) {
        AppDelegate.shared.decideToMoveViewController()
        }
    }
    
    
    func autoPlayVideo(){
        if  let filepath = Bundle.main.path(forResource: "gif_logo", ofType: "mp4") {
            let videoURL = URL(fileURLWithPath: filepath)

        let player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
    }
    
    
    
    
    
    
    func loadGIF(){
        let frame  = CGRect(x: 00.0, y: 00.0, width: 375 , height: 375)
        guard let animatedImageView = UIImageView.fromGif(frame: frame, resourceName: "AniS") else { return }
        view.addSubview(animatedImageView)
        animatedImageView.center = view.center
        animatedImageView.startAnimating()
    }
}





