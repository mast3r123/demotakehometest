//
//  ErrorMessage.swift
//  GitSample
//
//  Created by master on 4/4/22.
//

import Foundation

enum ErrorMessage: String {
    case invalidUsername = "This username created an invaid request, please try again"
    case unableToComplete = "Unable to check your request, please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
}
