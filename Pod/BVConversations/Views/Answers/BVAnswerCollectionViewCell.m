//
//  BVAnswerCollectionViewCell.m
//  BVConversations
//
//  Copyright © 2016 Bazaarvoice. All rights reserved.
//

#import "BVAnswerCollectionViewCell.h"
#import "BVViewsHelper.h"

@implementation BVAnswerCollectionViewCell

-(void)setAnswer:(BVAnswer*) answer {
    
    _answer = answer;
    
}

- (void)clicked {
    
    if (_answer){
        [_answer recordTap];
    }
    
}

- (void)didMoveToSuperview {
    
    [super didMoveToSuperview];
    [BVViewsHelper checkButtonsInSubviews:self.subviews withTarget:self withSelector:@selector(clicked)];
    [BVViewsHelper checkGestureRecognizers:self.gestureRecognizers];
    
}

@end
