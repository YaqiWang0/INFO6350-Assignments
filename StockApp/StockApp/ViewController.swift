//
//  ViewController.swift
//  StockApp
//
//  Created by Yaqi Wang on 11/4/20.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class ViewController: UIViewController {

    @IBOutlet weak var SymbolTXT: UITextField!
    @IBOutlet weak var ceo: UILabel!
    @IBOutlet weak var price: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func GetValue(_ sender: Any) {
        guard let stockName = SymbolTXT.text else { return }
        let url = "\(apiURL)\(stockName)?apikey=\(apiKey)";
        getStockValue(stockURL: url, stockName: stockName);
    }
    
    func getStockValue(stockURL : String!, stockName : String!) {
        SwiftSpinner.show("Getting Stock Value for \(String(describing: stockName))")
        AF.request(stockURL)
            .responseJSON { (response) in
            SwiftSpinner.hide();
            if response.error == nil {
                guard let jsonString = response.data else {return}
                
                guard let stockJSON : [JSON] = JSON(jsonString).array else {return}
                if stockJSON.count < 1 {return}
                guard let symbol = stockJSON[0]["symbol"].rawString() else {return};
                guard let price = stockJSON[0]["price"].double else {return};
                guard let ceo = stockJSON[0]["ceo"].rawString() else {return};

                print(price);
                self.ceo.text = "\(ceo)";
                self.price.text = "$\(price)";
            }
        }
    }
}

