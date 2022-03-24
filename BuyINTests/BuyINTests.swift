//
//  BuyINTests.swift
//  BuyINTests
//
//  Created by apple on 3/10/22.
//

import XCTest
@testable import BuyIN

class BuyINTests: XCTestCase {
    var registeration = RegistrationViewController()
    var cartController = CartController.shared
    var wishListController = WishlistController.shared

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPhoneValidation() {
        let phoneTestArray = ["+201012345678", "201012345678", "01012345678", "00201012345678"]
        for phone in phoneTestArray{
            let result = registeration.phonevalidation(phone: phone)
            XCTAssert(result.0, "Not Valid")
        }
    }
    
//    func testCartAdd(){
//        let cartItem: CartItem?
//    }
    


}
