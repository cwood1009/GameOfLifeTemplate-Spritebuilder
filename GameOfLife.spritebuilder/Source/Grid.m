//
//  Grid.m
//  
//
//  Created by Chris Wood on 7/13/15.
//
//

#import "Grid.h"
#import "Creature.h"

static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}

- (void) onEnter {
    [super onEnter];
    
    [self setupGrid];
    
    // accept touches on the grid
    
    self.userInteractionEnabled = YES;
    
}

- (void)setupGrid {
    // divide the grid's size by the number of columns/rows to figure out the right width/heigh of each cell
    _cellHeight = self.contentSize.height / GRID_ROWS;
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    
    float x = 0;
    float y = 0;
    
    // initialize the array as blank
    _gridArray = [NSMutableArray array];
    
    // initialize creatures
    for (int i = 0; i < GRID_ROWS; i++) {
        // this is how you create two dimensional array
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        for (int j = 0; j < GRID_COLUMNS; j++){
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0,0);
            creature.position = ccp(x,y);
            [self addChild:creature];
            
            // shorthand to access an array inside an array
            _gridArray[i][j] = creature;
            
            
            x += _cellWidth;
            
        }
        
        y += _cellHeight;
        
    }
    
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    // get the x,y coordinates of the touch
    CGPoint touchLocation = [touch locationInNode:self];
    
    // get the creature at that location
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    
    //invert its state
    creature.isAlive = !creature.isAlive;
    
}

- (Creature *)creatureForTouchPosition:(CGPoint)touchPosition {
    
    int row;
    int column;
    
    // get the row and column that was touched
    row = touchPosition.y / _cellHeight;
    column = touchPosition.x / _cellWidth;
    
    return _gridArray[row][column];
    
    
}

@end
