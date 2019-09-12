//
//  GenresTableViewController.swift
//  MovieNightApp
//
//  Created by Dzmitry Matsiulka on 9/8/19.
//  Copyright © 2019 Dzmitry M. All rights reserved.
//

import UIKit
import Foundation

class GenresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let apiKey = "4e0fcd35a8e3a8748280db74cea8ed13"
    
    
    @IBOutlet weak var user1Button: UIButton!
    @IBOutlet weak var user2Button: UIButton!
    
    var hasFirstUserChoosen = false
    var hasSecondUserChosen = false
    
    @IBOutlet weak var nextButtonPressed: UIButton!
    
    struct ChosenGenres{
        let name: String
        var isChosen: Bool
        var id: Int
    }
    
    var genres = [ChosenGenres]()
    
    var firstUserGenres = [Int]()
    var secondUserGenres = [Int]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        retrieveGenres()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = genres[indexPath.row].name

        return cell
    }
    

  
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        genres[indexPath.row].isChosen = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
         genres[indexPath.row].isChosen = false
    }
    
    func retrieveGenres(){
        do{
            if let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en-US") {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        do {
                            let genres = try JSONDecoder().decode(Genres.self, from: data)
    
                            for genre in genres.genres{
                                self.genres.append(ChosenGenres.init(name: genre.name, isChosen: false, id: genre.id))
                            }
                        
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                
                            }
                        } catch let error {
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
    
    @IBAction func doneButtonWasPressed(_ sender: Any) {
      
        // FIRST USER PICKS
        if hasFirstUserChoosen == false{
        for genre in genres{
            if genre.isChosen == true{
                firstUserGenres.append(genre.id)
            }
        }
        // FIRST USER DIDN'T PICK ANYTHING
        if firstUserGenres.isEmpty{
            print("First user didn't choose!")
        }else{
        //FIRST USER PICKED, PROCEED TO THE SECOND USER
            hasFirstUserChoosen = true
           
            // SETS ARRAY THAT IS USED FOR TABLEVIEW, SO SECOND USER DIDN'T CHOOSE ANYTHING BY DEFAULT
            var i = 0
            while i < genres.count{
                genres[i].isChosen = false
                i+=1
            }
            
            tableView.reloadData()
            user1Button.isEnabled = false
            user2Button.isEnabled = true
            }
        }
        // SECOND USER PICKS
        else if hasSecondUserChosen == false{
            for genre in genres{
                if genre.isChosen == true{
                    secondUserGenres.append(genre.id)
                }
            }
        // SECOND USER DIDN'T PICK ANYTHING
            if secondUserGenres.isEmpty{
                print("Second user didn't choose!")
            }else{
        // SECOND USER PICKED, PROCEED TO RESULTS
                hasSecondUserChosen = true
                tableView.reloadData()
                user1Button.isEnabled = false
                user2Button.isEnabled = false
                nextButtonPressed.setTitle("See results", for: .normal)
            }
        }
        else{
        // SEGUE WHEN EVERYONE PICKED
            print("Everyone got picks")
            performSegue(withIdentifier: "goToMainScreen", sender: nil)
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ViewController else
        {
            return
        }
        destination.firstUserGenres = firstUserGenres
        destination.secondUserGenres = secondUserGenres
        destination.hasFirstUserGotPicks = true
        destination.hasSecondUserGotPicks = true
    }
}
