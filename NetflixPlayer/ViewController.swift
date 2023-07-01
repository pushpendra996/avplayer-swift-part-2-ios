//
//  ViewController.swift
//  NetflixPlayer
//
//  Created by Pushpendra on 29/06/23.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet weak var videoPlayer: UIView!
    @IBOutlet weak var videoPlayerHeight: NSLayoutConstraint!
    
    let videoURL = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setVideoPlayer()
    }

    private var player : AVPlayer? = nil
    private var playerLayer : AVPlayerLayer? = nil
    
    private func setVideoPlayer() {
        guard let url = URL(string: videoURL) else { return }
        
        if self.player == nil {
            self.player = AVPlayer(url: url)
            self.playerLayer = AVPlayerLayer(player: self.player)
            self.playerLayer?.videoGravity = .resizeAspectFill
            self.playerLayer?.frame = self.videoPlayer.bounds
            if let playerLayer = self.playerLayer {
                self.view.layer.addSublayer(playerLayer)
            }
            self.player?.play()
        }
    }
    
    private var windowInterface : UIInterfaceOrientation? {
        return self.view.window?.windowScene?.interfaceOrientation
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        guard let windowInterface = self.windowInterface else { return }
        if #available(iOS 16.0, *) {
            if windowInterface.isPortrait ==  true {
                self.videoPlayerHeight.constant = 300
            } else {
                self.videoPlayerHeight.constant = self.view.layer.bounds.height
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.playerLayer?.frame = self.videoPlayer.bounds
            })
        }
    }
}

