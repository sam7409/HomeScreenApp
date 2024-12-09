//
//  HomeView.swift
//  HomeScreenApp
//
//  Created by Neeshu Kumar on 09/12/24.
//

import SwiftUI

/// Main view of the application displaying the employee list.
struct HomeView: View {
    @StateObject private var viewModel = EmployeeListViewModel() // ViewModel for managing data.
    @State private var showDialog = false                        // State for showing/hiding the alert dialog.
    @State private var selectedEmployee: Employee?               // Currently selected employee for actions.
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.employees) { employee in
                    EmployeeRowView(employee: employee) // Display each employee in a row.
                        .onLongPressGesture {
                            // Show dialog on long press.
                            selectedEmployee = employee
                            showDialog = true
                        }
                        .transition(.move(edge: .bottom)) // Use move transition for row removal or addition.
                }
                .onDelete(perform: deleteEmployee)
            }
            .navigationTitle("Employees") // Set the title of the navigation bar.
            .onAppear {
                // Fetch employees when the view appears.
                viewModel.fetchEmployees()
            }
            .alert(isPresented: $showDialog) {
                // Display an alert dialog with actions.
                Alert(
                    title: Text("Employee Actions"),
                    message: Text("What would you like to do?"),
                    primaryButton: .default(Text("Copy")) {
                        if let employee = selectedEmployee {
                            withAnimation { // Wrap the copy action in withAnimation for smooth UI update.
                                viewModel.copyEmployee(employee)
                            }
                        }
                    },
                    secondaryButton: .destructive(Text("Delete")) {
                        if let employee = selectedEmployee {
                            withAnimation { // Wrap the delete action in withAnimation for smooth UI update.
                                viewModel.deleteEmployee(employee)
                            }
                        }
                    }
                )
            }
            
            // Display error message if fetching data fails.
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .animation(.default, value: viewModel.employees) // Apply animation when employees change.
    }
    
    /// Function to delete an employee from the list.
    private func deleteEmployee(at offsets: IndexSet) {
        withAnimation {
            // Delete employee using the view model.
            offsets.map { viewModel.employees[$0] }.forEach { employee in
                viewModel.deleteEmployee(employee)
            }
        }
    }
}
