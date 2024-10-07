//
//  ExamenApp.swift
//  Examen
//
//  Created by Maria Jose Gaytan Gil on 05/10/24.
//

import SwiftUI

@main
struct ExamenApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    PortraitViewController.setOrientationLock()
                }
        }
    }
}

