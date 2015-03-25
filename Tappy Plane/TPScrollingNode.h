//
//  TPScrollingNode.h
//  Tappy Plane
//
//  Created by Rob Norback on 3/23/15.
//  Copyright (c) 2015 Sidecar Games. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TPScrollingNode : SKNode

@property (nonatomic) CGFloat horizontaScrollSpeed; // Distance to scroll per second
@property (nonatomic) BOOL scrolling;

-(void)updateWithTimeElapsed:(NSTimeInterval)timeElapsed;


@end
