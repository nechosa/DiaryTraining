//
//  DiaryTrainingApp.swift
//  DiaryTraining
//
//  Created by Ilya Nechoysa on 25.07.2021.
//

import SwiftUI

@main
struct DiaryTrainingApp: App {

    @Environment(\.scenePhase) var scenePhase

    init() {
        print("DiaryTrainingApp application is starting up. App initaliser.")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Router())
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("App is active")
            case .background:
                print("App is in background")
            case .inactive:
                print("App is inactive")
            @unknown default:
                print("Oh integesting: I receviced an unexpected new value")
            }
        }
    }
}
