//
//  TPPlane.m
//  Tappy Plane
//
//  Created by Rob Norback on 3/2/15.
//  Copyright (c) 2015 Sidecar Games. All rights reserved.
//

#import "TPPlane.h"

@implementation TPPlane

- (instancetype)init
{
    self = [super initWithImageNamed:@"PlaneBlue1@2x"];
    if (self) {
        
        // Init array to hold animation actions
        _planeAnimations = [[NSMutableArray alloc]init];
        
        // Load animations plist file
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PlaneAnimations" ofType:@"plist"];
        NSDictionary *animations = [NSDictionary dictionaryWithContentsOfFile:path];
        for (NSString *key in animations) {
            [_planeAnimations addObject:[self animationFromArray:[animations objectForKey:key] withDuration:0.4]];
        }
        
        [self setRandomColor];
    }
    return self;
}

-(void)setRandomColor
{
    [self runAction:[_planeAnimations objectAtIndex:arc4random_uniform(_planeAnimations.count)]];
}

-(SKAction *)animationFromArray:(NSArray*)textureNames withDuration:(CGFloat)duration
{
    // Create an array to hold textures
    NSMutableArray *frames = [[NSMutableArray alloc]init];
    
    // Get planes atlas
    SKTextureAtlas *planesAtlas = [SKTextureAtlas atlasNamed:@"Planes"];
    
    // Loop through textureNames array and add textures
    for (NSString *textureName in textureNames) {
        [frames addObject:[planesAtlas textureNamed:textureName]];
    }
    
    // Calculate the time per frame
    CGFloat frameTime = duration / (CGFloat)frames.count;
    
    // Create and return animation action
    return [SKAction repeatActionForever:[SKAction animateWithTextures:frames timePerFrame:frameTime]];
    
}

@end
