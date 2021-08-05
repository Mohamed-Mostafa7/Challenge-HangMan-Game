//
//  ViewController.swift
//  Challenge HangMan Game
//
//  Created by Mohamed Mostafa on 11/07/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var wordsModel = WordsModel()
    var word: String = ""
    var writeAnswer: String = ""
    var starWord: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordsModel.getWords()
        newWord()
    }
    
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var guessLabel: UILabel!
    @IBOutlet var mistakesProgresBar: UIProgressView!
    @IBOutlet var lettersButtons: [UIButton]!
 
    // MARK: - letter pressed func
    @IBAction func letterPressed(_ sender: UIButton) {
        sender.isEnabled = false
        sender.backgroundColor = UIColor.gray
        let letter = Character(sender.currentTitle!)
        
        checkLetter(letter)
        
    }
    
    // MARK: - new Word func
    func newWord() {
        if let newWord = wordsModel.words.randomElement() {
            print(newWord)
            starWord = ""
            mistakesProgresBar.progress = 0
            writeAnswer = newWord
            word = newWord.uppercased()
            for _ in word {
                starWord += "*"
            }
            if word.contains(" ") {
                let index = word.firstIndex(of: " ")!
                starWord.changeLetter(letter: " ", index: index)
            }
            wordLabel.text = starWord
        }
        for i in lettersButtons {
            i.backgroundColor = .clear
            i.isEnabled = true
        }
    }
    
    func checkLetter(_ letter: Character) {
        if word.contains(letter) {
            let index = word.firstIndex(of: letter)!
            starWord.changeLetter(letter: letter, index: index)
            wordLabel.text = starWord
            if !starWord.contains("*"){
                youWon()
            }
            word.changeLetter(letter: "*", index: index)
            if word.contains(letter) {
                checkLetter(letter)
            }
        }else {
            mistakesProgresBar.progress += 1/7
            
            if mistakesProgresBar.progress == 1 {
                youLost()
            }
        }
    }
    
    func youWon() {
        let ac = UIAlertController(title: "Good work!", message: "try to guess more words", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "ok", style: .default) { _ in
            self.newWord()
        }
        ac.addAction(action)
        present(ac, animated: true)
        animateBackground(color: .green)
    }
    
    func youLost() {
        guessLabel.text = writeAnswer
        guessLabel.textColor = .red
        let ac = UIAlertController(title: "Ouch, You didn't get it!", message: "I's ok, you can try again", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "ok", style: .default) { _ in
            self.guessLabel.textColor = .darkGray
            self.guessLabel.text = "guess the word"
            self.newWord()
        }
        ac.addAction(action)
        present(ac, animated: true)
        animateBackground(color: .red)
    }
    
    func animateBackground(color: UIColor){
        
        let duration = 0.2
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .allowUserInteraction) {
            self.view.backgroundColor = color
        } completion: { _ in
            UIView.animateKeyframes(withDuration: 0.5, delay: duration, options: .allowUserInteraction) {
                self.view.backgroundColor = .white
            }
        }
        
        
        
    }
}


extension String {
    mutating func changeLetter(letter: Character, index: String.Index) {
        self.remove(at: index)
        self.insert(letter, at: index)
    }
}

