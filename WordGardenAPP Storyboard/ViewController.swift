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
    
    var wordsToGuess = ["SWIFT", "DOG", "CAT"]
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
            wordToGuess.count-1)
        updateGameStatusLabels()
    }
    
    func updateUIAfterGuess () {
        guessedLetterTextField.resignFirstResponder()
        guessedLetterTextField.text! = ""
        guessALetterButton.isEnabled = false
    }
    
    
    func formatRevealedWord() {
        var revealedWord = ""
          
          // loop through all letters in wordToGuess
          for letter in wordToGuess {
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
    
    func updateWinOrLose(){
        // what do we do if game over?
        // - increment currentWordIndex by 1
        // - disable guessALetterTextField
        // - diable guessALetterButton
        // set playAgainButton .isHidden to false
        // - update all labels at top of screen
        
        currentWordIndex += 1
        guessedLetterTextField.isEnabled = false
        guessALetterButton.isEnabled = false
        playAgainButton.isHidden = false
        
        updateGameStatusLabels()
    }
    
    func updateGameStatusLabels(){
        //update labels at top of screen
        wordsGuessedLabel.text = "Words Guessed: \(wordsGuessedCount)"
        wordsMissedLabel.text = "Words Missed: \(wordsMissedCount)"
        wordsRemainingLabel.text = "Words to Guess: \(wordsToGuess.count - (wordsGuessedCount + wordsMissedCount))"
        wordsInGameLabel.text = "Words in Game: \(wordsToGuess.count)"
    }
    
    func guessALetter () {
        //get current letter guessed and add it to all lettersGuessed
        let currentLetterGuessed = guessedLetterTextField.text!
        lettersGuessed = lettersGuessed + currentLetterGuessed
        
        formatRevealedWord()
        
        // update image, if needed, and keep track of wrong guesses
        if wordToGuess.contains(currentLetterGuessed) == false {
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named:
                "flower\(wrongGuessesRemaining)")
        }
        
        // update gameStatusMessageLabel
          guessCount += 1
//        var guesses = "Guesses"
//        if guessCount == 1 {
//            guesses = "Guess"
//        }
        let guesses = (guessCount == 1 ? "Guess" : "Guesses")
        gameStatusMessageLabel.text = "You've Made \(guessCount) \(guesses)"
        
        // Check for win and lose
        if wordBeingRevealedLabel.text!.contains("_") == false {
            gameStatusMessageLabel.text = "You've guessed it! It took you \(guessCount) guesses to guess the word."
            wordsGuessedCount += 1
            updateWinOrLose()
        } else if wrongGuessesRemaining == 0 {
            gameStatusMessageLabel.text = "So sorry, You're all out of guesses."
            wordsMissedCount += 1
            updateWinOrLose()
        }
        
        // check to see if you've played all the words. If so, update the message indicating the player can restart the entire game.
        if currentWordIndex == wordsToGuess.count {
            gameStatusMessageLabel.text! += "\n\nYou've tried all of the words! Restart from the begining?"
        }
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
        // if al words have been guessed and you select playAgain, the restart all games as if the app has been restarted
        if currentWordIndex == wordToGuess.count {
            currentWordIndex = 0
            wordsGuessedCount = 0
            wordsMissedCount = 0
        }
        
        playAgainButton.isHidden = true
        guessedLetterTextField.isEnabled = true
        guessALetterButton.isEnabled = false // don't turn true until character is in the text field
        wordToGuess = wordsToGuess[currentWordIndex]
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        // created word with underscores, one for each space
        wordBeingRevealedLabel.text = "_" + String(repeating: " _", count: wordToGuess.count-1)
        guessCount = 0
        flowerImageView.image = UIImage(named: "flower\(maxNumberOfWrongGuesses)")
        lettersGuessed = ""
        gameStatusMessageLabel.text = "You've Made Zero Guesses"
    }
    
    //Up to this point, code works well 3.0
    //Error with the letter count when playing the game
    // Revised CH 3.7, besides that error, ready to move to CH 3.8

}
