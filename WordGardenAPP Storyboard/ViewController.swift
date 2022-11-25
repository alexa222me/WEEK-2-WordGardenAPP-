//
//  ViewController.swift
//  WordGardenAPP Storyboard
//
//  Created by Alexa Mendoza on 11/14/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var wordsGuessedLabel: UILabel!
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    @IBOutlet weak var wordsMissedLabel: UILabel!
    @IBOutlet weak var wordsInGame: UILabel!
    
    @IBOutlet weak var wordBeingRevealedLabel: UILabel!
    @IBOutlet weak var guessedLetterTextField: UITextField!
    @IBOutlet weak var guessALetterButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var gameStatusMessageLabel: UILabel!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let text = guessedLetterTextField.text!
        guessALetterButton.isEnabled = !(text.isEmpty)

    }
    
    func updateUIAfterGuess () {
        guessedLetterTextField.resignFirstResponder()
        guessedLetterTextField.text! = ""
        guessALetterButton.isEnabled = false
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        let text = guessedLetterTextField.text!
        guessALetterButton.isEnabled = !(text.isEmpty)
    }
    

    @IBAction func doneKeyPressed(_ sender: UITextField) {
        //This Dismisses the keyboard
       updateUIAfterGuess()
}
    
    @IBAction func guessALetterButtonPressed(_ sender: UIButton) {
        //This Dismisses the keyboard
       updateUIAfterGuess()

    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
    }
    
    //Up to this point, code works well 3.0

}
