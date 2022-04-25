//
//  ContentView.swift
//  Woof WatchKit Extension
//
//  Created by Michael Adams on 12/20/21.
//

import Combine
import SwiftUI
import HealthKit
import UserNotifications

struct StartView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var workoutManager: WorkoutManager
    @AppStorage("dog.name") var name: String?
    
    var workoutTypes: [HKWorkoutActivityType] = [.walking, .play]
    
    let center = UNUserNotificationCenter.current()
    
    var body: some View {
        NavigationView {
            
            List {
                
                DogStatsView()
                    .listRowBackground(Color.black)
                
                NavigationLink(destination: SessionPagingView(), tag: .walking, selection: $workoutManager.selectedWorkout) {
                    HStack {
                        Text("Walk")
                        Spacer()
                        Image(systemName: "figure.walk")
                            .foregroundColor(.accentColor)
                    }
                }
                .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
                NavigationLink(destination: SessionPagingView(), tag: .play, selection: $workoutManager.selectedWorkout) {
                    HStack {
                        Text("Play")
                        Spacer()
                        Image("tennisBall")
                            .foregroundColor(.accentColor)
                    }
                }
                .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
                NavigationLink(destination: SettingsView()) {
                    HStack {
                        Text("Settings")
                        Spacer()
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.accentColor)
                    }
                }
                .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
                
            }
            .navigationTitle("\(name ?? "Woof")")
            .navigationBarHidden(false)
            .navigationBarTitleDisplayMode(.large)
            .navigationViewStyle(.automatic)
            .listStyle(.carousel)
        }
        .onAppear {
            workoutManager.requestAuthorization()
            workoutManager.checkStreak()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().environmentObject(WorkoutManager())
    }
}

extension HKWorkoutActivityType: Identifiable {
    public var id: UInt {
        rawValue
    }
    
    var name: String {
        switch self {
        case .walking:
            return "Walk"
        case .play:
            return "Play"
        default:
            return ""
        }
    }
    
    var image: Image {
        switch self {
        case .walking:
            return Image(systemName: "pawprint.fill")
        case .play:
            return Image("tennisBall")
        default:
            return Image(systemName: "pawprint.fill")
        }
    }
}
