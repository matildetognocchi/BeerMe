//
//  ViewController.swift
//  BeerMeUiKit
//
//  Created by Matilde Tognocchi on 29/1/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var beerNameView: UILabel!
    
    @IBOutlet weak var beerImageView: UIImageView!
    
    @IBOutlet weak var beerBrandNameView: UILabel!
    
    @IBOutlet weak var alcholPercentageView: UILabel!
    
    @IBOutlet weak var beerStyleView: UILabel!
    
    @IBOutlet weak var beerMaltsView: UILabel!
    
    
    var beer: BeerModel = BeerModel(id: 0, uid: "", brand: "", name: "", style: "", hop: "", yeast: "", malts: "", ibu: "", alcohol: "", blg: "")
  
    let notFoundImage = UIImage(resource: ._404ImageNotFound)
        
    @IBAction func newBeerButton(_ sender: Any) {
        getBeers()
    }
    
    func getBeers() {
        print("inizio di getBeers")
        guard let url = URL(string: "https://random-data-api.com/api/v2/beers") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            print("dentro la closure")
            guard let data = data else {
                print("no data")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Response error")
                return
            }
            
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("response status code non compreso nel range 200-299")
                return
            }
            
            guard error == nil else {
                print("Si è verificato un errore")
                return
            }
            
            print("dati scaricati correttamente")
            print(data)
            
            do {
                let newBeer = try JSONDecoder().decode(BeerModel.self, from: data)
                DispatchQueue.main.async {
                    self.updateUI(with: newBeer)
                }
            } catch {
                print("Errore durante la decodifica: \(error)")
            }
        }
        task.resume()
        print("fine di getBeers")
        
    }
    
    private func updateUI(with beer: BeerModel) {
        beerImageView.image = notFoundImage
        beerNameView.text = beer.name
        beerBrandNameView.text = beer.style
        alcholPercentageView.text = beer.alcohol
        beerStyleView.text = beer.style
        beerMaltsView.text = beer.malts
    }
}

