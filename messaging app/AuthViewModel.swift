//
//  AuthViewModel.swift
//  messaging app
//
//  Created by Mohamed Rage on 2024-01-05.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?

    private let db = Firestore.firestore()

    func signUp(firstName: String, lastName: String, username: String, email: String, password: String, confirmPassword: String) {
        // Check if passwords match
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        // Check username uniqueness
        db.collection("users").whereField("username", isEqualTo: username).getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                self?.errorMessage = "Error checking username: \(error.localizedDescription)"
                return
            }

            if let snapshot = snapshot, !snapshot.isEmpty {
                self?.errorMessage = "Username is already taken."
                return
            }

            // Proceed with email & password registration
            self?.createUser(firstName: firstName, lastName: lastName, username: username, email: email, password: password)
        }
    }

    private func createUser(firstName: String, lastName: String, username: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.errorMessage = "Sign up error: \(error.localizedDescription)"
                return
            }

            // Store additional user details
            if let userId = authResult?.user.uid {
                self?.storeUserDetails(userId: userId, firstName: firstName, lastName: lastName, username: username)
            }
        }
    }

    private func storeUserDetails(userId: String, firstName: String, lastName: String, username: String) {
        db.collection("users").document(userId).setData([
            "firstName": firstName,
            "lastName": lastName,
            "username": username
        ]) { [weak self] error in
            if let error = error {
                self?.errorMessage = "Error storing user details: \(error.localizedDescription)"
            } else {
                DispatchQueue.main.async {
                    self?.isAuthenticated = true
                }
            }
        }
    }

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                // Handle errors such as a user not found or incorrect password
                print("Authentication error: \(error.localizedDescription)")
            } else {
                self?.isAuthenticated = true
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
