//
//  DetailsViewModel.swift
//  MovieDB
//
//  Created by Roman Bigun on 04.09.2022.
//

import UIKit /* Bad idea to use it in ViewModel*/

class DetailsViewModel {
    private let coordinator: DetailsControllerCoordinatorProtocol
    private let networkService: NetworkServiceProtocol
    private var model: Result
    private var loadedImage: AnyObject?
    private let imageProcessing = ImageProcessing()
    
    init(coordinator: DetailsControllerCoordinatorProtocol,
         networkService: NetworkServiceProtocol,
         data: Result) {
        self.networkService = networkService
        self.coordinator = coordinator
        self.model = data
    }
    
    func loadImage(by endpoint: String) async -> AnyObject? {
        do {
            loadedImage = try await networkService.loadImage(by: endpoint)
            return loadedImage
        } catch {}
        
        return nil
    }
    
    func navigationViewTitle() -> String {
        return model.title
    }
    
    func dataForCell() -> MovieDataPosterCell {
        
        return MovieDataPosterCell(raiting: model.voteAverage,
                                   votes: Int32(model.voteCount),
                                   date: model.releaseDate,
                                   posterPath: model.posterPath,
                                   overview: model.overview,
                                   image: model.imageData,
                                   title: model.title,
                                   id: Int32(model.id))
    }
    
    func convertToImage(source: AnyObject) -> UIImage? {
        return source as? UIImage
    }
    
    func overviewForMovie() -> String {
        return model.overview
    }
}
