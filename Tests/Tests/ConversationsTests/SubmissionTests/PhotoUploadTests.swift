//
//  ConversationsSubmissionTests.swift
//  Conversations
//
//  Copyright © 2016 Bazaarvoice. All rights reserved.
//


import XCTest
@testable import BVSDK

class PhotoUploadTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        BVSDKManager.sharedManager().clientId = "apitestcustomer"
        BVSDKManager.sharedManager().apiKeyConversations = "kuy3zj9pr3n7i0wxajrzj04xo"
        BVSDKManager.sharedManager().staging = true
        
    }

    
    func testUploadablePhoto() {
        let photo = BVUploadablePhoto(photo: PhotoUploadTests.createImage(), photoCaption: "Yo dawhhhh")
        
        // upload photo, make sure it returns a non-empty URL
        let expectation = expectationWithDescription("")
        photo.uploadForContentType(.Review, success: { (photoUrl) in
            XCTAssertTrue(photoUrl.characters.count > 0)
            expectation.fulfill()
        }) { (errors) in
            XCTFail()
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    
    func testUploadablePhotoFailure() {
        let photo = BVUploadablePhoto(photo: UIImage(), photoCaption: "Yo dawhhhh")
        
        // upload photo, make sure it returns a non-empty URL
        let expectation = expectationWithDescription("")
        photo.uploadForContentType(.Review, success: { (photoUrl) in
            XCTFail()
            expectation.fulfill()
        }) { (errors) in
            XCTAssertEqual(errors.count, 1)
            let error = errors.first
            XCTAssertEqual(error?.userInfo[BVFieldErrorCode] as? String, "ERROR_FORM_IMAGE_PARSE")
            XCTAssertEqual(error?.userInfo[BVFieldErrorName] as? String, "photo")
            XCTAssertEqual(error?.userInfo[BVFieldErrorMessage] as? String, "We were unable to parse the image you uploaded.  Please ensure that the image is a valid BMP, PNG, GIF or JPEG file.")
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    
    class func createImage() -> UIImage {
        let url = NSURL(string: "http://d1yacy4j66eg2g.cloudfront.net/img/conversations-api/thumbsup.jpg")
        let data = NSData(contentsOfURL: url!)
        return UIImage(data: data!)!
    }
    
}