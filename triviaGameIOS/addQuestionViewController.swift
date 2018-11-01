//
//  addQuestionViewController.swift
//  triviaGameIOS
//
//  Created by Cameron Hurt on 10/19/18.
//  Copyright © 2018 Cameron Hurt. All rights reserved.
//

import UIKit

class addQuestionViewController: UIViewController {
    
    @IBOutlet weak var newQuestionTextfield: UITextField!
    
    @IBOutlet weak var answerATextfield: UITextField!
    
    @IBOutlet weak var answerBTextfield: UITextField!
    
    @IBOutlet weak var answerCTextfield: UITextField!
    
    @IBOutlet weak var answerDTextfield: UITextField!
    
    @IBOutlet weak var correctAnswerSelector: UISegmentedControl!
    var newTriviaQuestion: TriviaQuestion?
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
         let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(sender:)))
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard(sender: UITapGestureRecognizer?) {
        view.endEditing(true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func addTapped(_ sender: Any) {
        
       
        
        guard let question = newQuestionTextfield.text, !question.isEmpty,
            let a = answerATextfield.text, !a.isEmpty,
            let b = answerBTextfield.text, !b.isEmpty,
            let c = answerCTextfield.text, !c.isEmpty,
            let d = answerDTextfield.text, !d.isEmpty
            
        else {
            
            return
        }
     newTriviaQuestion = TriviaQuestion(question: question, answers: [a,b,c,d], correctAnswerIndex: correctAnswerSelector.selectedSegmentIndex)
        
        performSegue(withIdentifier: "unwindToQuizScreen", sender: self)
        
        
        
    
    
}
    override func prepare(for Segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destinationVC = Segue.destination as? ViewController,
        let newTrivia = newTriviaQuestion
            else {
                return
        }
        destinationVC.questions.append(newTrivia)
        destinationVC.resetGame()
    }
    
    
    
    @IBAction func backToScreen(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToQuizScreen", sender: self)
    }
}

