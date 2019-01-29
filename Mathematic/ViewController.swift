import UIKit

class ViewController: UIViewController {
    var a = Int.random(in: 1...100)
    var b = Int.random(in: 1...100)
    var currentOperation: Operation = .plus
    
    enum Operation {
        case plus
        case minus

        func stringValue() -> String {
            switch self {
            case .plus:
                return "+"
            case .minus:
                return "-"
            }
        }
        
        static func randomOperation() -> Operation {
            let randowInt = Int.random(in: 0...1)
            switch randowInt {
            case 0:
                return .plus
            case 1:
                return .minus
            default:
                return .plus
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentOperation = Operation.randomOperation()
        questionLabel.text = String(a) + currentOperation.stringValue() + String(b)
    }

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    @IBAction func numberButonTapped(_ sender: UIButton) {
        guard let char = sender.titleLabel?.text else { return }
        guard let answer = answerLabel.text else { return }
        answerLabel.text = char == "-" ? answer.first == "-" ? String(answer.dropFirst()) : char + answer : answer + char
        checkButton.isEnabled = true
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        let c: Int
        switch currentOperation {
        case .plus:
            c = a + b
        case .minus:
            c = a - b
        }
        guard let answer = answerLabel.text else { return }
        let isAnswerCurrect = Int(answer) == c
        let title = isAnswerCurrect ? "Правильно!" : "Вы ошиблись!"
        let message = isAnswerCurrect ? "Хотите повторить?" : "Правильный ответ = \(c). Хотите повторить?"
        showAlert(withTitle: title, message: message)
    }
    
    @IBAction func deleteChar(_ sender: UIButton) {
        guard let answer = answerLabel.text?.dropLast() else { return }
        answerLabel.text = String(answer)
        checkButton.isEnabled = !String(answer).isEmpty
    }
    
    fileprivate func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Конечно!", style: .default) { (_) in
            self.refreshGame()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func refreshGame() {
        self.a = Int.random(in: 1...100)
        self.b = Int.random(in: 1...100)
        self.currentOperation = Operation.randomOperation()
        self.questionLabel.text = String(a) + currentOperation.stringValue() + String(b)
        self.answerLabel.text = ""
        self.checkButton.isEnabled = false
    }
}

