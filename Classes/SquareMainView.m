//
//  SquareMainView.m
//  redsquare
//
//  Created by Peter Holzkorn on 14.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SquareMainView.h"
#import <Math.h>

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
	squareRotation = 0.0f;
	squareStartRotation = 0.0f;
	squareLastRotation = 0.0f;
	squareLastScale = 1.0f;
	squareScaleDelta = 0.0f;
	squareStartScale = 0.0f;
	self.multipleTouchEnabled = YES;
	
	activeMode = rotate;
	
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
	//NSLog(@"touches began count %d, %@", [touches count], touches);
	
	if([touches count] > 1)
	{
		twoFingers = YES;
		activeMode = scale;
		
		NSArray* touchArr = [touches allObjects];
		CGPoint p0 = [[touchArr objectAtIndex:0] locationInView:self];
		CGPoint p1 = [[touchArr objectAtIndex:1] locationInView:self];
		
		[self startScale:p0 endpoint:p1];
	}
	else
	{
		activeMode = rotate;
		[self startRotation:[[touches anyObject] locationInView:self]];
	}
	
	
	
	
	[self setNeedsDisplay];
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
	//NSLog(@"touches moved count %d, %@", [touches count], touches);
	
	if(activeMode == rotate && [touches count] > 1)
	{
		[self clearRotation];
		activeMode = scale;
		
		NSArray* touchArr = [touches allObjects];
		CGPoint p0 = [[touchArr objectAtIndex:0] locationInView:self];
		CGPoint p1 = [[touchArr objectAtIndex:1] locationInView:self];
		
		[self startScale:p0 endpoint:p1];
		
		return;
	}
	
	if(activeMode == rotate)
		[self updateRotation:[[touches anyObject] locationInView:self]];
	
	if(activeMode == scale && [touches count] > 1)
	{
		NSArray* touchArr = [touches allObjects];
		CGPoint p0 = [[touchArr objectAtIndex:0] locationInView:self];
		CGPoint p1 = [[touchArr objectAtIndex:1] locationInView:self];
		
		[self updateScale:p0 endpoint:p1];
	}
	
	[self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
	//NSLog(@"touches ended count %d, %@", [touches count], touches);
	
	twoFingers = NO;
	
	if(activeMode == rotate)
		[self clearRotation];
	else if(activeMode == scale)
		[self clearScale];
	
	[self setNeedsDisplay];
}

- (void) startScale:(CGPoint)p0 endpoint:(CGPoint)p1
{
	float dist = sqrt(pow(p1.x - p0.x, 2) + pow(p1.y - p0.y, 2));
	squareStartScale = dist;
}

- (void) updateScale:(CGPoint)p0 endpoint:(CGPoint)p1
{
	float dist = sqrt(pow(p1.x - p0.x, 2) + pow(p1.y - p0.y, 2));
	squareScaleDelta = dist - squareStartScale;
}

- (void) clearScale
{
	squareLastScale = squareScaleDelta + squareLastScale;
	squareScaleDelta = 0;
}

- (void) startRotation:(CGPoint)loc
{
	float x = loc.x - CGRectGetWidth([self frame])/2.0f;
	float y = -1.0f * (loc.y - CGRectGetHeight([self frame])/2.0f);
	float rad = atan2(y,x);
	//NSLog(@"%f, %f ---- RAD: %fPI",x,y,rad/3.14);
	
	squareStartRotation = rad;
}

- (void) updateRotation:(CGPoint)loc
{
	float x = loc.x - CGRectGetWidth([self frame])/2.0f;
	float y = -1.0f * (loc.y - CGRectGetHeight([self frame])/2.0f);
	float rad = atan2(y,x);
	
	squareRotation = -1.0f * (rad - squareStartRotation);
	
}

- (void) clearRotation
{
	squareLastRotation = squareRotation + squareLastRotation;
	squareRotation = 0;
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect");
	
	CGFloat cx = rect.size.width/2, cy = rect.size.height/2;
	CGFloat half = squareSize/2;
	CGRect redrect = CGRectMake(-half, -half, squareSize, squareSize);
	
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
	
	float scale = (squareScaleDelta+squareLastScale);
	scale = scale * 0.005 + 1.0f;
	if(scale < 0.5f) scale = 0.5f;
	CGContextScaleCTM(context, scale, scale);
	
	NSLog(@"rot: %.3f /// start: %.3f /// last: %.3f", squareRotation, squareStartRotation, squareLastRotation);
	CGContextRotateCTM(context, squareRotation+squareLastRotation);
	
	CGContextFillRect(context, redrect);
	CGContextStrokeRect(context, redrect);
	
	CGContextRestoreGState(context);
}


- (void)dealloc {
    [super dealloc];
}


@end
