//
//  EmployeeRowView.swift
//  HomeScreenApp
//
//  Created by Neeshu Kumar on 09/12/24.
//

import SwiftUI

/// View representing a single row in the employee list.
struct EmployeeRowView: View {
    let employee: Employee // Employee data for the row.
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Check if the profile image URL is valid and non-empty.
            if let imageUrl = URL(string: employee.profile_image), !employee.profile_image.isEmpty {
                // Load and display the profile image asynchronously.
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        // Placeholder while loading.
                        ProgressView()
                            .frame(width: 60, height: 60)
                    case .success(let image):
                        // Successfully loaded image.
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle()) // Make it circular.
                            .shadow(radius: 4)
                    case .failure:
                        // Fallback for when the image fails to load.
                        placeholderImage
                    @unknown default:
                        // Handle any future cases.
                        placeholderImage
                    }
                }
            } else {
                // Show a placeholder for empty or invalid URL.
                placeholderImage
            }
            
            // Employee details.
            VStack(alignment: .leading) {
                // Display the employee's name.
                Text("Name: \(employee.employee_name)")
                    .font(.headline) // Bold text for the name.
                
                // Display the employee's age.
                Text("Age: \(employee.employee_age)")
                    .font(.subheadline) // Smaller font for the age.
                
                // Display the employee's salary.
                Text("Salary: $\(employee.employee_salary)")
                    .font(.subheadline) // Smaller font for the salary.
            }
        }
        .padding() // Add padding around the content.
    }
    
    /// Placeholder image for invalid or missing profile images.
    private var placeholderImage: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
            .foregroundColor(.gray)
    }
}
