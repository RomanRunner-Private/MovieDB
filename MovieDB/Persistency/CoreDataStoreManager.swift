//
//  CoreDataStoreManager.swift
//  MovieDB
//
//  Created by Roman Bigun on 05.09.2022.
//

import CoreData

protocol CoreDataStoreManagerProtocol {
    func saveMovieInfo(object: Result, imageData: Data) throws
    func loadMovies() -> [MovieListEntity]
}

struct CoreDataStoreManager: CoreDataStoreManagerProtocol {
    
    private func checkIfExists(object: Result) -> Bool {
        let fetchRequest: NSFetchRequest<MovieListEntity>
        fetchRequest = MovieListEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title LIKE %@", object.title)
        let mainContext = CoreDataManager.shared.mainContext
        do {
            if let _ = try mainContext.fetch(fetchRequest).first {
                return true
            }
            return false
        } catch(let error) {
            print(">>> Save to persistancy error: \(error.localizedDescription) <<<")
            return false
        }
    }
    
    func saveMovieInfo(object: Result, imageData: Data) throws {
        
        // MARK: - check for possible entity duplication
        if checkIfExists(object: object) == true {
            return
        }
        
        let context = CoreDataManager.shared.backgroundContext()
        context.perform {
            do {
                let entity = MovieListEntity.entity()
                let movieData = MovieListEntity(entity: entity, insertInto: context)
                movieData.overview = object.overview
                movieData.releaseDate = object.releaseDate
                movieData.title = object.title
                movieData.id = Int64(object.id)
                movieData.rating = object.voteAverage
                movieData.votesCount = Int64(object.voteCount)
                movieData.image = imageData
                try context.save()
            } catch(let error) {
                print(">>> Save to persistancy error: \(error.localizedDescription) <<<")
            }
        }
    }
    
    func loadMovies() -> [MovieListEntity] {
        let mainContext = CoreDataManager.shared.mainContext
        let fetchRequest: NSFetchRequest<MovieListEntity> = MovieListEntity.fetchRequest()
        do {
            let results = try mainContext.fetch(fetchRequest)
            return results
        }
        catch {
            debugPrint(error)
            return []
        }
    }
}
