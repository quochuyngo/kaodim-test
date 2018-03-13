//: Playground - noun: a place where people can play

import UIKit
import XCTest

class TestObserver: NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: UInt) {
        assertionFailure(description, line: lineNumber)
    }
}
let testObserver = TestObserver()
XCTestObservationCenter.shared.addTestObserver(testObserver)

class EntryTest: XCTestCase {
    func testConstructor() {
        let entry = Entry(credits: 1)
        XCTAssertEqual(entry.credits, 1)
    }
}


class CreditManagerTest: XCTestCase {
    let manager = CreditManager()
    
    func testConstructor() {
        XCTAssertEqual(manager.balance, 0)
    }
    
    func testAddChangesBalance() {
        let entry = Entry(credits: 5)
        let _  = manager.add(entry: entry)
        XCTAssertEqual(manager.balance, 5)
    }
    
    func testAddReturnsTuple() {
        let entry = Entry(credits: 5)
        XCTAssertTrue(manager.add(entry: entry) == (true, 5))
    }
    
    func testDeductChangesBalance() {
        manager.balance = 11
        let entry = Entry(credits: 5)
        let _  = manager.deduct(entry: entry)
        XCTAssertEqual(manager.balance, 6)
    }
    
    func testDeductReturnsTuple() {
        manager.balance = 11
        let entry = Entry(credits: 5)
        XCTAssertTrue(manager.deduct(entry: entry) == (true, 6))
    }
    
    func testDeductReturnsFalseAndCurrentBalanceForNegativeBalance(){
        manager.balance = 5
        let entry = Entry(credits: 6)
        XCTAssertTrue(manager.deduct(entry: entry) == (false, 5))
    }
    
    func testOperateWithAddChangesBalance() {
        let entry = Entry(credits: 5)
        let _  = manager.operate(entry: entry, type: .add)
        XCTAssertEqual(manager.balance, 5)
    }
    func testOperateWithAdd() {
        manager.balance = 5
        let entry = Entry(credits: 2)
        XCTAssertTrue(manager.operate(entry: entry, type: .add) == (true, 7))
    }
    
    func testOperateWithConduct() {
        manager.balance = 10
        let entry = Entry(credits: 4)
        XCTAssertTrue(manager.operate(entry: entry, type: .conduct) == (true, 6))
    }
    func testOperateConductForNagativeBalance() {
        manager.balance = 5
        let entry = Entry(credits: 6)
        XCTAssertTrue(manager.operate(entry: entry, type: .conduct) == (false, 5))
    }
}

enum Type {
    case add
    case conduct
}
class Entry {
    let description: String
    let credits: Int
    
    init(credits: Int, description: String = "") {
        self.credits = credits
        self.description = description
    }
}

class CreditManager {
    var balance: Int
    
    init(balance: Int = 0) {
        self.balance = balance
    }
    
    func add(entry: Entry) -> (result: Bool, balance: Int) {
        balance += entry.credits
        return (true, balance)
    }
    
    func deduct(entry: Entry) -> (result: Bool, balance: Int ) {
        
        if balance >= entry.credits {
            balance -= entry.credits
            return (true, balance)
        } else {
            return (false, balance)
        }
    }
    
    func operate(entry: Entry, type: Type) -> (result: Bool, balance: Int ){
        switch type {
        case .add:
            balance += entry.credits
            return (true, balance)
        case .conduct:
            if balance >= entry.credits {
                balance -= entry.credits
                return (true, balance)
            } else {
                return (false, balance)
            }
        }
    }
}

EntryTest.defaultTestSuite.run()
CreditManagerTest.defaultTestSuite.run()
