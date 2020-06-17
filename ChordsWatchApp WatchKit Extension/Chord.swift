//
//  Chord.swift
//  ChordsWatchApp WatchKit Extension
//
//  Created by Vandad Nahavandipoor on 2020-06-15.
//  Copyright © 2020 Pixolity AB. All rights reserved.
//

import UIKit
import AVFoundation

class Chord {
    
    static func setupAudioSession() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(
            .playback,
            mode: .default,
            policy: .default,
            options: []
        )
    }
    
    enum ChordType {
        case major, minor
    }
    
    let chordType: ChordType
    
    var isMajor: Bool { chordType == .major }
    
    private var player: AVAudioPlayer?
    private let data: Data
    
    init?(resName: String, chordType: ChordType) {
        if let data = NSDataAsset(name: resName)?.data {
            self.data = data
            self.chordType = chordType
        } else {
            return nil
        }
    }
    
    func play() {
        stop()
        player = try? AVAudioPlayer(data: data)
        player?.play()
    }
    
    func stop() {
        player?.stop()
    }
    
    static let allChords: [Chord] = chords
}

private let chords: [Chord] = [
    Chord(resName: "A-major", chordType: .major),
    Chord(resName: "A-minor", chordType: .minor),
    Chord(resName: "Ab-major", chordType: .major),
    Chord(resName: "Ab-minor", chordType: .minor),
    Chord(resName: "B-major", chordType: .major),
    Chord(resName: "B-minor", chordType: .minor),
    Chord(resName: "Bb-major", chordType: .major),
    Chord(resName: "Bb-minor", chordType: .minor),
    Chord(resName: "C-major", chordType: .major),
    Chord(resName: "C-minor", chordType: .minor),
    Chord(resName: "D-major", chordType: .major),
    Chord(resName: "D-minor", chordType: .minor),
    Chord(resName: "Db-major", chordType: .major),
    Chord(resName: "Db-minor", chordType: .minor),
    Chord(resName: "E-major", chordType: .major),
    Chord(resName: "E-minor", chordType: .minor),
    Chord(resName: "Eb-major", chordType: .major),
    Chord(resName: "Eb-minor", chordType: .minor),
    Chord(resName: "F-major", chordType: .major),
    Chord(resName: "F-minor", chordType: .minor),
    Chord(resName: "Fsharp-major", chordType: .major),
    Chord(resName: "Fsharp-minor", chordType: .minor),
    Chord(resName: "G-major", chordType: .major),
    Chord(resName: "G-minor", chordType: .minor)
].compactMap { $0 }
