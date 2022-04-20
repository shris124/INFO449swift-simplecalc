//: # Welcome to the UW Calculator Playground (Simple Version)
//:
print("Welcome to the UW Calculator Playground")
//: This homework is designed to force you to exercise your knowledge of the Swift programming language. This homework does not involve iOS in any way. It uses the Playground feature of XCode to allow you to interactively write Swift code--the compiler will constantly check your code in the background.
//:
//: In this exercise, you will implement a pair of functions that do some simple mathematical calculations.
//:
//: ## To do that...
//: ... you must first obtain a copy of the source. Do that by cloning this repository:
//: 
//:         git clone https://github.com/tedneward/uw-swift-simplecalc
//: 
//: This will create a local copy of the project. 
//: 
//: To open this project in XCode, fire up XCode itself, then File|Open the `SimpleSwift.playground` file.
//: 
//: > Interesting side note: In truth the Playground is not a file, but a directory that pretends to be a file. This is a common trick in the macOS/iOS world. If you look at it Finder, it will appear to be a single file; if you look at it from Terminal, however, you can navigate "into" the file and view its contents. In the case of Playgrounds, the actual code is stored in `Contents.swift`. As it turns out, this is also how executables ("bundles") work in both iOS and macOS.
//: 
//: In order to store your changes to your own GitHub account, you need to create a new **public** repository on GitHub (call it `swift-simplecalc`), and then change the project's settings to point to that new repository as the remote origin. To do this, in a Terminal window, navigate to the directory storing your local project code (`swift-simplecalc` if you used my command-line example above), and execute the following:
//: 
//:         git remote set-url origin https://github.com/[your-ID]/swift-simplecalc.git
//: 
//: Be warned: This command will appear to succeed regardless of whether you got the syntax of the URL correct or not, so do a quick push to make sure it all worked correctly:
//: 
//:         git push
//: 
//: Git will ask you for your username and password, then (if everything was done correctly), it will upload the code to the new repository, and this is your new "home" for this project going forward. Verify the files are there by viewing your GitHub project through the browser.
//: 
//: **NOTE:** Your grade for this assignment (and all future assignments) will be based on what we see in the GitHub repository, and nothing else. A basic rule of this course: **If it isn't in GitHub, it doesn't exist.**
//: 
//: ## Your tasks
//: You are to implement two `calculate` functions, each of which take `Strings` are expected to perform the calculations intended. This is designed to make you comfortable with converting Strings to other values--a common task in mobile applications, when obtaining input from the user--for further processing. One of the functions takes an array of Strings, expecting each "part" of the calculation expression to be each be in its own String (such as "2" "+" "2"), and the second expects a single String containing the entire expression ("2 + 2").
//: 
//: You should make sure your calculate method can handle the following kinds of input:
//: 
//: * `calculate(["2", "+", "2"])`: This should return 4
//: * `calculate(["2", "-", "2"])`: This should return 0
//: * `calculate(["2", "/", "2"])`: This should return 1
//: * `calculate(["2", "%", "2"])`: This should return 0
//: * `calculate(["2", "*", "2"])`: This should return 4
//: 
//: For those who aren't aware of it, the "%" operator is called the "modulo" operator, and it is the "remainder" result in an integer division that does not divide equally. Thus, `5 % 2` is 1 (5 divided by 2 is 2 remainder 1), `10 % 3` is 1 (10 divided by 3 is 3 remainder 1) and `4 % 2` is 0 (4 divided by 2 is 2 remainder 0).
//: 
//: The `calculate` method also needs to support a few other less-traditional expressions as well:
//: 
//: * `calculate(["1", "2", "3", "4", "5", "count"])`: This should return a count of all the number arguments, which in this case will be 5.
//: * `calculate(["1", "3", "2", "avg"])`: This should return the average of the numbers, which is all of the values added up (1 + 3 + 2) and divided by the number of arguments (3).
//: * `calculate(["5", "fact"])`: This should calculate the factorial of the single number passed in, which is that number multiplied by each number below it. 5-factorial is 5 * 4 * 3 * 2 * 1, or 120.
//: 
//: For this latter set of operations, it is safe to assume that `["count"]` (no additional arguments) is 0, `["avg"]` is also 0, and `["fact"]` is 0. `["1", "fact"]` should return 1, and `["0", "fact"]` should also return 1. (Yes, 0-factorial is 1. True story.)
//: 
func calculate(_ args: [String]) -> Int {
    switch args.last {
        case "count":
            return args.count - 1
        case "avg":
            
            var sum = 0
            for i in 0...(args.count - 1) {
                sum = sum + (Int(args[i]) ?? 0)
            }
            return sum / max(1, args.count - 1)
        case "fact":
            if (args.count <= 1 ) {return 0}
            let num : Int = Int(args[0])!
            if (num < 0) { return -1 } // case if num is less than 0
            if (num == 0) { return 1 } // case if num is 1
            var sum = 1                         // case if num is positive int
            for i in 1...num {
                sum = sum * i
            }
            return sum
        default:
            let num1 : Int = Int(args[0])!
            let num2 : Int = Int(args[2])!
            switch args[1] {
                case "%": return num1 % num2
                case "+": return num1 + num2
                case "-": return num1 - num2
                case "*": return num1 * num2
                case "/": return num1 / num2
                default:
                    return -1
            }
                            
        
    }
}

