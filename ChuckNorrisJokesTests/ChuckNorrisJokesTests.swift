//
//  ChuckNorrisJokesTests.swift
//  ChuckNorrisJokesTests
//
//  Created by Lorence Lim on 18/09/2017.
//  Copyright © 2017 Lorence Lim. All rights reserved.
//

import XCTest
@testable import ChuckNorrisJokes

class ChuckNorrisJokesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchJokesAPI() {
        let jokeTableViewController = CNJJokeTableViewController()
        let urlExpectation = expectation(description: "GET Chuck Norris Joke")
        
        jokeTableViewController.fetchJokes { (json) in
            XCTAssertEqual(json["type"] as! String, "success")
            urlExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 20) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testJokeManagedObject() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let jokeManagedObject = CNJJokeManagedObject(context:context)
        jokeManagedObject.id = 1
        jokeManagedObject.content = "Test"
        
        let jokeString = "[\(jokeManagedObject.id)] \(jokeManagedObject.content)"
        XCTAssertEqual(jokeManagedObject.toString(), jokeString)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
