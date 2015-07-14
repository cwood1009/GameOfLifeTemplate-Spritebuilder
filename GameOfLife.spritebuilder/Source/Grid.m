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

-(void) evolveStep {
    // update each creatures neighbor count
    [self countNeighbors];
    
    //update each creatures state
    [self updateCreatures];
    
    //update generation label
    _generation++;
    
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

- (void) countNeighbors {
    // iterate through the rows
    // note that ns array has method count that will return the number of elements in that array
    for (int i = 0; i < [_gridArray count]; i++) {
        //run through the columns in the row
        for (int j = 0; j < [_gridArray[i] count]; j++){
            // access the creature in the cell that cooresponds to the current row/column
            Creature *currentCreature = _gridArray[i][j];
            
            // remember that every creature has a 'livingNeighbors' Property
            currentCreature.livingNeighbors = 0;
            
            // examine every cell around the current one
            // row on top, current row and row below
            for (int x = (i-1); x <= (i+1); x++) {
                // column to left, current column, column to right
                for (int y = (j-1); y <= (j+1); y++) {
                    // check that the cell isnt off the screen
                    BOOL isIndexValid;
                    isIndexValid = [self isIndexValidForX:x andY:y];
                    
                    //skip over all cells that are off screen AND the current cell
                    if (!((x == i) && (y == j)) && isIndexValid) {
                        Creature *neighbor = _gridArray[x][y];
                        if (neighbor.isAlive){
                            currentCreature.livingNeighbors += 1;
                        }
                    }
                }
            }
                
        }

    }
}
                         
- (void) updateCreatures {
    // run through rows
    for (int i = 0; i < [_gridArray count]; i++) {
        // run through columns in row
        for (int j = 0; j < [_gridArray[i]count]; j++) {
            Creature *currentCreature = _gridArray[i][j];
            
            if (currentCreature.livingNeighbors == 3) {
                currentCreature.isAlive = true;
                
            }else if (currentCreature.livingNeighbors <= 1 || currentCreature.livingNeighbors >= 4) {
                currentCreature.isAlive = false;
            }
        }
    }
}
                         
- (BOOL) isIndexValidForX:(int)x andY:(int)y {
    BOOL isIndexValid = YES;
    if (x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS) {
        isIndexValid = NO;
    }
    return isIndexValid;
    
}
@end
