//
//  ContentView.swift
//  ChordsWatchApp WatchKit Extension
//
//  Created by Vandad Nahavandipoor on 2020-06-14.
//  Copyright © 2020 Pixolity AB. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var gameTimer: GameTimer?
    
    @State var currentChord: Chord?
    
    private func playRandomChord() {
        currentChord?.stop()
        currentChord = Chord.allChords.randomElement()
        currentChord?.play()
    }
    
    private func processAnswer(chordType: Chord.ChordType) {
        guard let currentChord = currentChord else { return }
        if currentChord.chordType == chordType {
            //correct answer
        } else {
            //incorrect answer
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("🔊")
                .font(.largeTitle)
            
            HStack(alignment: .center, spacing: 2.0) {
                Button(action: {
                    self.playRandomChord()
                }, label: {
                    Text("Major")
                })
                Button(action: {
                    print("Minor")
                }, label: {
                    Text("Minor")
                })
            }
        }.onAppear {
            self.gameTimer = GameTimer(onStarted: {
                self.playRandomChord()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class GameTimer {
    
    typealias Started = () -> Void
    private var timer: Timer?
    private var started: Started?
    private var counter = 0
    private static let max = 5
    
    init(
        autoStart: Bool = true,
        onStarted: Started?
    ) {
        self.started = onStarted
        if autoStart {
            start()
        }
    }
    
    func start() {
        stop()
        started?()
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true,
            block: { [weak self] _ in
                guard let self = self else { return }
                self.counter += 1
                if self.counter >= GameTimer.max {
                    self.counter = 0
                    self.started?()
                }
            }
        )
    }
    
    func stop() {
        timer?.invalidate()
    }
}
