//
//  GameController.h
//  W1ESnakes&Ladders
//
//  Created by Karlo Pagtakhan on 03/13/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"

@interface GameController : NSObject


@property (nonatomic, strong) Board *boardGame;

@property (nonatomic, assign) Player *currentPlayer;
@property (nonatomic, strong) Player *player1;
@property (nonatomic, strong) Player *player2;
@property (nonatomic, assign) BOOL gameActive;


-(instancetype)initGameWithSize:(NSInteger)boardSize andDifficulty:(GameDifficulty)difficulty;
-(void)restartGame;
-(NSString *) rollDice;
@end
