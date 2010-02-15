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
	CGColorRef			squareColor;
	BOOL				twoFingers;
	
	IBOutlet UILabel	*xField;
	IBOutlet UILabel	*yField;
	IBOutlet UILabel	*zField;
	
	
}

- (void) configureAccelerometer;
- (void) startRotation:(CGPoint)loc;
- (void) updateRotation:(CGPoint)loc;
- (void) clearRotation;

@end
