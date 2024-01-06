//
//  SignUpView.swift
//  messaging app
//
//  Created by Mohamed Rage on 2024-01-05.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            Form {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Username", text: $username)
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                SecureField("Confirm Password", text: $confirmPassword)

                Button("Sign Up") {
                    authViewModel.signUp(firstName: firstName, lastName: lastName, username: username, email: email, password: password, confirmPassword: confirmPassword)
                }
            }
            .navigationTitle("Sign Up")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(authViewModel.errorMessage ?? "Unknown error"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onChange(of: authViewModel.errorMessage) { _ in
                showAlert = authViewModel.errorMessage != nil
            }
        }
    }
}
