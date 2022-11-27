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
    @IBOutlet weak var wordsInGameLabel: UILabel!
    
    @IBOutlet weak var wordBeingRevealedLabel: UILabel!
    @IBOutlet weak var guessedLetterTextField: UITextField!
    @IBOutlet weak var guessALetterButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var gameStatusMessageLabel: UILabel!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    var wordsToGuess = ["SWITF", "DOG", "CAT"]
    var currentWordIndex = 0
    var wordToGuess = ""
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var wordsGuessedCount = 0
    var wordsMissedCount = 0
    var guessCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let text = guessedLetterTextField.text!
        guessALetterButton.isEnabled = !(text.isEmpty)
        wordToGuess = wordsToGuess[currentWordIndex]
        wordBeingRevealedLabel.text = "_" + String(repeating: " _", count:
            wordsToGuess.count-1)
    }
    
    func updateUIAfterGuess () {
        guessedLetterTextField.resignFirstResponder()
        guessedLetterTextField.text! = ""
        guessALetterButton.isEnabled = false
    }
    
    
    func formatRevealedWord() {
        var revealedWord = ""
          
          // loop through all letters in wordToGuess
          for letter in wordsToGuess {
              // check if letter in wordToGuess is in letterGuessed (i.e. did you guess this letter already?)
              if lettersGuessed.contains(letter) {
                  //if so, add this letter + a blank space, to revealedWord
                  revealedWord = revealedWord + "\(letter)"
              } else {
                  // if not, add an underscore + a blank space, to revealedWord
                  revealedWord = revealedWord + "_ "
              }
          }
      // remove the extra space at the end of revealedWord
      revealedWord.removeLast()
          wordBeingRevealedLabel.text = revealedWord
    }
    
    func guessALetter () {
        //get current letter guessed and add it to all lettersGuessed
        let currentLetterGuessed = guessedLetterTextField.text!
        lettersGuessed = lettersGuessed + currentLetterGuessed
        
        formatRevealedWord()
        
        // update image, if needed, and keep track of wrong guesses
        if wordsToGuess.contains(currentLetterGuessed) == false {
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named:
                "flower\(wrongGuessesRemaining)")
        }
        
        // update gameStatusMessageLabel
        guessCount += 1
        var guesses = "Guesses"
        if guessCount == 1 {
            guesses = "Guess"
        }
        gameStatusMessageLabel.text = "You've Made \(guessCount) \(guesses)"
    }

    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        sender.text = String(sender.text?.last ?? " ").trimmingCharacters(in:
                .whitespaces)
        guessALetterButton.isEnabled = !(sender.text!.isEmpty)
    }
    

    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        //This Dismisses the keyboard
       updateUIAfterGuess()
}
    
    @IBAction func guessALetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        //This Dismisses the keyboard
       updateUIAfterGuess()

    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
    }
    
    //Up to this point, code works well 3.0
    //saved, there is a weird error // FIXED THE WEIRD ERROR
    // Revised CH 3.5

}
