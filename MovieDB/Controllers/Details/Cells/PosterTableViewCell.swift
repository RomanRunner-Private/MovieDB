//
//  PosterTableViewCell.swift
//  MovieDB
//
//  Created by Roman Bigun on 04.09.2022.
//

import UIKit

struct MovieDataPosterCell {
    let raiting: Double
    let votes: Int32
    let date: String
    let posterPath: String
    let overview: String
    let image: Data?
    let title: String
    let id: Int32
}

class PosterTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(viewModel: DetailsViewModel) {
        
        let data = viewModel.dataForCell()
        
        releaseDateLabel.text = "Release date: \(data.date)"
        
        votesLabel.text = "Raiting: \(data.raiting) (\(data.votes))"
        
        Task {
            await processImage(with: data.posterPath, viewModel: viewModel)
        }
    }
    
    private func processImage(with endpoint: String, viewModel: DetailsViewModel) async {
        
        let data = viewModel.dataForCell()
        
        Task {
            
            // MARK: - in case we are having an image in the local storage
            if let imageData = data.image {
                posterImageView.image = UIImage(data: imageData)
                return
            }
            
            // MARK: - have just loaded model from the moviedb backend
            let image = await viewModel.loadImage(by: data.posterPath) as? UIImage
            posterImageView.image = image
        }
    }
}
