//
//  ViewController.swift
//  MyMusic
//
//  Created by KAWAGUCHI on 2020/11/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let cymbalPath = Bundle.main.bundleURL.appendingPathComponent("cymbal.mp3")
    var cymbalPlayer: AVAudioPlayer!
    
    let guitarPath = Bundle.main.bundleURL.appendingPathComponent("guitar.mp3")
    var guitarPlayer: AVAudioPlayer!
    
    let bgmPath = Bundle.main.bundleURL.appendingPathComponent("backmusic.mp3")
    var bgmPlayer: AVAudioPlayer!
    
    @IBAction func stop(_ sender: Any) {
        bgmPlayer.stop()
    }
    
    @IBAction func play(_ sender: Any) {
        soundPlayer(player: &bgmPlayer, path:bgmPath, count: -1)
    }
    
    @IBAction func guitar(_ sender: Any) {
        soundPlayer(player: &guitarPlayer, path:guitarPath, count: 0)
    }

    @IBAction func cymbal(_ sender: Any) {
        soundPlayer(player: &cymbalPlayer, path:cymbalPath, count: 0)
    }
    
    fileprivate func soundPlayer(player:inout AVAudioPlayer!, path: URL, count: Int) {
        do {
            player = try AVAudioPlayer(contentsOf: path, fileTypeHint:  nil)
            player.numberOfLoops = count
            player.play()
        } catch {
            print("error ocorret!!!!!")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
