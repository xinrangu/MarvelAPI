//
//  OpenViewController.swift
//  marvel
//
//  Created by Gu Xinran on 4/29/19.
//  Copyright © 2019 Gu Xinran. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class OpenViewController: UIViewController,AVPlayerViewControllerDelegate{

    @IBOutlet weak var video: UIView!
    
    let playerController = AVPlayerViewController()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playVideo()
        //let date = Date().addingTimeInterval(100)
        //let timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
        //let timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
    }
    
//    @objc func timeToMoveOn() {
//        self.performSegue(withIdentifier: "ListHeroes", sender: self)
//    }
    
    func playVideo() {
        guard let path = Bundle.main.path(forResource: "openning", ofType:"mp4") else{
            print("error")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        //let playerLayer = AVPlayerLayer(player: player)
        playerController.delegate = self
        //static let AVPlayerItemDidPlayToEndTime: player
        print(player)
        //print(flag)
        //NotificationCenter.default.addObserver(self, selector: #selector(didfinishplaying),name:NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player)
        playerController.player = player
        //video.layer.addSublayer(playerLayer)
        //self.addChild(playerController)
        self.view.addSubview(playerController.view)
        playerController.view.frame = self.view.frame
        self.present(playerController, animated: true) {
            player.play()
        }
    }

    @objc func didfinishplaying(note : NSNotification)
    {
        print("Video Finished")
        self.playerController.dismiss(animated: true,completion: nil)
        NotificationCenter.default.removeObserver(self)
        print("Getting Heroes")
        performSegue(withIdentifier: "ListHeroes", sender: self)
        //let alertview = UIAlertController(title:"finished",message:"video finished",preferredStyle: .alert)
        //alertview.addAction(UIAlertAction(title:"Ok",style: .default, handler: nil))
        //self.present(alertview,animated:true,completion: nil)
    }
}
