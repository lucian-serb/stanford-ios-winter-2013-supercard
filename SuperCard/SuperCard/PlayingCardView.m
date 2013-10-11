//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Andrei-Lucian Șerb on 10/8/13.
//  Copyright (c) 2013 Andrei-Lucian Șerb. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView ()

@property (nonatomic) CGFloat faceCardScaleFactor;

@end

@implementation PlayingCardView

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.8

- (CGFloat)faceCardScaleFactor
{
    if (!_faceCardScaleFactor) {
        _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    }
    
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

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

#define PIP_FONT_SCALE_FACTOR 0.2
#define PIP_HOFFSET_PERCERTANGE 0.165
#define PIP_VOFFSET1_PERCENTAGE 0.263
#define PIP_VOFFSET2_PERCENTAGE PIP_VOFFSET1_PERCENTAGE / 2
#define PIP_VOFFSET3_PERCENTAGE PIP_VOFFSET1_PERCENTAGE / 3
#define PIP_VOFFSET4_PERCENTAGE PIP_VOFFSET3_PERCENTAGE * 2

- (void)drawPips
{
    if ((self.rank == 1) || (self.rank == 3) || (self.rank == 5) || (self.rank == 9)) {
        [self drawPipsWithHorizontalOffset:0.0 verticalOffset:0.0 mirroredVerticaly:NO];
    }
    
    if ((self.rank == 6) || (self.rank == 7) || (self.rank == 8)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCERTANGE verticalOffset:0.0 mirroredVerticaly:NO];
    }
    
    if ((self.rank == 2) || (self.rank == 3)) {
        [self drawPipsWithHorizontalOffset:0.0 verticalOffset:PIP_VOFFSET1_PERCENTAGE mirroredVerticaly:YES];
    }
    
    if ((self.rank == 4) || (self.rank == 5) || (self.rank == 6) || (self.rank == 7) || (self.rank == 8) || (self.rank ==9) || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCERTANGE verticalOffset:PIP_VOFFSET1_PERCENTAGE mirroredVerticaly:YES];
    }
    
    if ((self.rank == 7) || (self.rank == 8)) {
        [self drawPipsWithHorizontalOffset:0.0 verticalOffset:PIP_VOFFSET2_PERCENTAGE mirroredVerticaly:(self.rank != 7)];
    }
    
    if ((self.rank == 9) || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCERTANGE verticalOffset:PIP_VOFFSET3_PERCENTAGE mirroredVerticaly:YES];
    }
    
    if (self.rank == 10) {
        [self drawPipsWithHorizontalOffset:0.0 verticalOffset:PIP_VOFFSET4_PERCENTAGE mirroredVerticaly:YES];
    }
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                   mirroredVerticaly:(BOOL)mirroredVerticaly
{
    [self drawPipsWithHorizontalOffset:hoffset verticalOffset:voffset upsideDown:NO];
    
    if (mirroredVerticaly) {
        [self drawPipsWithHorizontalOffset:hoffset verticalOffset:voffset upsideDown:YES];
    }
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                          upsideDown:(BOOL)upsideDown
{
    if (upsideDown) {
        [self saveContextAndRotateUpsideDown];
    }
    
    CGPoint middle = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    UIFont *pipFont = [UIFont systemFontOfSize:self.bounds.size.width * (self.rank == 1 ? PIP_FONT_SCALE_FACTOR * 2 : PIP_FONT_SCALE_FACTOR)];
    NSAttributedString *attributedSuit = [[NSAttributedString alloc] initWithString:self.suit attributes:@{NSFontAttributeName: pipFont}];
    CGSize pipSize = [attributedSuit size];
    CGPoint pipOrigin = CGPointMake(middle.x - pipSize.width / 2.0 - hoffset * self.bounds.size.width, middle.y - pipSize.height / 2.0 - voffset * self.bounds.size.height);
    [attributedSuit drawAtPoint:pipOrigin];
    
    if (hoffset) {
        pipOrigin.x += hoffset * 2.0 * self.bounds.size.width;
        [attributedSuit drawAtPoint:pipOrigin];
    }
    
    if (upsideDown) {
        [self restoreContext];
    }
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:12.0];
    [roundedRect addClip];
    // this also works because even thow we fill the entire view, it is clipped to the rounded rect
    // UIRectFill(self.bounds);
    if (self.faceUp) {
        [[UIColor whiteColor] setFill];
        [roundedRect fill];
        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@.png", [self rankAsString], self.suit]];
        
        if (faceImage) {
            CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width * (1.0 - self.faceCardScaleFactor), self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
            [faceImage drawInRect:imageRect];
        } else {
            [self drawPips];
        }
        
        [self drawCorners];
    } else {
        [[UIColor brownColor] setFill];
        [roundedRect fill];
        UIImage *faceImage = [UIImage imageNamed:@"cardback.png"];
        CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width * (1.0 - 0.95), self.bounds.size.height * (1.0 - 0.85));
        [faceImage drawInRect:imageRect];
    }
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
}

- (NSString *)rankAsString
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"][self.rank];
}

- (void)drawCorners
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    UIFont *cornerFont = [UIFont systemFontOfSize:self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
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

- (void)pinch:(UIPinchGestureRecognizer *)recognizer
{
    if ((recognizer.state == UIGestureRecognizerStateChanged) || (recognizer.state == UIGestureRecognizerStateEnded)) {
        self.faceCardScaleFactor *= recognizer.scale;
        recognizer.scale = 1;
    }
}

@end
