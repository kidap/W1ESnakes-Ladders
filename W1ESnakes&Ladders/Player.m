//
//  Player.m
//  W1ESnakes&Ladders
//
//  Created by Karlo Pagtakhan on 03/13/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "Player.h"

@implementation Player

-(instancetype) initWithName:(NSString *) name{
  if (self = [super init]) {
    _name = name;
    _currentPosition = 0;
    _currentSquare = [[BoardSquare alloc] init];
  }
  return self;
}
@end
