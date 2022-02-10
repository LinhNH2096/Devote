//
//  SoundPlayer.swift
//  DEVOTE
//
//  Created by Nguyễn Hồng Lĩnh on 10/02/2022.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(soundName: String, type: String = "mp3") {
    if let url = Bundle.main.url(forResource: soundName, withExtension: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            feedback.notificationOccurred(.success)
        } catch {
            print("Can't find and play the sound name \(soundName)")
        }
    }
}
