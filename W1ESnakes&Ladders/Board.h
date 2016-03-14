//
//  Board.h
//  W1ESnakes&Ladders
//
//  Created by Karlo Pagtakhan on 03/13/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardSquare.h"
#import "Player.h"

typedef enum{
  GameDifficultyEasy,
  GameDifficultyMedium,
  GameDifficultyHard
}GameDifficulty;

@interface Board : NSObject

@property (nonatomic, strong) NSMutableArray *boardSquares;
@property (nonatomic, assign) NSInteger dice;
@property (nonatomic, assign) GameDifficulty *difficulty;
@property (nonatomic, assign) NSInteger lastsSquareIndex;

-(instancetype) initBoardWithSize: (NSInteger)size andDifficulty:(GameDifficulty)difficulty;

@end
