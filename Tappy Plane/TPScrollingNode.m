//
//  TPScrollingNode.m
//  Tappy Plane
//
//  Created by Rob Norback on 3/23/15.
//  Copyright (c) 2015 Sidecar Games. All rights reserved.
//

#import "TPScrollingNode.h"

@implementation TPScrollingNode

-(void)updateWithTimeElapsed:(NSTimeInterval)timeElapsed
{
    if (self.scrolling) {
        self.position = CGPointMake(self.position.x + self.horizontalScrollSpeed * timeElapsed, self.position.y);
    }
}

@end
