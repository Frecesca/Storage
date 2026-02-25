import Foundation

struct SampleData {
    static func createSampleData() -> QuizData {
        // MARK: - Create Topics
        let topics = [
            Topic(id: 1, title: "Swift Programming", description: "Test your Swift programming knowledge"),
            Topic(id: 2, title: "iOS Development", description: "iOS development basics and best practices"),
            Topic(id: 3, title: "Computer Science", description: "Fundamental CS concepts"),
            Topic(id: 4, title: "General Knowledge", description: "Random facts and trivia"),
            Topic(id: 5, title: "Math Puzzles", description: "Fun math problems"),
            Topic(id: 6, title: "Geography", description: "Test your geography knowledge"),
            Topic(id: 7, title: "Science", description: "Basic science concepts")
        ]
        
        // MARK: - Create Questions (with mixed correct answers)
        let questions = [
            // Swift Programming (Topic 1) - 10 questions
            Question(
                id: 1,
                topicId: 1,
                questionText: "What is Swift?",
                answerA: "A programming language",
                answerB: "A type of car",
                answerC: "A bird species",
                answerD: "A fast runner",
                correctAnswer: "A"
            ),
            Question(
                id: 2,
                topicId: 1,
                questionText: "Which keyword is used to create a constant?",
                answerA: "var",
                answerB: "let",
                answerC: "const",
                answerD: "static",
                correctAnswer: "B"
            ),
            Question(
                id: 3,
                topicId: 1,
                questionText: "What is an optional in Swift?",
                answerA: "A required value",
                answerB: "A value that can be nil",
                answerC: "A default parameter",
                answerD: "A function type",
                correctAnswer: "B"
            ),
            Question(
                id: 4,
                topicId: 1,
                questionText: "How do you unwrap an optional safely?",
                answerA: "Force unwrap (!)",
                answerB: "Optional binding (if let)",
                answerC: "Ignore it",
                answerD: "Convert to string",
                correctAnswer: "B"
            ),
            Question(
                id: 5,
                topicId: 1,
                questionText: "What is a dictionary in Swift?",
                answerA: "A book of words",
                answerB: "A collection of key-value pairs",
                answerC: "A type of array",
                answerD: "A function",
                correctAnswer: "B"
            ),
            Question(
                id: 6,
                topicId: 1,
                questionText: "Which protocol is used for copying objects?",
                answerA: "Copyable",
                answerB: "Cloneable",
                answerC: "NSCopying",
                answerD: "Duplicatable",
                correctAnswer: "C"
            ),
            Question(
                id: 7,
                topicId: 1,
                questionText: "What does GCD stand for?",
                answerA: "Grand Central Dispatch",
                answerB: "Global Code Distribution",
                answerC: "Generic Control Display",
                answerD: "Graphics Core Driver",
                correctAnswer: "A"
            ),
            Question(
                id: 8,
                topicId: 1,
                questionText: "Which is NOT a valid access control in Swift?",
                answerA: "private",
                answerB: "public",
                answerC: "protected",
                answerD: "internal",
                correctAnswer: "C"
            ),
            Question(
                id: 9,
                topicId: 1,
                questionText: "What is a closure?",
                answerA: "A class",
                answerB: "A struct",
                answerC: "A self-contained block of code",
                answerD: "A protocol",
                correctAnswer: "C"
            ),
            Question(
                id: 10,
                topicId: 1,
                questionText: "What is the main difference between class and struct?",
                answerA: "Class is reference type, struct is value type",
                answerB: "Struct is reference type, class is value type",
                answerC: "They are the same",
                answerD: "Class is faster",
                correctAnswer: "A"
            ),
            
            // iOS Development (Topic 2) - 8 questions
            Question(
                id: 11,
                topicId: 2,
                questionText: "What is Xcode?",
                answerA: "A text editor",
                answerB: "An IDE for iOS development",
                answerC: "A programming language",
                answerD: "A simulator",
                correctAnswer: "B"
            ),
            Question(
                id: 12,
                topicId: 2,
                questionText: "What is UIKit?",
                answerA: "A testing framework",
                answerB: "A UI framework for iOS",
                answerC: "A database",
                answerD: "A network library",
                correctAnswer: "B"
            ),
            Question(
                id: 13,
                topicId: 2,
                questionText: "What does Auto Layout do?",
                answerA: "Creates animations",
                answerB: "Manages memory",
                answerC: "Handles networking",
                answerD: "Arranges UI elements responsively",
                correctAnswer: "D"
            ),
            Question(
                id: 14,
                topicId: 2,
                questionText: "What is a ViewController?",
                answerA: "A type of button",
                answerB: "A database model",
                answerC: "Manages a set of views",
                answerD: "A network request",
                correctAnswer: "C"
            ),
            Question(
                id: 15,
                topicId: 2,
                questionText: "What is Core Data?",
                answerA: "A UI framework",
                answerB: "A framework for data persistence",
                answerC: "A networking tool",
                answerD: "An animation library",
                correctAnswer: "B"
            ),
            Question(
                id: 16,
                topicId: 2,
                questionText: "What is a delegate in iOS?",
                answerA: "A design pattern for communication",
                answerB: "A type of class",
                answerC: "A memory manager",
                answerD: "A UI element",
                correctAnswer: "A"
            ),
            Question(
                id: 17,
                topicId: 2,
                questionText: "What is Cocoa Touch?",
                answerA: "The UI framework for iOS",
                answerB: "A type of gesture",
                answerC: "A programming language",
                answerD: "A database",
                correctAnswer: "A"
            ),
            Question(
                id: 18,
                topicId: 2,
                questionText: "What is the app lifecycle?",
                answerA: "App states from launch to termination",
                answerB: "App build time",
                answerC: "App version history",
                answerD: "Development process",
                correctAnswer: "A"
            ),
            
            // Computer Science (Topic 3) - 8 questions
            Question(
                id: 19,
                topicId: 3,
                questionText: "What is an algorithm?",
                answerA: "A programming language",
                answerB: "A step-by-step problem-solving procedure",
                answerC: "A type of computer",
                answerD: "A data structure",
                correctAnswer: "B"
            ),
            Question(
                id: 20,
                topicId: 3,
                questionText: "What is a data structure?",
                answerA: "A way to organize and store data",
                answerB: "A type of database",
                answerC: "A programming paradigm",
                answerD: "An algorithm",
                correctAnswer: "A"
            ),
            Question(
                id: 21,
                topicId: 3,
                questionText: "What does OOP stand for?",
                answerA: "Object-Oriented Programming",
                answerB: "Original Operating Protocol",
                answerC: "Optimized Output Process",
                answerD: "Ordered Object Process",
                correctAnswer: "A"
            ),
            Question(
                id: 22,
                topicId: 3,
                questionText: "What is a binary tree?",
                answerA: "A tree with at most two children per node",
                answerB: "A type of algorithm",
                answerC: "A sorting method",
                answerD: "A database type",
                correctAnswer: "A"
            ),
            Question(
                id: 23,
                topicId: 3,
                questionText: "What is recursion?",
                answerA: "A loop structure",
                answerB: "A function that calls itself",
                answerC: "A data type",
                answerD: "An error handling method",
                correctAnswer: "B"
            ),
            Question(
                id: 24,
                topicId: 3,
                questionText: "What is Big O notation?",
                answerA: "Describes algorithm performance",
                answerB: "A programming language",
                answerC: "A data type",
                answerD: "A design pattern",
                correctAnswer: "A"
            ),
            Question(
                id: 25,
                topicId: 3,
                questionText: "What is a stack?",
                answerA: "FIFO data structure",
                answerB: "LIFO data structure",
                answerC: "A type of queue",
                answerD: "A sorting algorithm",
                correctAnswer: "B"
            ),
            Question(
                id: 26,
                topicId: 3,
                questionText: "What is polymorphism?",
                answerA: "Many forms",
                answerB: "One form",
                answerC: "No forms",
                answerD: "Fixed form",
                correctAnswer: "A"
            ),
            
            // General Knowledge (Topic 4) - 8 questions
            Question(
                id: 27,
                topicId: 4,
                questionText: "What is the capital of France?",
                answerA: "London",
                answerB: "Berlin",
                answerC: "Paris",
                answerD: "Madrid",
                correctAnswer: "C"
            ),
            Question(
                id: 28,
                topicId: 4,
                questionText: "Who painted the Mona Lisa?",
                answerA: "Picasso",
                answerB: "Van Gogh",
                answerC: "Leonardo da Vinci",
                answerD: "Michelangelo",
                correctAnswer: "C"
            ),
            Question(
                id: 29,
                topicId: 4,
                questionText: "What is the largest ocean?",
                answerA: "Atlantic",
                answerB: "Indian",
                answerC: "Pacific",
                answerD: "Arctic",
                correctAnswer: "C"
            ),
            Question(
                id: 30,
                topicId: 4,
                questionText: "How many continents are there?",
                answerA: "5",
                answerB: "6",
                answerC: "7",
                answerD: "8",
                correctAnswer: "C"
            ),
            Question(
                id: 31,
                topicId: 4,
                questionText: "What is the longest river?",
                answerA: "Amazon",
                answerB: "Yangtze",
                answerC: "Nile",
                answerD: "Mississippi",
                correctAnswer: "C"
            ),
            Question(
                id: 32,
                topicId: 4,
                questionText: "Which planet is known as the Red Planet?",
                answerA: "Venus",
                answerB: "Jupiter",
                answerC: "Mars",
                answerD: "Saturn",
                correctAnswer: "C"
            ),
            
            // Math Puzzles (Topic 5) - 6 questions
            Question(
                id: 33,
                topicId: 5,
                questionText: "What is 7 × 8?",
                answerA: "48",
                answerB: "56",
                answerC: "64",
                answerD: "54",
                correctAnswer: "B"
            ),
            Question(
                id: 34,
                topicId: 5,
                questionText: "What is the square root of 144?",
                answerA: "10",
                answerB: "11",
                answerC: "12",
                answerD: "13",
                correctAnswer: "C"
            ),
            Question(
                id: 35,
                topicId: 5,
                questionText: "What is 15% of 200?",
                answerA: "20",
                answerB: "25",
                answerC: "30",
                answerD: "35",
                correctAnswer: "C"
            ),
            Question(
                id: 36,
                topicId: 5,
                questionText: "What is 9 + 10?",
                answerA: "18",
                answerB: "19",
                answerC: "21",
                answerD: "20",
                correctAnswer: "B"
            ),
            Question(
                id: 37,
                topicId: 5,
                questionText: "What is 2^5?",
                answerA: "16",
                answerB: "32",
                answerC: "64",
                answerD: "128",
                correctAnswer: "B"
            ),
            
            // Geography (Topic 6) - 4 questions
            Question(
                id: 38,
                topicId: 6,
                questionText: "Smallest country in the world?",
                answerA: "Monaco",
                answerB: "San Marino",
                answerC: "Vatican City",
                answerD: "Malta",
                correctAnswer: "C"
            ),
            Question(
                id: 39,
                topicId: 6,
                questionText: "Largest desert in the world?",
                answerA: "Arabian",
                answerB: "Gobi",
                answerC: "Sahara",
                answerD: "Kalahari",
                correctAnswer: "C"
            ),
            Question(
                id: 40,
                topicId: 6,
                questionText: "Highest mountain in the world?",
                answerA: "K2",
                answerB: "Kangchenjunga",
                answerC: "Mount Everest",
                answerD: "Lhotse",
                correctAnswer: "C"
            ),
            
            // Science (Topic 7) - 5 questions
            Question(
                id: 41,
                topicId: 7,
                questionText: "Chemical symbol for water?",
                answerA: "CO2",
                answerB: "O2",
                answerC: "H2O",
                answerD: "NaCl",
                correctAnswer: "C"
            ),
            Question(
                id: 42,
                topicId: 7,
                questionText: "Hardest natural substance?",
                answerA: "Gold",
                answerB: "Iron",
                answerC: "Diamond",
                answerD: "Platinum",
                correctAnswer: "C"
            ),
            Question(
                id: 43,
                topicId: 7,
                questionText: "What is the speed of light?",
                answerA: "300,000 km/s",
                answerB: "150,000 km/s",
                answerC: "299,792 km/s",
                answerD: "400,000 km/s",
                correctAnswer: "C"
            )
        ]
        
        return QuizData(topics: topics, questions: questions)
    }
}
