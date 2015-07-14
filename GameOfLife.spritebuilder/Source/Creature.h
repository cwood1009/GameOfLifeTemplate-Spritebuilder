//
//  Creature.h
//  
//
//  Created by Chris Wood on 7/13/15.
//
//

#import "CCSprite.h"

@interface Creature : CCSprite

// stores the current state of the creature
@property (nonatomic, assign) BOOL isAlive;

// stores the amount of living neighbors
@property (nonatomic, assign) NSInteger livingNeighbors;

-(id)initCreature;


@end
