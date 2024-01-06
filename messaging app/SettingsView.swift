//
//  SettingsView.swift
//  messaging app
//
//  Created by Mohamed Rage on 2024-01-05.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        // Use a List or VStack depending on how you want to structure your settings
        List {
            // ... other settings options

            Button("Sign Out") {
                authViewModel.signOut()
            }
            .foregroundColor(Color.red) // Make the button red to signify a destructive action
        }
        .navigationTitle("Settings")
    }
}
