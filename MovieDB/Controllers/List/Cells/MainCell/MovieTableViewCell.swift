//
//  MovieTableViewCell.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
     
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var movieTitleLabel: UILabel!
    
    func configure(with data: Result, viewModel: MovieListViewModel) {
        Task {
            await processData(with: data, viewModel: viewModel)
        }
    }
    
    private func processData(with data: Result, viewModel: MovieListViewModel) async {
        
        movieTitleLabel.text = data.title
        
        Task {
            if let imageData = data.imageData {
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: imageData)
                }
                return
            }
            let image = await viewModel.loadImage(by: data.posterPath) as? UIImage
            posterImageView.image = image
        }
    }
}
