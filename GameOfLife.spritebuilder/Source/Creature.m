//
//  Creature.m
//  
//
//  Created by Chris Wood on 7/13/15.
//
//

#import "Creature.h"

@implementation Creature

- (instancetype) initCreature {
    // since we made Creature inherit from CCSprint, 'super below refers to CCSprite
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    
    if (self) {
        self.isAlive = NO;
        
    }
    
    return self;
    
}

- (void)setIsAlive:(BOOL)newState {
    _isAlive = newState;
    
    self.visible = _isAlive;
    
}

@end
