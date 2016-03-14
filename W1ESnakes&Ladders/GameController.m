//
//  GameController.m
//  W1ESnakes&Ladders
//
//  Created by Karlo Pagtakhan on 03/13/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "GameController.h"

@implementation GameController
-(instancetype)initGameWithSize:(NSInteger)boardSize andDifficulty:(GameDifficulty)difficulty{
  
  if (self = [super init]) {
      _boardGame = [[Board alloc] initBoardWithSize:boardSize andDifficulty:difficulty];
      _player1 = [[Player alloc] initWithName:@"Karlo"];
      _player2 = [[Player alloc] initWithName:@"Ychee"];
      _currentPlayer = _player1;
      _gameActive = YES;
  }
  
  return self;
  
}

-(void)restartGame{
  
}

-(NSString *) rollDice{
  NSString *gameStatus = @"";
  
  //Roll dice then Move the player
  NSInteger diceRoll = arc4random_uniform(6) + 1;
  if ([self movePlayer:self.currentPlayer byNumber: diceRoll] == self.boardGame.lastsSquareIndex){
    gameStatus = @"Game over";
    self.gameActive = NO;
  } else{
    //Change Player
    [self changePlayer];
    gameStatus = [NSString stringWithFormat:@"Waiting for %@ to roll the dice.", self.currentPlayer.name];
  }
  
  
  return gameStatus;
}

-(void) changePlayer{
  if ([self.currentPlayer isEqual:self.player1 ]){
    self.currentPlayer = self.player2;
  } else {
    self.currentPlayer = self.player1;
  }
}

-(NSInteger) movePlayer:(Player *) player byNumber:(NSInteger)numberOfMoves{
  BoardSquare *landedOnSquare = [[BoardSquare alloc] init];
  NSString *squareDescription = @"";
  
  NSInteger squareNumber = self.currentPlayer.currentPosition + numberOfMoves;
  NSInteger newSquareNumber = squareNumber;
  
  //Check if it is a special square
  if (newSquareNumber >= [self.boardGame.boardSquares count]){
    newSquareNumber = self.boardGame.lastsSquareIndex;
  }
  landedOnSquare = self.boardGame.boardSquares[newSquareNumber];
  
  
  //If players lands on a snake, players slides down. If players lands on a ladder, moves up.
  if (landedOnSquare.square == SquareTypeSnake && landedOnSquare.linkedTo != 0){
    newSquareNumber = landedOnSquare.linkedTo;
    landedOnSquare = self.boardGame.boardSquares[newSquareNumber];
    squareDescription = [BoardSquare convertSquareTypeToString:landedOnSquare.square];
    player.currentSquare = landedOnSquare;
    player.currentPosition = newSquareNumber;
    player.statusText = [NSString stringWithFormat:@"%@ rolled a %d and fell to %@. Landed on a %@ at %d", player.name, (int)numberOfMoves, [NSString stringWithFormat:@"%d",(int)newSquareNumber], squareDescription, (int)squareNumber ];
    
  } else if (landedOnSquare.square == SquareTypeLadder && landedOnSquare.linkedTo != 0){
    newSquareNumber = landedOnSquare.linkedTo;
    landedOnSquare = self.boardGame.boardSquares[newSquareNumber];
    squareDescription = [BoardSquare convertSquareTypeToString:landedOnSquare.square];
    player.currentSquare = landedOnSquare;
    player.currentPosition = newSquareNumber;
    player.statusText = [NSString stringWithFormat:@"%@ rolled a %d and moved to %@. Landed on a %@ at %d", player.name, (int)numberOfMoves, [NSString stringWithFormat:@"%d",(int)newSquareNumber], squareDescription, (int)squareNumber ];
    
  } else if ([self.boardGame.boardSquares count] >= (NSInteger)player.currentPosition){
    squareDescription = [BoardSquare convertSquareTypeToString:landedOnSquare.square];
    player.currentSquare = landedOnSquare;
    player.currentPosition = newSquareNumber;
    player.statusText = [NSString stringWithFormat:@"%@ rolled a %d and moved to %@.", player.name, (int)numberOfMoves, [NSString stringWithFormat:@"%d",(int)newSquareNumber] ];
  }
  
  if (player.currentPosition == self.boardGame.lastsSquareIndex){
    //Go to final square
    [self movePlayerToLastSquare:player];
    player.statusText =  [NSString stringWithFormat:@"%@ wins the game", player.name];
  }
  
  return newSquareNumber;
  
}
-(BoardSquare *) movePlayerToLastSquare:(Player *) player {
  BoardSquare *landedOnSquare = [[BoardSquare alloc] init];
  NSString *squareDescription = @"";
  
  NSInteger finalSquareNumber = self.boardGame.lastsSquareIndex;
  
  landedOnSquare = self.boardGame.boardSquares[finalSquareNumber];
  
  squareDescription = [BoardSquare convertSquareTypeToString:landedOnSquare.square];
  
  player.statusText = [NSString stringWithFormat:@"%@ moved to %@. Landed on final square",player.name, [NSString stringWithFormat:@"%d",(int)finalSquareNumber] ];
  
  return self.boardGame.boardSquares[finalSquareNumber];
  
}

@end
