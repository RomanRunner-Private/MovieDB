//
//  NetworkService.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import Foundation
import Combine

enum ApiTokens: String {
    case readToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMDNkM2UyNzAxYjhhM2EzZDhjZWNmNzVhZTg5NzNkMyIsInN1YiI6IjVmMjY2ZWIxZGJiYjQyMDAzNWUzZjFlZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.MAqlvSzUXRbtP_SA8H7TtOYusYDM2GnDYWNlY-lRXNs"
    case apiKey = "e03d3e2701b8a3a3d8cecf75ae8973d3"
}

protocol NetworkServiceProtocol: AnyObject {
    func getMoviesList(listNumber: Int, page: Int, completion: ((MovieEntity?)->())?)
    func loadImage(by endpoint: String) async throws ->  AnyObject?
}

final class NetworkService: NetworkServiceProtocol {
    
    private let decoder = JSONDecoder()
    private let urlBuilder: URLBuilder
    private let imageProcessing: ImageProcessing
    
    init(urlBuilder: URLBuilder, imageProcessing: ImageProcessing) {
        self.urlBuilder = urlBuilder
        self.imageProcessing = imageProcessing
    }
    
    private func makeMainRequest(listNumber: Int, page: Int) -> URLRequest {
        var request = URLRequest(url: urlBuilder.constructURL(for: .base(listNumber: listNumber, page: page)))
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(String(format: "Bearer %s", ApiTokens.readToken.rawValue), forHTTPHeaderField: "Authorization")
        return request
    }
    
    func getMoviesList(listNumber: Int, page: Int, completion: ((MovieEntity?)->())?) {
        URLSession.shared.dataTask(with: makeMainRequest(listNumber: listNumber, page: page)) { data, response, error in
            if let data = data {
                if let list = try? self.decoder.decode(MovieEntity.self, from: data) {
                    completion?(list)
                } else {
                    completion?(nil)
                    print("Invalid Response")
                }
            } else if let error = error {
                self.errorHandler(error: error)
            }
        }.resume()
    }
    
    func loadImage(by endpoint: String) async throws ->  AnyObject? {
        let image = try await imageProcessing.image(from: urlBuilder.constructURL(for: .image(endpoint: endpoint)))
        return image
    }
    
    private func errorHandler(error: Error) {
        print("HTTP Request Failed \(error)")
    }
}
