//
//  Player.h
//  W1ESnakes&Ladders
//
//  Created by Karlo Pagtakhan on 03/13/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardSquare.h"

@interface Player : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *statusText;
@property (nonatomic, assign) NSInteger currentPosition;
@property (nonatomic, strong) BoardSquare *currentSquare;

-(instancetype) initWithName:(NSString *) name;
@end
