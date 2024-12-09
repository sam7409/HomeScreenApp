//
//   EmployeeListViewModel.swift
//  HomeScreenApp
//
//  Created by Neeshu Kumar on 09/12/24.
//

import Foundation
import Combine

/// ViewModel responsible for managing employee data and handling business logic.
class EmployeeListViewModel: ObservableObject {
    // Published list of employees to update the UI automatically when changed.
    @Published var employees: [Employee] = []
    
    // Published error message for displaying errors to the user.
    @Published var errorMessage: String?
    
    // A set to manage Combine subscriptions and prevent memory leaks.
    private var cancellables = Set<AnyCancellable>()
    
    /// Fetches the list of employees from the server using NetworkManager.
    func fetchEmployees() {
        NetworkManager.shared.fetchEmployees()
            .sink(receiveCompletion: { completion in
                // Handle completion (either success or failure).
                switch completion {
                case .failure(let error):
                    // Set error message for UI display.
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] employees in
                // Update the employee list with fetched data.
                self?.employees = employees
            })
            .store(in: &cancellables) // Store the subscription in the cancellables set.
    }
    
    /// Copies an employee and appends the new copy to the list.
    /// - Parameter employee: The employee to copy.
    func copyEmployee(_ employee: Employee) {
        let newEmployee = Employee(
            id: UUID().hashValue, // Generate a unique ID for the copied employee.
            employee_name: employee.employee_name,
            employee_age: employee.employee_age,
            employee_salary: employee.employee_salary,
            profile_image: employee.profile_image
        )
        employees.append(newEmployee) // Add the copied employee to the list.
    }
    
    /// Deletes an employee from the list.
    /// - Parameter employee: The employee to delete.
    func deleteEmployee(_ employee: Employee) {
        employees.removeAll { $0.id == employee.id } // Remove employee by matching ID.
    }
}
