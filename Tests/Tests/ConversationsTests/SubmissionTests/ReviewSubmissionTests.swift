//
//  ConversationsSubmissionTests.swift
//  Conversations
//
//  Copyright © 2016 Bazaarvoice. All rights reserved.
//


import XCTest
@testable import BVSDK

class ReviewSubmissionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        BVSDKManager.sharedManager().clientId = "apitestcustomer"
        BVSDKManager.sharedManager().apiKeyConversations = "2cpdrhohmgmwfz8vqyo48f52g"
        BVSDKManager.sharedManager().staging = true
    }
    
    func testSubmitReviewWithPhoto() {
        
        let expectation = expectationWithDescription("")
        
        let review = self.fillOutReview()
        review.submit({ (reviewSubmission) in
            expectation.fulfill()
        }, failure: { (errors) in
            XCTFail()
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func fillOutReview() -> BVReviewSubmission {
        let review = BVReviewSubmission(reviewTitle: "review title",
                                      reviewText: "more than 50 more than 50 more than 50 more than 50 more than 50",
                                      rating: 4,
                                      productId: "test1")
        
        let randomId = String(arc4random())
        
        review.campaignId = "BV_REVIEW_DISPLAY"
        review.locale = "en_US"
        review.sendEmailAlertWhenCommented = true
        review.sendEmailAlertWhenPublished = true
        review.userNickname = "UserNickname" + randomId
        review.netPromoterScore = 5
        review.netPromoterComment = "Never!"
        review.userId = "UserId" + randomId
        review.userEmail = "developer@bazaarvoice.com"
        review.agreedToTermsAndConditions = true
        review.action = .Submit
        
        review.addContextDataValueBool("VerifiedPurchaser", value: false)
        review.addContextDataValueString("Age", value: "18to24")
        review.addContextDataValueString("Gender", value: "Male")
        review.addRatingQuestion("Quality", value: 1)
        review.addRatingQuestion("Value", value: 3)
        review.addRatingQuestion("HowDoes", value: 4)
        review.addRatingQuestion("Fit", value: 3)
        
        review.addPhoto(PhotoUploadTests.createImage(), withPhotoCaption: "Yo dawg")
        
        return review
    }
    
    
    func testSubmitReviewFailure() {
        let expectation = expectationWithDescription("")
        
        let review = BVReviewSubmission(reviewTitle: "", reviewText: "", rating: 123, productId: "1000001")
        review.userNickname = "cgil"
        review.userId = "craiggiddl"
        review.action = .Preview
        
        review.submit({ (reviewSubmission) in
            XCTFail()
        }, failure: { (errors) in
            errors.forEach { print("Expected Failure Item: \($0)") }
            XCTAssertEqual(errors.count, 5)
            expectation.fulfill()
        })
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
}