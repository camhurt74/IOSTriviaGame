//
//  ViewController.swift
//  triviaGameIOS
//
//  Created by Cameron Hurt on 10/18/18.
//  Copyright © 2018 Cameron Hurt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    
    @IBOutlet weak var answerAButton: UIButton!
    
    @IBOutlet weak var answerBButton: UIButton!
    
    @IBOutlet weak var answerCButton: UIButton!
    
    @IBOutlet weak var answerDButton: UIButton!
    
   
    
    
    
    var questions = [TriviaQuestion]()
    var questionsplaceholder = [TriviaQuestion]()
    var currentIndex: Int!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var currentQuesiton: TriviaQuestion! {
        didSet {
            if let currentQuestion = currentQuesiton {
                questionLabel.text = currentQuestion.question
                answerAButton.setTitle(currentQuestion.answers[0], for: .normal)
                answerBButton.setTitle(currentQuestion.answers[1], for: .normal)
                answerCButton.setTitle(currentQuestion.answers[2], for: .normal)
                answerDButton.setTitle(currentQuestion.answers[3], for: .normal)
                setNewColor()
                
            }
        }
    }
    
    func getNewQuestion() {
        if questions.count > 0 {
            currentIndex = Int.random(in: 0..<questions.count )
            currentQuesiton = questions[currentIndex]
        } else {
            showGameOver()
            
            sleep(1)
            resetGame()
        }
    }
    func showGameOver() {
        let gameOver = UIAlertController(title: "Game over", message: "Your score is \(self.score) out of a possible \(self.questionsplaceholder.count)", preferredStyle: .actionSheet)
        let overAction = UIAlertAction(title: "Thank you for playing", style: UIAlertAction.Style.default)
        
        gameOver.addAction(overAction)
        self.present(gameOver, animated: true, completion: nil)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        populateQuestions()
        getNewQuestion()
        
        setNewColor()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func populateQuestions() {
        let question1 = TriviaQuestion(question: "How many NBA Championships Have The Lakers won?", answers: ["18", "16", "17", "20"], correctAnswerIndex: 1)
        let question2 = TriviaQuestion(question: "Who is the all-time scoring leader in NBA History", answers: ["Michael Jordan","Lebron James","Kareem-Abdul Jabbar","Kobe Bryant"], correctAnswerIndex: 2)
        let question3 = TriviaQuestion(question: "Who is the greatest Laker Of All Time?", answers: ["Lebron James","Kobe Bryant","Kareem-Abdul Jabbar","Magic Johnson"], correctAnswerIndex: 0)
        questions = [question1, question2, question3]
    }
    
    let backgroundColors = [
        UIColor(red: 85/255, green: 37/255, blue: 130/255, alpha: 1.0),
        UIColor(red: 253/255, green: 185/255, blue: 39/255, alpha: 1.0)]
    
    func setNewColor() {
        let randomnumber = Int.random(in: 1...100)
        let randomColorY = backgroundColors[randomnumber % 2]
        let randomColorP = backgroundColors[(randomnumber + 1) % 2]
       
        answerAButton.backgroundColor = randomColorP
        answerBButton.backgroundColor = randomColorY
        answerCButton.backgroundColor = randomColorP
        answerDButton.backgroundColor = randomColorY
   view.backgroundColor = UIColor.black
    }
    
    
    @IBAction func unwindToQuizScreen(segue: UIStoryboardSegue){}
    
    @IBOutlet weak var questionTitle: UILabel!
    
    @IBAction func answerTapped(_ sender: UIButton) {
       if questions.count > 0 {
        if currentQuesiton.correctAnswerIndex == sender.tag {
            score += 1
            showCorrectAnswerAlert()
        } else {
            showIncorrectAnswerAlert()
        }
    }
    }
    func showCorrectAnswerAlert() {
        let correctAlert = UIAlertController(title: "correct", message: "\(currentQuesiton.correctAnswer) is the correct answer! good work!!!", preferredStyle: .actionSheet)
        let badAction = UIAlertAction(title: "Thank You!", style: UIAlertAction.Style.default) { UIAlertAction in
            self.questionsplaceholder.append(self.questions[self.currentIndex])
            self.questions.remove(at: self.currentIndex)
            self.getNewQuestion()
            
            
        }
        correctAlert.addAction(badAction)
        self.present(correctAlert, animated: true, completion: nil)
    }
    func showIncorrectAnswerAlert() {
        let incorrectAlert = UIAlertController(title: "incorrect", message: "\(currentQuesiton.correctAnswer) is the answer I'm looking for. ", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "...sorry", style: UIAlertAction.Style.default) { UIAlertAction in
            self.questionsplaceholder.append(self.questions[self.currentIndex])
            self.questions.remove(at: self.currentIndex)
            self.getNewQuestion()
    }
        incorrectAlert.addAction(okayAction)
        self.present(incorrectAlert, animated: true, completion: nil)
        

    
}
    func resetGame() {
        score = 0
        if !questions.isEmpty {
            questionsplaceholder.append(contentsOf: questions)
            questions.removeAll()
        }
        questions = questionsplaceholder
        questionsplaceholder.removeAll()
        getNewQuestion()
        
    }
    
    @IBAction func resetButton(_ sender: Any) {
        resetGame()
    }
}
