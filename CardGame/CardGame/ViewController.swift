//
//  ViewController.swift
//  CardGame
//
//  Created by Yaqi Wang on 10/8/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerCard1_1: UIImageView!
    @IBOutlet weak var playerCard1_2: UIImageView!
    @IBOutlet weak var playerCard1_3: UIImageView!
    @IBOutlet weak var playerCard2_1: UIImageView!
    @IBOutlet weak var playerCard2_2: UIImageView!
    @IBOutlet weak var playerCard2_3: UIImageView!

    @IBOutlet weak var lblWinner: UILabel!
    // TODO: optimize by append
    var gameStart : Bool = true;
    var playerCards1 = Set<String>();
    var playerCards2 = Set<String>();
    var card2_1: Int = -1;
    var card2_2: Int = -1;
    var card2_3: Int = -1;
    var dice2Value: Int = -1;
    let cards = ["AC", "AD", "AH", "AS", "2C", "2D", "2H", "2S", "3C", "3D", "3H", "3S", "4C", "4D", "4H", "4S", "5C", "5D", "5H", "5S", "6C", "6D", "6H", "6S", "7C", "7D", "7H", "7S", "8C", "8D", "8H", "8S", "9C", "9D", "9H", "9S", "10C", "10D", "10H", "10S", "JC", "JD", "JH", "JS", "QC", "QD", "QH", "QS", "KC", "KD", "KH", "KS"];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func play(_ sender: UIButton) {
        if(!gameStart) {
            populateAlert();
        }
        if(!gameStart) {
            return;
        }
        playerCards1 = Set<String>();
        playerCards2 = Set<String>();
        
        getCards();
        setCards();
        
        var findWinner : Bool = false;
        if playerCards1.contains("AS") {
            lblWinner.text = "Player 1 Win";
            findWinner = true;
        } else if playerCards2.contains("AS") {
            lblWinner.text = "Player 2 Win";
            findWinner = true;
        } else {
            lblWinner.text = "No Winner";
        }
        
        if findWinner {
            populateAlert();
        }
    }
    
    func setCards() {
        let cardArr1 = [playerCard1_1, playerCard1_2, playerCard1_3];
        let cardArr2 = [playerCard2_1, playerCard2_2, playerCard2_3];
        var index : Int = 0;
        for name in playerCards1 {
            cardArr1[index]?.image = UIImage(named: name);
            index += 1;
        }
        index = 0;
        for name in playerCards2 {
            cardArr2[index]?.image = UIImage(named: name);
            index += 1;
        }
    }
    
    func populateAlert() {
        let alert = UIAlertController(title: "Play Again", message: "Do you want to play again?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.playerCard1_1.image = UIImage(named: "green_back");
            self.playerCard1_2.image = UIImage(named: "green_back");
            self.playerCard1_3.image = UIImage(named: "green_back");
            self.playerCard2_1.image = UIImage(named: "yellow_back");
            self.playerCard2_2.image = UIImage(named: "yellow_back");
            self.playerCard2_3.image = UIImage(named: "yellow_back");
            self.lblWinner.text = "No Winner";
            self.gameStart = true;
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
            self.gameStart = false;
        }))

        self.present(alert, animated: true)
    }
    
    
    func getCards() {
        while(playerCards1.count < 3) {
            let index = Int.random(in: 0..<52);
            playerCards1.insert(cards[index]);
        }
        
        while(playerCards2.count < 3) {
            let index = Int.random(in: 0..<52);
            if !playerCards1.contains(cards[index]) {
                playerCards2.insert(cards[index]);
            }
        }
    }

}
