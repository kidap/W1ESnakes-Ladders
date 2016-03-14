//
//  BoardSquare.m
//  W1ESnakes&Ladders
//
//  Created by Karlo Pagtakhan on 03/13/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "BoardSquare.h"

@implementation BoardSquare


-(instancetype)initWithSquareType: (SquareType)squareType{
  self = [super init];
  if (self) {
    _square   = squareType;
  }
  return self;
}

//-(instancetype)initWithSquareType: (SquareType)squareType andLinkedTo:(NSInteger) linkedTo{
//  self = [super init];
//  if (self) {
//    _square   = squareType;
//    _linkedTo = linkedTo;
//  }
//  return self;
//}

+(NSString *)convertSquareTypeToString:(SquareType) type{
  switch (type) {
    case SquareTypeNormal:
      return @"normal";
      break;
      
    case SquareTypeLadder:
      return @"ladder";
      break;
      
    case SquareTypeSnake:
      return @"snake";
      break;
      
    default:
      break;
  }
  return nil;
}
@end
