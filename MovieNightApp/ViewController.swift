//
//  ViewController.swift
//  MovieNightApp
//
//  Created by Dzmitry Matsiulka on 9/7/19.
//  Copyright © 2019 Dzmitry M. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstUserImage: UIButton!
    @IBOutlet weak var secondUserImage: UIButton!
    @IBOutlet weak var viewResultsButton: UIButton!
    
    
    
    var firstUserGenres : [Int]?
    var secondUserGenres : [Int]?
    var commonGenres = [Int]()
    
    var hasFirstUserGotPicks = false
    var hasSecondUserGotPicks = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewResultsButton.isEnabled = false
        // Do any additional setup after loading the view.
        if hasSecondUserGotPicks == true && hasFirstUserGotPicks == true{
          
            print(firstUserGenres!)
            print(secondUserGenres!)
            
            firstUserImage.setImage(UIImage(named: "bubble-selected"), for: .normal)
            secondUserImage.setImage(UIImage(named: "bubble-selected"), for: .normal)
            
            commonGenres = firstUserGenres!.filter () { secondUserGenres!.contains($0) }
            
            print("Common genres: \(commonGenres)")
            
            viewResultsButton.isEnabled = true
            firstUserImage.isEnabled = false
            secondUserImage.isEnabled = false
            
            
        }
        
        
    }

    @IBAction func viewResultsButtonPressed(_ sender: Any) {
        if commonGenres.isEmpty{
            
            let noCommonGenresAlert = UIAlertController(title: "No common genres found", message: "To show you options both users have to have at least one common genre. Please try again", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Do it again", style: .default) { (action:UIAlertAction) in
                self.performSegue(withIdentifier: "toPicking", sender: nil)
            }
            noCommonGenresAlert.addAction(action1)
            self.present(noCommonGenresAlert, animated: true, completion: nil)
            
            
        }else{
            performSegue(withIdentifier: "viewResults", sender: nil)
        }
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ResultsViewController else
        {
            return
        }
        destination.genresToLookUp = commonGenres
    }

}

