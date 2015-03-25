//
//  TPScrollingLayer.m
//  Tappy Plane
//
//  Created by Rob Norback on 3/23/15.
//  Copyright (c) 2015 Sidecar Games. All rights reserved.
//

#import "TPScrollingLayer.h"

@implementation TPScrollingLayer

-(id)initWithTiles:(NSArray*)tileSpriteNodes
{
    if (self = [super init]) {
        for (SKSpriteNode *tile in tileSpriteNodes) {
            tile.anchorPoint = CGPointZero;
            tile.name = @"Tile";
            [self addChild:tile];
        }
        
        [self layoutTiles];
    }
    return self;
}

-(void)layoutTiles
{
    
}

@end
