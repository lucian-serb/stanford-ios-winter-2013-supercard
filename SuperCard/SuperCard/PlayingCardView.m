//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Andrei-Lucian Șerb on 10/8/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "PlayingCardView.h"

@implementation PlayingCardView

- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

- (void)setup
{
    // do initialization here
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:12.0];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    [roundedRect fill];
    // this also works because even thow we fill the entire view, it is clipped to the rounded rect
    // UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@.png", [self rankAsString], self.suit]];
    
    if (faceImage) {
        CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width * (1.0 - 0.8), self.bounds.size.height * (1.0 - 0.8));
        [faceImage drawInRect:imageRect];
    } else {
        
    }
    
    [self drawCorners];
}

- (NSString *)rankAsString
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"][self.rank];
}

- (void)drawCorners
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    UIFont *cornerFont = [UIFont systemFontOfSize:self.bounds.size.width * 0.20];
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", self.rankAsString, self.suit] attributes:@{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: cornerFont}];
    CGRect textBound;
    textBound.origin = CGPointMake(2.0, 2.0);
    textBound.size = [cornerText size];
    [cornerText drawInRect:textBound];
    [self saveContextAndRotateUpsideDown];
    [cornerText drawInRect:textBound];
    [self restoreContext];
}

- (void)saveContextAndRotateUpsideDown
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

- (void)restoreContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

@end
