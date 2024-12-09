//
//  NetworkManager.swift
//  HomeScreenApp
//
//  Created by Neeshu Kumar on 09/12/24.
//

import Foundation
import Combine

/// Singleton class responsible for making network calls.
class NetworkManager {
    /// Shared instance of the NetworkManager.
    static let shared = NetworkManager()
    
    /// Private initializer to prevent instantiation from outside the class.
    private init() {}
    
    /// Fetches a list of employees from the server.
    /// - Returns: A Combine publisher that emits an array of Employee or an error.
    func fetchEmployees() -> AnyPublisher<[Employee], Error> {
        // API endpoint URL
        guard let url = URL(string: "https://a00407a8-f46e-407e-b684-5d949532e7fc.mock.pstmn.io/api/v1/employees") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        // Use Combine's dataTaskPublisher for fetching data.
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data) // Extract the raw data.
            .decode(type: EmployeeResponse.self, decoder: JSONDecoder()) // Decode JSON into `EmployeeResponse`.
            .map(\.data) // Extract the data array containing employees.
            .receive(on: DispatchQueue.main) // Ensure updates happen on the main thread.
            .eraseToAnyPublisher() // Erase type to simplify usage.
    }
}
