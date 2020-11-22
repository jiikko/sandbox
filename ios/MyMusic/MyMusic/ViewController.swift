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
        do {
            bgmPlayer = try AVAudioPlayer(contentsOf: bgmPath, fileTypeHint: nil)
            bgmPlayer.numberOfLoops = -1
            bgmPlayer.play()
        } catch {
            print(" エラーです ")
        }
    }
    
    @IBAction func guitar(_ sender: Any) {
        do {
            guitarPlayer = try AVAudioPlayer(contentsOf: guitarPath, fileTypeHint: nil)
            guitarPlayer.play()
        } catch {
            print(" エラーです ")
        }
    }

    @IBAction func cymbal(_ sender: Any) {
        do {
            cymbalPlayer = try AVAudioPlayer(contentsOf: cymbalPath, fileTypeHint: nil)
            cymbalPlayer.play()
        } catch {
            print(" エラーです ")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
