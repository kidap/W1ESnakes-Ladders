//
//  BoardSquare.h
//  W1ESnakes&Ladders
//
//  Created by Karlo Pagtakhan on 03/13/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  SquareTypeSnake,
  SquareTypeLadder,
  SquareTypeNormal,
} SquareType;


@interface BoardSquare : NSObject

@property (nonatomic, assign) SquareType square;
@property (nonatomic, assign) NSInteger linkedTo;

-(instancetype)initWithSquareType: (SquareType)squareType;
//-(instancetype)initWithSquareType: (SquareType)squareType andLinkedTo:(NSInteger) linkedTo;
+(NSString *)convertSquareTypeToString:(SquareType) type;
@end
