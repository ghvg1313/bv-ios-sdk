//
//  ProductsResponse.h
//  Conversations
//
//  Copyright © 2016 Bazaarvoice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BVResponse.h"
#import "BVProduct.h"

/*
 A response to a `BVProductDisplayPageRequest`. Contains one `BVProduct` in the `result` object.
 Contains other response information like the current index of pagination (`offset` property), and how many total results
 are available (`totalResults` property).
 */
@interface BVProductsResponse: NSObject<BVResponse>

@property NSNumber* _Nullable offset;
@property NSString* _Nullable locale;
@property BVProduct* _Nullable result;
@property NSNumber* _Nullable totalResults;
@property NSNumber* _Nullable limit;

@end
