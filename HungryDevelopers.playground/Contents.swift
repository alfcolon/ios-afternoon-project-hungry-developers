//import UIKit
//
//class Spoon {
//
//    // MARK: - Properties
//
//    let lock = NSLock()
//
//    // MARK: - Methods
//
//    func pickUp() {
//        self.lock.lock()
//    }
//
//    func putDown() {
//        self.lock.unlock()
//    }
//}
//
//class Developer {
//
//    //MARK: - Properties
//
//    var leftSpoon = Spoon()
//    var rightSpoon = Spoon()
//
//    //MARK: - Methods
//
//    func eat() {
//        usleep(1)
//        self.leftSpoon.putDown()
//        self.rightSpoon.putDown()
//
//    }
//
//    func think() {
//        self.leftSpoon.pickUp()
//        self.rightSpoon.pickUp()
//    }
//
//    func run() {
//        while true {
//            self.think()
//            self.eat()
//        }
//    }
//}
//
//var developer1 = Developer()
//var developer2 = Developer()
//var developer3 = Developer()
//var developer4 = Developer()
//var developer5 = Developer()
//
//DispatchQueue.concurrentPerform(iterations: 1) {_ in
//    developer1.run()
//    developer2.run()
//    developer3.run()
//    developer4.run()
//    developer5.run()
//}
//
////This problem is trickier than it seems. However, you should start by writing a simple solution.
//
////Create a class called Spoon. It should have two methods, pickUp() and putDown().
////If pickUp() is called while the spoon is in use by another developer, pickUp() should wait until the other developer calls putDown(). You can implement this with a private lock property.
////Create a class called Developer. Each Developer should have a leftSpoon property and a rightSpoon property. It should also have think(), eat(), and run() methods.
////Developer.run() should call think() then eat() over and over again forever.
////think() should pick up both spoons before returning.
////eat() should pause for a random amount of time before putting both spoons down. (Hint: use usleep() to pause for a given number of microseconds).
////Create 5 Spoons and 5 Developers giving each developer a left and right spoon. Note that developers will of course share spoons. Every developer's right spoon is the next developer's left spoon.
////Call run() on each developer in a different queue/thread. You can do this with the following code assuming you put your developers in an array:
////DispatchQueue.concurrentPerform(iterations: 5) {
////developers[$0].run()
////}
////To recap the algorithm you're writing here, each developer will:
////
////think until the left spoon is available; when it is, pick it up;
////think until the right spoon is available; when it is, pick it up;
////when both spoons are held, eat for a fixed amount of time;
////then, put the right spoon down;
////then, put the left spoon down;
////

import UIKit

var str = "Hello, playground"

class Spoon {
    
    private var lock = NSLock()
    var index: Int
   
    func pickUp() {
        lock.lock()
    }
    
    func putDown() {
        lock.unlock()
    }
    
    
    init(index: Int) {
        self.index = index
    }
    
}

class Developer {
   
    var leftSpoon: Spoon
    var rightSpoon: Spoon
    
    
    func think() {
        if leftSpoon.index > rightSpoon.index {
            leftSpoon.pickUp()
            rightSpoon.pickUp()
        } else {
            rightSpoon.pickUp()
            leftSpoon.pickUp()
        }
    }
    
    
    func eat() {
        
        usleep(1000)
        leftSpoon.putDown()
        rightSpoon.putDown()
    }
    
    func run() {
        while true {
            think()
            eat()
        }
    }
    
    init(leftSpoon: Spoon, rightSpoon: Spoon) {
        self.leftSpoon = leftSpoon
        self.rightSpoon = rightSpoon
    }
}//
// Spoons
var spoon1 = Spoon(index: 1)
var spoon2 = Spoon(index: 2)
var spoon3 = Spoon(index: 3)
var spoon4 = Spoon(index: 4)
var spoon5 = Spoon(index: 5)



// Developers
var devOne = Developer(leftSpoon: spoon1, rightSpoon: spoon2)
var devTwo = Developer(leftSpoon: spoon2, rightSpoon: spoon3)
var devThree = Developer(leftSpoon: spoon3, rightSpoon: spoon4)
var devFour = Developer(leftSpoon: spoon4, rightSpoon: spoon5)
var devFive = Developer(leftSpoon: spoon5, rightSpoon: spoon1)

let allDevs: [Developer] = [devOne, devTwo, devThree, devFour, devFive]


DispatchQueue.concurrentPerform(iterations: 5) {
    allDevs[$0].run()
    
    print("Index \($0)")
}
print("hello")
