//
//  SquareMainView.h
//  redsquare
//
//  Created by Peter Holzkorn on 14.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SquareMainView : UIView {
	CGFloat				squareSize;
	CGFloat				squareRotation;
	CGColorRef			squareColor;
	BOOL				twoFingers;
	
	IBOutlet UILabel	*xField;
	IBOutlet UILabel	*yField;
	IBOutlet UILabel	*zField;
	
	
}

@end
