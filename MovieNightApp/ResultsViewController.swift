//
//  ResultsViewController.swift
//  MovieNightApp
//
//  Created by Dzmitry Matsiulka on 9/10/19.
//  Copyright © 2019 Dzmitry M. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var genresToLookUp = [Int]()
    var movies = [Movie]()
    private let apiKey = "4e0fcd35a8e3a8748280db74cea8ed13"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieDesciption: UITextView!
    
      var currentMovie = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        retrieveMovies()
      
    }
    

    
    func retrieveMovies(){
        do{
            if let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(genresToLookUp[0])") {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        do {
                            let moviesJSON = try JSONDecoder().decode(MovieResults.self, from: data)
                            for movie in moviesJSON.results{
                                self.movies.append(movie)
                            }
                            self.presentNextMovie()
                            }
                        //HANDLES IF SOMETHING GOES WRONG DURING RETRIEVING MOVIES, GOES BACK TO THE MAIN MENU
                        catch let error {
                            print(error)
                            let alertController = UIAlertController(title: "Error", message: "Something went wrong. More specifically: \(error.localizedDescription)", preferredStyle: .alert)
                            let action1 = UIAlertAction(title: "Try again", style: .default) { (action:UIAlertAction) in
                                self.performSegue(withIdentifier: "goToMainScreen", sender: nil)
                            }
                            alertController.addAction(action1)
                            self.present(alertController, animated: true, completion: nil)
                            
                        }
                    }
                }.resume()
            }
        }
    }
    // CHECK IF THE LAST MOVIE IS PRESENTED
    @IBAction func nextMovie(_ sender: Any) {
        
        if currentMovie != movies.count - 1{
        presentNextMovie()
        }else{
            // GOES TO THE MAIN MENU
            let alertController = UIAlertController(title: "You've seen our suggestions", message: "If you want to see different movies - start again.", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Okay", style: .default) { (action:UIAlertAction) in
                self.performSegue(withIdentifier: "backToMainMenu", sender: nil)
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func presentNextMovie(){
       
            DispatchQueue.main.async {
                var url : URL?
                
                if self.movies[self.currentMovie].posterPath != nil{
                    url = URL(string: "https://image.tmdb.org/t/p/w300\(self.movies[self.currentMovie].posterPath!)")
                       self.movieImage.downloadImage(from: url!)
                }else
                    {
                        // IF POSTER NOT PROVIDED USE THE DEFAULT
                    self.movieImage.image = UIImage.init(named: "iTunesArtwork")
                      print("No url to show")
                    }
                
            self.nameLabel.text = self.movies[self.currentMovie].originalTitle
            self.ratingLabel.text = "Popularity: \(self.movies[self.currentMovie].popularity)"
            self.movieDesciption.text = "Overview: \(self.movies[self.currentMovie].overview)"
            self.currentMovie += 1
    }
     
                
            }
            
        }
// DOWNLOADING IMAGE EXTENSION
extension UIImageView {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        getData(from: url) {
            data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }
    }
}
