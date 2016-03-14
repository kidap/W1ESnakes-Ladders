//
//  ViewController.m
//  W1ESnakes&Ladders
//
//  Created by Karlo Pagtakhan on 03/13/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"


@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *boardSizeInput;
@property (strong, nonatomic) IBOutlet UISegmentedControl *difficultyOptions;
@property (strong, nonatomic) IBOutlet UILabel *gameStatus;
@property (strong, nonatomic) IBOutlet UILabel *player1Status;
@property (strong, nonatomic) IBOutlet UILabel *player2Status;
@property (strong, nonatomic) IBOutlet UILabel *gameHeaderLabel;
@property (strong, nonatomic) IBOutlet UIButton *rollButton;

@end

@implementation ViewController
GameController *gameHandler;

- (IBAction)startGame:(id)sender {
  GameDifficulty difficultySelected;
  
  //Set the difficulty
  if (self.difficultyOptions.selectedSegmentIndex == 0){
    difficultySelected = GameDifficultyEasy;
  } else if (self.difficultyOptions.selectedSegmentIndex == 1){
    difficultySelected = GameDifficultyMedium;
  } else if (self.difficultyOptions.selectedSegmentIndex == 2){
    difficultySelected = GameDifficultyHard;
  }
  
  //Instantiate the game
  if ([self.boardSizeInput.text intValue] != 0) {
    gameHandler = [gameHandler initGameWithSize:[self.boardSizeInput.text intValue] andDifficulty:difficultySelected ];
  }
}

- (IBAction)rollDice:(id)sender {
  //If the game is inactive, go back to main screen to restart the game. Else, roll the dice
  if (!gameHandler.gameActive){
    //[self startGame:self];
    [self.rollButton setTitle:@"Roll" forState:UIControlStateNormal];
    self.player1Status.text = @"";
    self.player2Status.text = @"";
    self.gameStatus.text = @"Roll the dice";
    
    [self performSegueWithIdentifier:@"restartGame" sender:self];
  } else {
    self.gameStatus.text = [gameHandler rollDice];
    self.player1Status.text = gameHandler.player1.statusText;
    self.player2Status.text = gameHandler.player2.statusText;
  }
  
  //If the game just ended, change the buttom to a restart button to allow use to go back to main screen
  if (!gameHandler.gameActive){
    [self.rollButton setTitle:@"Restart" forState:UIControlStateNormal];
  }
  
}

-(void)viewDidAppear:(BOOL)animated{
  //Get the gameHandler instance from the App Delegate
  AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
  if (appDelegate.gameHandler){
    gameHandler = appDelegate.gameHandler;
  }
  
  //Set the header of the game screen
  if ([gameHandler.boardGame.boardSquares count] != 0) {
    self.gameHeaderLabel.text = [NSString stringWithFormat:@"%d square-board", (int)[gameHandler.boardGame.boardSquares count] ];
  }
}

-(void)viewDidLoad{
  self.player1Status.text = @"";
  self.player2Status.text = @"";
  self.gameStatus.text = @"Roll the dice";
}

@end
