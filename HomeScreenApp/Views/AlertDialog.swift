//
//  AlertDialog.swift
//  HomeScreenApp
//
//  Created by Neeshu Kumar on 09/12/24.
//

import SwiftUI

/// A reusable view that displays an alert dialog with customizable actions.
struct AlertDialog: View {
    let title: String           // Title of the dialog.
    let message: String         // Message/body of the dialog.
    let onCopy: () -> Void      // Action to perform when "Copy" is tapped.
    let onDelete: () -> Void    // Action to perform when "Delete" is tapped.
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.headline) // Bold title font.
            
            Text(message)
                .font(.subheadline) // Smaller font for the message.
            
            HStack(spacing: 16) {
                Button("Copy") {
                    onCopy() // Trigger the copy action.
                }
                .foregroundColor(.blue) // Blue text for "Copy" button.
                
                Button("Delete") {
                    onDelete() // Trigger the delete action.
                }
                .foregroundColor(.red) // Red text for "Delete" button.
            }
        }
        .padding() // Add padding inside the dialog.
        .background(Color.white) // White background.
        .cornerRadius(10) // Rounded corners for the dialog.
        .shadow(radius: 10) // Add shadow for a subtle effect.
    }
}
