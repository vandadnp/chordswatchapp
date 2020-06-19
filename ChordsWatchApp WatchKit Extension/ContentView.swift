//
//  ContentView.swift
//  ChordsWatchApp WatchKit Extension
//
//  Created by Vandad Nahavandipoor on 2020-06-14.
//  Copyright © 2020 Pixolity AB. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @State var gameTimer: GameTimer?
    @State var currentChord: Chord?
    
    private func playRandomChord() {
        currentChord?.stop()
        currentChord = Chord.allChords.randomElement()
        currentChord?.play()
    }
    
    private func restartTimer(afterSeconds: Int = 1) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + .seconds(afterSeconds),
            execute: {
                self.answerText = "🔊"
                self.playRandomChord()
            }
        )
    }
    
    private func processAnswer(chordType: Chord.ChordType) {
        gameTimer?.stop()
        guard let currentChord = currentChord else { return }
        if currentChord.chordType == chordType {
            //correct answer
            answerText = "✅"
        } else {
            answerText = "❌"
        }
        restartTimer()
    }
    
    @State var answerText = "🔊"
    
    private func setupTimer() {
        self.gameTimer?.stop()
        self.gameTimer = GameTimer(onStarted: {
            self.playRandomChord()
        })
    }
    
    var body: some View {
        VStack(alignment: .center) {
            
            Spacer()
            
            Text(answerText)
                .font(.largeTitle)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 2.0) {
                Button(action: {
                    self.processAnswer(chordType: .minor)
                }, label: {
                    Text("Minor")
                })
                Button(action: {
                    self.processAnswer(chordType: .major)
                }, label: {
                    Text("Major")
                })
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .NSExtensionHostDidBecomeActive), perform: { _ in
            self.setupTimer()
        })
        .onReceive(NotificationCenter.default.publisher(for: .NSExtensionHostDidEnterBackground), perform: { _ in
            self.currentChord?.stop()
            self.gameTimer?.stop()
        })
        .onAppear {
            self.setupTimer()
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
