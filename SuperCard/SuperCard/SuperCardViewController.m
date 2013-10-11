//
//  SuperCardViewController.m
//  SuperCard
//
//  Created by Andrei-Lucian Șerb on 10/8/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "SuperCardViewController.h"
#import "PlayingCardView.h"

@interface SuperCardViewController ()

@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end

@implementation SuperCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPlayingCardView:(PlayingCardView *)playingCardView
{
    _playingCardView = playingCardView;
    playingCardView.rank = 13; // K
    playingCardView.suit = @"♥";
    [playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:playingCardView action:@selector(pinch:)]];
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender
{
    [UIView transitionWithView:self.playingCardView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{self.playingCardView.faceUp = !self.playingCardView.faceUp;}
                    completion:NULL];
}

@end
