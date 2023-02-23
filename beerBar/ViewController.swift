//
//  ViewController.swift
//  beerBar
//
//  Created by Iosif Dubikovski on 2/5/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var beerNames: [UILabel]!
    
    @IBOutlet weak var margin: UILabel!
    
    @IBOutlet var remains: [UILabel]!
    
    @IBOutlet var beerCountres: [UILabel]!
    
    @IBOutlet weak var totalSelled: UILabel!
    
    @IBAction func startNewDay(_ sender: Any) {
        PubManager.shared.newDay()
        updateSelled()
        updateMargin()
        updateRemains(for: 0)
        updateRemains(for: 1)
        updateRemains(for: 2)
    }
    
    func updateRemains (for index: Int){
        let volume = PubManager.shared.beers[index].remain
        remains[index].text = "Остаток\n\(volume)Л"
        
    }
    func updateMargin() {
        let newMargin = PubManager.shared.margin
        margin.text = "Выручка за день: \(newMargin)$"
    }
    func updateSelled(){
        let newTotalSeld = PubManager.shared.totalSeld
        totalSelled.text = "Продано пива: \(newTotalSeld)Л"
    }
    func showAlert(withPrice price: Double) {
        if price < 0.01 {
            showAlert(withTitle: "Неудачная покупка", mesege: "Пиво закончилось")
        }else  {
            showAlert(withTitle: "Удачная покупка", mesege: "Сумма покупки \(price)$")
        }
    }
    func showAlert(withTitle title: String,mesege:String) {
        let alert = UIAlertController(title: title, message: mesege, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert,animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    @IBAction func buyBeer(_ sender: UIButton) {
        
        let tag = sender.tag
        var beerIndex = sender.tag
        var volume = 0.1
        switch tag % 10 {
        case 0:
            volume = 0.33
        case 1:
            volume = 0.5
        case 2:
            volume = 1.0
        default:
            volume = 0
        }
        switch tag / 10 {
        case 0:
            beerIndex = 0
        case 1:
            beerIndex = 1
        case 2:
            beerIndex = 2
        default:
            beerIndex = 0
        }
        
        let price = PubManager.shared.bayBeer(index: beerIndex, volume: volume)
        updateMargin()
        updateSelled()
        updateRemains(for: beerIndex)
        showAlert(withPrice: price)
    }
    func initView(){
        for index in 0..<PubManager.shared.beers.count{
            beerNames[index].text = PubManager.shared.beers[index].name
            beerCountres[index].text = PubManager.shared.beers[index].country
            updateRemains(for:index)
        }
    }
}

