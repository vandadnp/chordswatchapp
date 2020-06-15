//
//  ContentView.swift
//  ChordsWatchApp WatchKit Extension
//
//  Created by Vandad Nahavandipoor on 2020-06-14.
//  Copyright © 2020 Pixolity AB. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let timer = Timer
        .publish(every: 1.0, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        VStack(alignment: .center) {
            Text("🔊")
                .font(.largeTitle)
            HStack(alignment: .center, spacing: 2.0) {
                Button(action: {
                    print("Major")
                }, label: {
                    Text("Major")
                })
                Button(action: {
                    print("Minor")
                }, label: {
                    Text("Minor")
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
