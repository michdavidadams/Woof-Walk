//
//  WoofApp.swift
//  Woof WatchKit Extension
//
//  Created by Michael Adams on 12/20/21.
//

import SwiftUI

@main
struct WoofApp: App {
    @StateObject private var workoutManager = WorkoutManager()
    @StateObject var dog = DogViewModel()
    @StateObject var streak = Streak()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                StartView()
            }
            .sheet(isPresented: $workoutManager.showingSummaryView) {
                SummaryView()
            }
            .environmentObject(workoutManager)
        }
    }
}
