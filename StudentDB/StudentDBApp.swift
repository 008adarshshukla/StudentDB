//
//  StudentDBApp.swift
//  StudentDB
//
//  Created by Adarsh Shukla on 22/04/23.
//

import SwiftUI

@main
struct StudentDBApp: App {
    
    @StateObject private var coreDataViewModel = CoreDataViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(coreDataViewModel)
        }
    }
}
