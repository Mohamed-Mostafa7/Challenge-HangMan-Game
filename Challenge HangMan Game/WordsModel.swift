//
//  WordsModel.swift
//  Challenge HangMan Game
//
//  Created by Mohamed Mostafa on 05/08/2021.
//

import Foundation

struct WordsModel {
    
    var words: [String] = []
    
    mutating func getWords() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: ".txt") {
            if let startWord = try? String(contentsOf: startWordsURL) {
                words = startWord.components(separatedBy: "\n")
            }
        }
    }
}
