//
//  QuestionDetailViewController.swift
//  QuizApp
//

import UIKit

class QuestionDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionsStackView: UIStackView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var showAnswerButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    
    // MARK: - Properties
    var questions: [Question] = []
    var currentIndex = 0
    
    private var optionButtons: [UIButton] = []
    private var currentQuestion: Question {
        return questions[currentIndex]
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayQuestion()
    }
    
    private func setupUI() {
        title = "Question \(currentIndex + 1)/\(questions.count)"
        
        // Bookmark button
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "bookmark"),
            style: .plain,
            target: self,
            action: #selector(toggleBookmark)
        )
        
        // Answer label hidden initially
        answerLabel.isHidden = true
        answerLabel.layer.cornerRadius = 8
        answerLabel.clipsToBounds = true
        
        // Show answer button style
        showAnswerButton.layer.cornerRadius = 8
        
        // Navigation buttons
        updateNavButtons()
        
        // Create option buttons
        for letter in ["A", "B", "C", "D"] {
            let button = UIButton(type: .system)
            button.setTitle("\(letter). ", for: .normal)
            button.contentHorizontalAlignment = .left
            button.titleLabel?.numberOfLines = 0
            button.backgroundColor = .systemGray6
            button.layer.cornerRadius = 8
            button.tag = letter.first?.asciiValue.map { Int($0) } ?? 0
            
            button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
            
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            optionsStackView.addArrangedSubview(button)
            optionButtons.append(button)
        }
    }
    
    private func displayQuestion() {
        // Update title
        title = "Question \(currentIndex + 1)/\(questions.count)"
        progressLabel.text = "\(currentIndex + 1)/\(questions.count)"
        
        // Display question
        questionLabel.text = currentQuestion.questionText
        
        // Display options
        for (index, button) in optionButtons.enumerated() {
            if index < currentQuestion.options.count {
                let option = currentQuestion.options[index]
                button.setTitle(option, for: .normal)
                button.isHidden = false
            } else {
                button.isHidden = true
            }
        }
        
        // Reset UI
        answerLabel.isHidden = true
        showAnswerButton.isHidden = false
        optionButtons.forEach { $0.backgroundColor = .systemGray6 }
        
        // Update bookmark icon
        let bookmarkImage = currentQuestion.isBookmarked ? "bookmark.fill" : "bookmark"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: bookmarkImage)
        navigationItem.rightBarButtonItem?.tintColor = currentQuestion.isBookmarked ? .orange : nil
        
        updateNavButtons()
    }
    
    private func updateNavButtons() {
        prevButton.isEnabled = currentIndex > 0
        nextButton.isEnabled = currentIndex < questions.count - 1
    }
    
    // MARK: - Actions
    @objc private func optionTapped(_ sender: UIButton) {
        // Highlight selected option
        optionButtons.forEach { $0.backgroundColor = .systemGray6 }
        sender.backgroundColor = .systemBlue.withAlphaComponent(0.3)
        
        // Check answer if user wants to
        if let title = sender.titleLabel?.text,
           let firstChar = title.first {
            let selectedLetter = String(firstChar)
            if selectedLetter == currentQuestion.correctAnswer {
                // Correct answer
                sender.backgroundColor = .systemGreen.withAlphaComponent(0.3)
            }
        }
    }
    
    @IBAction func showAnswerTapped(_ sender: UIButton) {
        answerLabel.text = "✅ Correct answer: \(currentQuestion.correctAnswer)"
        answerLabel.isHidden = false
        sender.isHidden = true
        
        // Highlight correct answer
        for button in optionButtons {
            if let title = button.titleLabel?.text,
               let firstChar = title.first,
               String(firstChar) == currentQuestion.correctAnswer {
                button.backgroundColor = .systemGreen.withAlphaComponent(0.3)
            }
        }
    }
    
    @IBAction func prevTapped(_ sender: UIButton) {
        if currentIndex > 0 {
            currentIndex -= 1
            displayQuestion()
        }
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
            displayQuestion()
        }
    }
    
    @objc private func toggleBookmark() {
        questions[currentIndex].isBookmarked.toggle()
        
        // Update local storage
        var allQuestions = QuizDataManager.shared.loadQuestions()
        if let index = allQuestions.firstIndex(where: { $0.id == currentQuestion.id }) {
            allQuestions[index].isBookmarked = currentQuestion.isBookmarked
            _ = QuizDataManager.shared.saveQuestions(allQuestions)
        }
        
        // Update icon
        let bookmarkImage = currentQuestion.isBookmarked ? "bookmark.fill" : "bookmark"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: bookmarkImage)
        navigationItem.rightBarButtonItem?.tintColor = currentQuestion.isBookmarked ? .orange : nil
    }
}
