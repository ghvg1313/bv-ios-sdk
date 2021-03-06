//
//  ReviewDisplayTests.swift
//  Conversations
//
//  Copyright © 2016 Bazaarvoice. All rights reserved.
//

import XCTest
@testable import BVSDK

class ReviewDisplayTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        BVSDKManager.sharedManager().clientId = "apitestcustomer"
        BVSDKManager.sharedManager().apiKeyConversations = "kuy3zj9pr3n7i0wxajrzj04xo"
        BVSDKManager.sharedManager().staging = true
    }
    
    
    func testReviewDisplay() {
        
        let expectation = expectationWithDescription("")
        
        let request = BVReviewsRequest(productId: "test1", limit: 10, offset: 0)
            .addSort(.Rating, order: .Ascending)
            .addFilter(.HasPhotos, filterOperator: .EqualTo, value: "true")
            .addFilter(.HasComments, filterOperator: .EqualTo, value: "false")
        
        request.load({ (response) in
            
            XCTAssertEqual(response.results.count, 10)
            let review = response.results.first!
            XCTAssertEqual(review.rating, 1)
            XCTAssertEqual(review.title, "Morbi nibh risus, mattis id placerat a massa nunc.")
            XCTAssertEqual(review.reviewText, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed rhoncus scelerisque semper. Morbi in sapien sit amet justo eleifend pellentesque! Cras sollicitudin, quam in ullamcorper faucibus, augue metus blandit justo, vitae ullamcorper tellus quam non purus. Fusce gravida rhoncus placerat. Integer tempus nunc sed elit mollis ut venenatis felis volutpat. Sed a velit et lacus lobortis aliquet? Donec dolor quam, pharetra vitae commodo et, mattis quis nibh? Quisque ultrices neque et lacus volutpat.")
            XCTAssertEqual(review.moderationStatus, "APPROVED")
            XCTAssertEqual(review.identifier, "191975")
            XCTAssertNil(review.product)
            XCTAssertEqual(review.isRatingsOnly, false)
            XCTAssertEqual(review.isFeatured, false)
            XCTAssertEqual(review.productId, "test1")
            XCTAssertEqual(review.authorId, "endersgame")
            XCTAssertEqual(review.userNickname, "endersgame")
            XCTAssertEqual(review.userLocation, "San Fransisco, California")
            
            XCTAssertEqual(review.tagDimensions!["Pro"]!.label, "Pros")
            XCTAssertEqual(review.tagDimensions!["Pro"]!.identifier, "Pro")
            XCTAssertEqual(review.tagDimensions!["Pro"]!.values!, ["Organic Fabric", "Quality"])
            
            XCTAssertEqual(review.photos.count, 1)
            XCTAssertEqual(review.photos.first?.caption, "Etiam malesuada ultricies urna in scelerisque. Sed viverra blandit nibh non egestas. Sed rhoncus, ipsum in vehicula imperdiet, purus lectus sodales erat, eget ornare lacus lectus ac leo. Suspendisse tristique sollicitudin ultricies. Aliquam erat volutpat.")
            XCTAssertEqual(review.photos.first?.identifier, "72586")
            XCTAssertEqual(review.photos.first?.sizes?.thumbnailUrl, "https://reviews.apitestcustomer.bazaarvoice.com/bvstaging/5556/72586/photoThumb.jpg")
            XCTAssertEqual(review.photos.first?.sizes?.normalUrl, "https://reviews.apitestcustomer.bazaarvoice.com/bvstaging/5556/72586/photo.jpg")
            
            XCTAssertEqual(review.contextDataValues.count, 1)
            let cdv = review.contextDataValues.first!
            XCTAssertEqual(cdv.value, "Female")
            XCTAssertEqual(cdv.valueLabel, "Female")
            XCTAssertEqual(cdv.dimensionLabel, "Gender")
            XCTAssertEqual(cdv.identifier, "Gender")
            
            XCTAssertEqual(review.badges.first?.badgeType, BVBadgeType.Merit)
            XCTAssertEqual(review.badges.first?.identifier, "top10Contributor")
            XCTAssertEqual(review.badges.first?.contentType, "REVIEW")
            
            response.results.forEach { (review) in
                XCTAssertEqual(review.productId, "test1")
            }
            
            expectation.fulfill()
            
        }) { (error) in
            
            XCTFail("product display request error: \(error)")
            
        }
        
        self.waitForExpectationsWithTimeout(10) { (error) in print("request took way too long") }
        
    }
    
}