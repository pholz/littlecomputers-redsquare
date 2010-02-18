//
//  SquareMainView.h
//  redsquare
//
//  Created by Peter Holzkorn on 14.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SquareMainView : UIView <UIAccelerometerDelegate> {
	CGFloat				squareSize;
	CGFloat				squareRotation;
	CGFloat				squareStartRotation;
	CGFloat				squareLastRotation;
	
	CGFloat				squareLastScale;
	CGFloat				squareScaleDelta;
	CGFloat				squareStartScale;
	CGColorRef			squareColor;
	BOOL				twoFingers;
	
	IBOutlet UILabel	*xField;
	IBOutlet UILabel	*yField;
	IBOutlet UILabel	*zField;
	
	enum MODE {
		rotate,
		scale,
		move
	} activeMode;
	
}

- (void) configureAccelerometer;
- (void) startRotation:(CGPoint)loc;
- (void) updateRotation:(CGPoint)loc;
- (void) clearRotation;
- (void) startScale:(CGPoint)p0 endpoint:(CGPoint)p1;
- (void) updateScale:(CGPoint)p0 endpoint:(CGPoint)p1;
- (void) clearScale;

@end
