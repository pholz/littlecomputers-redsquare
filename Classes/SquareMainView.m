//
//  SquareMainView.m
//  redsquare
//
//  Created by Peter Holzkorn on 14.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SquareMainView.h"

#define kAccelerometerFrequency 10


@implementation SquareMainView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (void) awakeFromNib
{
	squareSize = 100.0f;
	twoFingers = NO;
	squareRotation = 0.5f;
	
	self.multipleTouchEnabled = YES;
	
	[self configureAccelerometer];
}

- (void) configureAccelerometer
{
	UIAccelerometer *acc = [UIAccelerometer sharedAccelerometer];
	
	if(acc)
	{
		acc.updateInterval = 1 / kAccelerometerFrequency;
		acc.delegate = self;
	}
	else
	{
		NSLog(@"not running on device");
	}
}

- (void) accelerometer:(UIAccelerometer*) accelerometer didAccelerate:(UIAcceleration*) acceleration
{
	UIAccelerationValue x, y, z;
	x = acceleration.x;
	y = acceleration.y;
	z = acceleration.z;
	
	xField.text = [NSString stringWithFormat:@"%.5f", x];
	yField.text = [NSString stringWithFormat:@"%.5f", y];
	zField.text = [NSString stringWithFormat:@"%.5f", z];
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	NSLog(@"touches began count %d, %@", [touches count], touches);
	
	if([touches count] > 1)
	{
		twoFingers = YES;
	}
	
	[self setNeedsDisplay];
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
	NSLog(@"touches moved count %d, %@", [touches count], touches);
	
	[self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
	NSLog(@"touches ended count %d, %@", [touches count], touches);
	
	twoFingers = NO;
	
	[self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect");
	
	CGFloat cx = rect.size.width/2, cy = rect.size.height/2;
	CGFloat half = squareSize/2;
	CGRect rect = CGRectMake(-half, -half, squareSize, squareSize);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, cx, cy);
	
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	
	if(!twoFingers)
	{
		CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
	}
	else
	{
		CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1.0);
	}
	
	CGContextFillRect(context, rect);
	CGContextStrokeRect(context, rect);
	
	CGContextRestoreGState(context);
}


- (void)dealloc {
    [super dealloc];
}


@end
