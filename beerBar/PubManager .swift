import Foundation
class PubManager {
    var totalSeld = 0.0
    var margin = 0.0
    private init() {}
    static let shared = PubManager()
    
    var beers = [
        Beer(name: "Staropramen", country: "🇨🇿", remain: 5, price:10),
        Beer(name: "Paulaner", country: "🇩🇪", remain: 5, price:15),
        Beer(name: "Stella Artois", country: "🇧🇪", remain: 5, price: 5)
    ]
    
    func bayBeer(index:Int,volume:Double) -> Double {
        if volume > beers[index].remain{ return 0}
        beers[index].remain -= volume
        
        let price = volume * Double(PubManager.shared.beers[index].price)
        
        totalSeld += volume
        totalSeld = round(totalSeld)
        margin += price
        margin = round(margin)
        beers[index].remain = round(beers[index].remain)
        return round(price)
    }
    
    func round(_ num: Double) -> Double {
        var res = num * 100
        res += 0.5
        return Double(Int(res)) / 100
    }
    func newDay()  {
        totalSeld = 0.0
        margin = 0.0
        for index in beers.indices {
            beers[index].remain = 5 
        }
        
        //beersremains.forEach{$0.text! = "Остаток\n150Л"}
    }

}

