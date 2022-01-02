//
//  ComplicationController.swift
//  Woof Walk WatchKit Extension
//
//  Created by Michael Adams on 12/20/21.
//

import ClockKit
import SwiftUI

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    @ObservedObject var userSettings = UserSettings()
    @ObservedObject var walks = Walks()
    
    // MARK: - Complication Configuration

    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication", displayName: "Woof Walk", supportedFamilies: CLKComplicationFamily.allCases),
            CLKComplicationDescriptor(identifier: "ExerciseGoal", displayName: "Exercise Goal", supportedFamilies: CLKComplicationFamily.allCases)
            // Multiple complication support can be added here with more descriptors
        ]
        
        // Call the handler with the currently supported complication descriptors
        handler(descriptors)
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: - Timeline Configuration
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        // Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        handler(nil)
    }
    
    // MARK: - Sample Templates
    let gaugeProvider = CLKSimpleGaugeProvider(style: .ring, gaugeColor: .green, fillFraction: 0)
    let centerTextProvider = CLKSimpleTextProvider(text: "pawprint.fill")
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        
        switch (complication.family) {
        case (.graphicCircular):
            handler(CLKComplicationTemplateGraphicCircularClosedGaugeText(gaugeProvider: gaugeProvider, centerTextProvider: centerTextProvider))
        default:
            handler(nil)
        }
    }
    
    func createTemplate(for complication: CLKComplication, date: Date)
    -> CLKComplicationTemplate? {
        return CLKComplicationTemplateGraphicCircularClosedGaugeText(gaugeProvider: CLKSimpleGaugeProvider(style: .ring, gaugeColor: .green, fillFraction: Float(walks.todaysWalks / Double(userSettings.exerciseGoal))), centerTextProvider: centerTextProvider)
    }
    
}
