//
//  APIClientTests.swift
//  BuyINTests
//
//  Created by Akram Elhayani on 11/03/2022.
//

import XCTest
import Buy
@testable import BuyIN
class APIClientTests: XCTestCase {

    override func setUpWithError() throws {
     
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testfetchShopName(){
        
        
        weak var  promiseToCallBack = expectation(description: "itiIOS")
        let dataTask = Client.shared.fetchShopName() { shop in
            guard let promise = promiseToCallBack else {
                       return
                   }
            if let _ = shop {
                promise.fulfill()
                promiseToCallBack = nil
            }else{
                XCTFail("Function Should return shop name")
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
   }
    func testfetchShopURL(){
        
        
        weak var  promiseToCallBack = expectation(description: "itiIOS")
        let dataTask = Client.shared.fetchShopURL() { url in
            guard let promise = promiseToCallBack else {
                       return
                   }
            if let _ = url {
                promise.fulfill()
                promiseToCallBack = nil
            }else{
                XCTFail("Function Should return Shop url")
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
   }

    func testfetchCollections(){
        
        
        weak var  promiseToCallBack = expectation(description: "collections")
        let dataTask = Client.shared.fetchCollections(ofType:.sales) { categories in
            guard let promise = promiseToCallBack else {
                       return
                   }
            if let _ = categories {
                promise.fulfill()
                promiseToCallBack = nil
            }else{
                XCTFail("Function Should return category")
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
   }
    
    func testfetchProducts(){
        
        
        weak var  promiseToCallBack = expectation(description: "products")
        let dataTask = Client.shared.fetchProducts(limit:2) { products in
            guard let promise = promiseToCallBack else {
                       return
                   }
            if let products = products {
                if (products.items.count == 2){
                    promise.fulfill()
                    promiseToCallBack = nil
                }else{
                    XCTFail("Function Should return 2 products ")
                }
            }else{
                XCTFail("Function Should return 2 products ")
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
   }
    
    
    func testCreateCustomerWithErorr(){
        
       
        weak var promiseToCallBack = expectation(description: "Error with Phone Number")
        let dataTask = Client.shared.CreateCustomer(firstName: "Test", lastName: "Test", phone: "01061648888", email: "mail@mail.com", password: "12345678") { Customer, errors in
            guard let promise = promiseToCallBack else {
                       print("once was enough, thanks!")
                       return
                   }
            if let _ = errors
            {
                promise.fulfill()
                promiseToCallBack = nil
                
            }else{
                XCTFail("Function Should Return Error")
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 10, handler: nil)
     //   XCTAssertNotNil(error)
    }
    
    
     func testloginCustomer(){
         
         
         weak var  promiseToCallBack = expectation(description: "Return Access token ")
         let dataTask = Client.shared.login(email: "you@you.com", password: "123456789") { accessToken in
             guard let promise = promiseToCallBack else {
                        print("once was enough, thanks!")
                        return
                    }
             if let _ = accessToken {
                 promise.fulfill()
                 promiseToCallBack = nil
             }else{
                 XCTFail("Function Should Return Access token ")
             }
         }
         dataTask.resume()
         waitForExpectations(timeout: 10, handler: nil)
    }
}