func calculate(_ arg: String) -> Int {
    return calculate( arg.split(separator: " ").map({ str in String(str) }) )
}

//: Below this are the test expressions/calls to verify if your code is correct.
//: ***DO NOT MODIFY ANYTHING BELOW THIS***
//: -------------------------------------------
//: All of these expressions should return true
//: if you have implemented `calculate()`` correctly
//
calculate(["2", "+", "2"]) == 4
calculate(["4", "+", "4"]) == 8
calculate(["2", "-", "2"]) == 0
calculate(["2", "*", "2"]) == 4
calculate(["2", "/", "2"]) == 1
calculate(["2", "%", "2"]) == 0

calculate(["1", "2", "3", "count"]) == 3
calculate(["1", "2", "3", "4", "5", "count"]) == 5
calculate(["count"]) == 0

calculate(["1", "2", "3", "4", "5", "avg"]) == 3
    // 15 / 5 = 3
calculate(["2", "2", "4", "4", "avg"]) == 3
    // 12 / 4 = 3
calculate(["2", "avg"]) == 2
    // 2 / 1 = 2
calculate(["avg"]) == 0
    // 0 / 0 = 0 (not really, but it's an edge case

calculate(["0", "fact"]) == 1
calculate(["1", "fact"]) == 1
calculate(["2", "fact"]) == 2 // 2*1
calculate(["5", "fact"]) == 120 // 5*4*3*2*1
calculate(["fact"]) == 0

calculate("2 + 2") == 4
calculate("2 * 2") == 4
calculate("2 - 2") == 0
calculate("2 / 2") == 1

calculate("1 2 3 4 5 count") == 5
calculate("1 2 3 4 5 avg") == 3
calculate("5 fact") == 120

//: -------------------------------------------
//: These are extra credit tests; they are commented out so that they do not conflict with you work until you choose to implement them.
//: Uncomment them to turn them on for evaluation
//:
//: Implement `calculate([String])` and `calculate(String)` to handle negative numbers. You need only make the tests below pass. (You do not need to worry about "fact"/factorial with negative numbers, for example.)
//:
//: This is worth 1 pt

calculate(["2", "+", "-2"]) == 0
calculate(["2", "-", "-2"]) == 4
calculate(["2", "*", "-2"]) == -4
calculate(["2", "/", "-2"]) == -1
calculate(["-5", "%", "2"]) == -1

calculate(["1", "-2", "3", "-2", "5", "avg"]) == 1

calculate("2 + -2") == 0
calculate("2 * -2") == -4
calculate("2 - -2") == 4
calculate("-2 / 2") == -1

calculate("1 -2 3 -4 5 count") == 5

 
//: Implement `calculate([String])` and `calculate(String)` to use and return floating-point values. You need only make the tests below pass. (Factorial of floating-point numbers doesn't make much sense, either.)
//:
//: Swift *will* allow you to overload based on return times, so the below functions can co-exist simultaneously with the Integer-based versions above.
//: 
//: This is worth 1 pt
/*
func calculate(_ args: [String]) -> Double {
    return -1.0
}
func calculate(_ arg: String) -> Double {
    return -1.0
}

calculate(["2.0", "+", "2.0"]) == 4.0
calculate([".5", "+", "1.5"]) == 2.0
calculate(["12.0", "-", "12.0"]) == 0.0
calculate(["2.5", "*", "2.5"]) == 6.25
calculate(["2.0", "/", "2.0"]) == 1.0
calculate(["2.0", "%", "2.0"]) == 0.0
calculate("1.0 2.0 3.0 4.0 5.0 count") == 5.0
*/
