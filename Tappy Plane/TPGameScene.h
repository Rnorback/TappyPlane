//
//  TPGameScene.h
//  Tappy Plane
//
//  Created by Rob Norback on 2/22/15.
//  Copyright (c) 2015 Sidecar Games. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TPPlane.h"

@interface TPGameScene : SKScene

@property (nonatomic) TPPlane *player;
@property (nonatomic) SKNode *world;

@end
