//
//  Board.m
//  W1ESnakes&Ladders
//
//  Created by Karlo Pagtakhan on 03/13/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "Board.h"

@implementation Board
@synthesize lastsSquareIndex = _lastsSquareIndex;

-(NSInteger) lastsSquareIndex{
  return _boardSquares.count - 1;
}
-(void) setLastsSquareIndex:(NSInteger)lastsSquareIndex{
  _lastsSquareIndex = lastsSquareIndex;
}

-(instancetype) initBoardWithSize: (NSInteger)size andDifficulty:(GameDifficulty)difficulty {
  if (self = [super init]){
    
    int boardSize = ((int)size * (int)size)  - 1;
    _lastsSquareIndex = boardSize;
    
    _boardSquares = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= boardSize ;i++ ){
      BoardSquare *square = [[BoardSquare alloc] initWithSquareType:SquareTypeNormal];
      [_boardSquares addObject:square];
    }
    
    //today snaks and ladder = 40% of the board
    int specialSquare =  (int)boardSize * 0.40;
    int snakeCtr = 0;
    int ladderCtr = 0;
    if (difficulty == GameDifficultyEasy){
      snakeCtr = specialSquare * 0.25;
      ladderCtr = (int)specialSquare - snakeCtr;
    } else if (difficulty == GameDifficultyMedium){
      snakeCtr = specialSquare * 0.50;
      ladderCtr = (int)specialSquare - snakeCtr;
    } else if (difficulty == GameDifficultyHard){
      snakeCtr = specialSquare * 0.75;
      ladderCtr = (int)specialSquare - snakeCtr;
    }
    
    //Add ladders
    for (int x = 1; x <= ladderCtr; x++ ){
      BOOL squareNotSet = YES;
      
      //Check is square was set to a snake
      while (squareNotSet) {
        //Get random number to set as a head of the snake
        int randomSquareNumber = arc4random_uniform(boardSize);
        
        while (randomSquareNumber <=1 ||
               randomSquareNumber >= _lastsSquareIndex - 1) {
          randomSquareNumber = arc4random_uniform(boardSize);
        }
        
        
        BoardSquare *selectedSquare = _boardSquares[randomSquareNumber];
        
        //Make sure the square is not yet a snake
        if ( selectedSquare.square == SquareTypeNormal ){
          BoardSquare *destinationSquare;
          int randomSquareNumberDestination = 0;
          BOOL squareDestinationSet = YES;
          int loopCtr = 0;
          int numberRange = (int)_lastsSquareIndex - randomSquareNumber;
          
          
          while (randomSquareNumberDestination <=0 ||
                 randomSquareNumberDestination >= _lastsSquareIndex ||
                 randomSquareNumberDestination == randomSquareNumber ||
                 destinationSquare.square != SquareTypeNormal){
            randomSquareNumberDestination = arc4random_uniform(numberRange) + randomSquareNumber;
            destinationSquare = _boardSquares[randomSquareNumberDestination];
            squareDestinationSet = YES;
            
            if (loopCtr >= numberRange){
              squareDestinationSet = NO;
              NSLog(@"Stuck on infinite loop. Trying to get out.");
              break;
            }
            
            loopCtr ++;
          }
          if (squareDestinationSet) {
            //Set properties of the ladder
            selectedSquare.linkedTo = randomSquareNumberDestination;
            selectedSquare.square = SquareTypeLadder;
            NSLog(@"Ladder at %d going to %d", randomSquareNumber, randomSquareNumberDestination);
            
            //Set the destination as a ladder
            destinationSquare.square = SquareTypeLadder;
            squareNotSet = NO;
          } else {
            squareNotSet = YES;
          }
        }
      }
      
    }
    //Add snakes
    for (int x = 1; x <= snakeCtr; x++ ){
      BOOL squareNotSet = YES;
      
      //Check is square was set to a snake
      while (squareNotSet) {
        //Get random number to set as a head of the snake
        int randomSquareNumber = arc4random_uniform(boardSize);
        
        while (randomSquareNumber <=1 ||
               randomSquareNumber >= _lastsSquareIndex) {
          randomSquareNumber = arc4random_uniform(boardSize);
        }
        
        
        BoardSquare *selectedSquare = _boardSquares[randomSquareNumber];
        
        //Make sure the square is not yet a snake
        if ( selectedSquare.square == SquareTypeNormal ){
          BoardSquare *destinationSquare;
          BOOL squareDestinationSet = YES;
          int loopCtr = 0;
          int randomSquareNumberDestination = 0;
          
          while (randomSquareNumberDestination <=0 ||
                 randomSquareNumberDestination >= _lastsSquareIndex ||
                 randomSquareNumberDestination == randomSquareNumber ||
                 destinationSquare.square != SquareTypeNormal ){
            randomSquareNumberDestination = arc4random_uniform(randomSquareNumber);
            destinationSquare = _boardSquares[randomSquareNumberDestination];
            
            if (loopCtr >= boardSize){
              squareDestinationSet = NO;
              NSLog(@"Stuck on infinite loop. Trying to get out.");
              break;
            }
            
            loopCtr ++;
          }
          
          if (squareDestinationSet) {
            //Set properties of the square
            selectedSquare.linkedTo = randomSquareNumberDestination;
            selectedSquare.square = SquareTypeSnake;
            NSLog(@"Snake at %d going to %d", randomSquareNumber, randomSquareNumberDestination);
            
            //Set the destination as a snake
            destinationSquare.square = SquareTypeSnake;
            squareNotSet = NO;
          } else {
            squareNotSet = YES;
          }
        }
      }
    }
    
    
  }
  
  return self;
}


@end
