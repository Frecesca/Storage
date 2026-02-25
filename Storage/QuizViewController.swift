import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButtonA: UIButton!
    @IBOutlet weak var answerButtonB: UIButton!
    @IBOutlet weak var answerButtonC: UIButton!
    @IBOutlet weak var answerButtonD: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    private var quizData: QuizData?
    private var allQuestions: [Question] = []      // All questions from storage
    private var currentQuestions: [Question] = []  // Randomly selected 5 questions for current quiz
    private var currentQuestionIndex = 0
    private var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        title = "Quiz"
        
        // Style buttons
        [answerButtonA, answerButtonB, answerButtonC, answerButtonD].forEach { button in
            button?.layer.cornerRadius = 10
            button?.backgroundColor = .systemBlue
            button?.setTitleColor(.white, for: .normal)
        }
        
        // Add Settings button
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Settings",
            style: .plain,
            target: self,
            action: #selector(openSettings)
        )
    }
    
    @objc private func openSettings() {
        // Open iOS Settings app
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    private func loadData() {
        // First try to load from local storage
        if LocalStorageManager.shared.hasLocalData() {
            quizData = LocalStorageManager.shared.loadQuizData()
            if let quizData = quizData {
                print("✅ Loaded all \(quizData.questions.count) questions from local storage")
                allQuestions = quizData.questions
                selectRandomQuestions()
                return
            }
        }
        
        // If no local data, create sample data and save it
        print("⚠️ No local data found, creating sample data")
        quizData = SampleData.createSampleData()
        _ = LocalStorageManager.shared.saveQuizData(quizData!)
        allQuestions = quizData!.questions
        selectRandomQuestions()
    }
    
    // Randomly select 5 questions
    private func selectRandomQuestions() {
        // If total questions are less than or equal to 5, use all
        if allQuestions.count <= 5 {
            currentQuestions = allQuestions
        } else {
            // Randomly select 5 different questions
            currentQuestions = Array(allQuestions.shuffled().prefix(5))
        }
        
        print("🎲 Selected \(currentQuestions.count) random questions for this quiz")
        for (index, question) in currentQuestions.enumerated() {
            print("  \(index + 1). \(question.questionText)")
        }
        
        currentQuestionIndex = 0
        score = 0
        showQuestion()
    }
    
    private func showQuestion() {
        guard currentQuestionIndex < currentQuestions.count else {
            showResult()
            return
        }
        
        let question = currentQuestions[currentQuestionIndex]
        questionLabel.text = question.questionText
        answerButtonA.setTitle(question.answerA, for: .normal)
        answerButtonB.setTitle(question.answerB, for: .normal)
        answerButtonC.setTitle(question.answerC, for: .normal)
        answerButtonD.setTitle(question.answerD, for: .normal)
        
        statusLabel.text = "Question \(currentQuestionIndex + 1) of \(currentQuestions.count)"
        
        // Enable all buttons
        [answerButtonA, answerButtonB, answerButtonC, answerButtonD].forEach { $0?.isEnabled = true }
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        guard let question = currentQuestions[safe: currentQuestionIndex] else { return }
        
        // Disable buttons to prevent multiple answers
        [answerButtonA, answerButtonB, answerButtonC, answerButtonD].forEach { $0?.isEnabled = false }
        
        // Get answer based on button
        var selectedAnswer = ""
        if sender == answerButtonA { selectedAnswer = "A" }
        else if sender == answerButtonB { selectedAnswer = "B" }
        else if sender == answerButtonC { selectedAnswer = "C" }
        else if sender == answerButtonD { selectedAnswer = "D" }
        
        // Check if correct
        if selectedAnswer == question.correctAnswer {
            score += 1
            sender.backgroundColor = .systemGreen
        } else {
            sender.backgroundColor = .systemRed
            // Highlight correct answer
            highlightCorrectAnswer(question.correctAnswer)
        }
        
        // Move to next question after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.currentQuestionIndex += 1
            self.resetButtonColors()
            self.showQuestion()
        }
    }
    
    private func highlightCorrectAnswer(_ correctAnswer: String) {
        switch correctAnswer {
        case "A": answerButtonA.backgroundColor = .systemGreen
        case "B": answerButtonB.backgroundColor = .systemGreen
        case "C": answerButtonC.backgroundColor = .systemGreen
        case "D": answerButtonD.backgroundColor = .systemGreen
        default: break
        }
    }
    
    private func resetButtonColors() {
        [answerButtonA, answerButtonB, answerButtonC, answerButtonD].forEach {
            $0?.backgroundColor = .systemBlue
        }
    }
    
    private func showResult() {
        let alert = UIAlertController(
            title: "Quiz Complete",
            message: "Your score: \(score) out of \(currentQuestions.count)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "New Quiz", style: .default) { _ in
            self.restartQuiz()  // Get new random questions
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        present(alert, animated: true)
    }
    
    // Restart with new random questions
    private func restartQuiz() {
        selectRandomQuestions()  // Select 5 new random questions
        resetButtonColors()
    }
}

// Safe array index extension
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
