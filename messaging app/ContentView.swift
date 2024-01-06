//
//  ContentView.swift
//  messaging app
//
//  Created by Mohamed Rage on 2023-12-29.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isShowingSignUpView = false

    var body: some View {
        NavigationView {
            VStack {
                if !authViewModel.isAuthenticated {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button("Sign In") {
                        authViewModel.signIn(email: email, password: password)
                    }
                    .padding()
                    
                    NavigationLink(destination: SignUpView(), isActive: $isShowingSignUpView) {
                        Button("Sign Up") {
                            isShowingSignUpView = true
                        }
                    }
                } else {
                    NextPageView()
                        .navigationBarBackButtonHidden(true)
                }
            }
            .padding()
        }
    }
}

struct NextPageView: View {
    var body: some View {
        TabView {
            Text("The content of the first view")
                .tabItem {
                    Image(systemName: "phone.fill")
                    Text("Calls")
                }
            Text("The content of the second view")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Contacts")
                }
            MessagingView()
                .tabItem {
                    Image(systemName: "text.bubble.fill")
                    Text("Messages")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
    }
}

// Add your MessagingView struct here if it's not in a separate file

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthViewModel())
    }
}


