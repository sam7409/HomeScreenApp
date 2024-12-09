//
//  Employe.swift
//  HomeScreenApp
//
//  Created by Neeshu Kumar on 09/12/24.
//

import Foundation

/// Model representing an individual Employee.
struct Employee: Identifiable, Codable, Equatable {
    let id: Int                // Unique identifier for the employee.
    let employee_name: String  // Name of the employee.
    let employee_age: Int      // Age of the employee.
    let employee_salary: Int   // Salary of the employee.
    let profile_image: String  // Profile image URL of the employee (if available).
}

/// Model representing the API response for fetching employees.
struct EmployeeResponse: Codable {
    let status: String          // Status of the API response (success or failure).
    let data: [Employee]        // List of employees returned by the API.
    let message: String         // Additional message from the API.
}
