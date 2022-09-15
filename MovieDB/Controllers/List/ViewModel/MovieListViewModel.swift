//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import Foundation
import UIKit

protocol MovieListViewModelProtocol {}

final class MovieListViewModel: MovieListViewModelProtocol {
    
    var totalResults = UserDefaults.standard.integer(forKey: Constants.UserDefaultsKeys.kTotalResultsCountKey.rawValue)
    
    private var totalPages: Int = UserDefaults.standard.integer(forKey: Constants.UserDefaultsKeys.kTotalPagesKey.rawValue)

    private var nextPage = 1
    
    var items: [Result] = []
    var isLoading = false
    
    private let coordinator: MovieListViewCoordinatorProtocol
    private let networkService: NetworkServiceProtocol
    private let databaseService = CoreDataStoreManager()
    
    init(coordinator: MovieListViewCoordinatorProtocol, networkService: NetworkServiceProtocol) {
        self.coordinator = coordinator
        self.networkService = networkService
    }
    
    func displayAlert() {
        coordinator.displayAlert()
    }
    
    func getMoviesFromLocalStorage(completion: @escaping ((Bool) -> Void)) {
        for item in databaseService.loadMovies() {
            let itemToAdd = Result(adult: false,
                                   backdropPath: "",
                                   genreIDS: [],
                                   id: Int(item.id),
                                   mediaType: .movie,
                                   originalLanguage: .en,
                                   originalTitle: item.title!,
                                   overview: item.overview!,
                                   popularity: 0.0,
                                   posterPath: "",
                                   releaseDate: item.releaseDate!,
                                   title: item.title!,
                                   video: false,
                                   voteAverage: item.rating,
                                   voteCount: Int(item.votesCount),
                                   imageData: item.image)
            items.append(itemToAdd)
        }
        
        if items.count > 0 {
            completion(true)
            return
        }
        completion(false)
    }
    
    func getMovies(completion: @escaping ((Bool) -> Void)) {
        networkService.getMoviesList(listNumber: 1, page: nextPage) { [weak self] elements in
            guard let possibleElements = elements, let self = self else {
                completion(false)
                return
            }
            self.handleIncomeData(data: possibleElements)
            self.saveToDatabase(source: possibleElements.results)
            completion(true)
        }
    }
    
    func loadMore(completion: @escaping ((Bool) -> Void)) {
        
        if !isLoading && nextPage <= totalPages && items.count < totalResults {
            
            isLoading = true
            
            // MARK: - some delay so to see "LoadingCell"
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1.5) {
                self.networkService.getMoviesList(listNumber: 1, page: self.nextPage) { [weak self] elements in
                    guard let possibleElements = elements, let self = self else {
                        completion(false)
                        self?.isLoading = false
                        return
                    }
                    self.handleIncomeData(data: possibleElements)
                    self.saveToDatabase(source: possibleElements.results)
                    self.isLoading = false
                    completion(true)
                }
            }
        }
    }
    
    func loadImage(by endpoint: String) async -> AnyObject? {
        do {
            return try await networkService.loadImage(by: endpoint)
        } catch {}
        return nil
    }
    
    private func setNextPage() {
        guard nextPage < totalPages else { return }
        nextPage = nextPage + 1
    }
    
    private func handleIncomeData(data: MovieEntity) {
        items.append(contentsOf: data.results)
        totalPages = data.totalPages
        UserDefaults.standard.set(data.totalPages, forKey: Constants.UserDefaultsKeys.kTotalPagesKey.rawValue)
        UserDefaults.standard.set(data.totalResults, forKey: Constants.UserDefaultsKeys.kTotalResultsCountKey.rawValue)
        totalResults = data.totalResults
        isLoading = false
        setNextPage()
    }
    
    private func saveToDatabase(source: [Result]) {
        DispatchQueue.global(qos: .background).async {
            source.forEach { result in
                Task {
                    let image = try await self.networkService.loadImage(by: result.posterPath) as! UIImage
                    try self.databaseService.saveMovieInfo(object: result, imageData: image.convertToData())
                }
            }
        }
    }
    
}
