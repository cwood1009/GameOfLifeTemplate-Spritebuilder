//
//  Grid.h
//  
//
//  Created by Chris Wood on 7/13/15.
//
//

#import "CCSprite.h"

@interface Grid : CCSprite



@property (nonatomic,assign) int totalAlive;
@property (nonatomic,assign) int generation;


-(void)evolveStep;
-(void)countNeighbors;
-(void)updateCreatures;

@end


