//
//  triviaQuestion.swift
//  triviaGameIOS
//
//  Created by Cameron Hurt on 10/19/18.
//  Copyright © 2018 Cameron Hurt. All rights reserved.
//

import Foundation

class TriviaQuestion {
    var question: String
    var answers: [String]
    var correctAnswerIndex: Int
    var correctAnswer: String {
        return answers[correctAnswerIndex]
    }
    
   init(question: String, answers:[String], correctAnswerIndex: Int) {
        self.answers = answers
    self.question = question
    self.correctAnswerIndex = correctAnswerIndex
    }
    
    
}
