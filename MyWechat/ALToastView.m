//
//  ALToastView.h
//
//  Created by Alex Leutgöb on 17.07.11.
//  Copyright 2011 alexleutgoeb.com. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ALToastView.h"

static UIView *currentToast;

@interface ALToastView ()

@property (nonatomic, readonly) UILabel *textLabel;

@end

@implementation ALToastView

@synthesize textLabel = _textLabel;

#pragma mark - NSObject

- (id)initWithText:(NSString *)text {
	if ((self = [self initWithFrame:CGRectZero])) {
		// Add corner radius
		self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
		self.layer.cornerRadius = 5;
		self.autoresizingMask = UIViewAutoresizingNone;
		self.autoresizesSubviews = NO;
		
		// Init and add label
		_textLabel = [[UILabel alloc] init];
		_textLabel.text = text;
		_textLabel.font = [UIFont systemFontOfSize:54];
		_textLabel.textColor = [UIColor whiteColor];
		_textLabel.adjustsFontSizeToFitWidth = NO;
        _textLabel.textAlignment = NSTextAlignmentCenter;
		_textLabel.backgroundColor = [UIColor clearColor];
		[_textLabel sizeToFit];
		
		[self addSubview:_textLabel];
		_textLabel.frame = CGRectOffset(_textLabel.frame, 10, 5);
	}
	
	return self;
}

#pragma mark - Public

+ (void)toastInView:(UIView *)parentView withText:(NSString *)text {
	// Add new instance to queue
	ALToastView *view = [[ALToastView alloc] initWithText:text];
  
    CGFloat lWidth = 60;
    CGFloat lHeight = 60;
	CGFloat pWidth = parentView.frame.size.width;
	CGFloat pHeight = parentView.frame.size.height;
	
	// Change toastview frame
	view.frame = CGRectMake((pWidth - lWidth - 20) / 2., pHeight - lHeight - 60, lWidth + 20, lHeight + 10);
    view.center = CGPointMake(parentView.frame.size.width / 2, parentView.frame.size.height / 2);
    view.textLabel.center = CGPointMake(view.frame.size.width / 2, view.frame.size.height / 2);
	view.alpha = 0.9f;
	
	if (currentToast == nil) {
        currentToast = view;
        [parentView addSubview:view];
	} else {
        [currentToast removeFromSuperview];
		currentToast = view;
        [parentView addSubview:view];
	}
}

+ (void)removeToastView {
    [currentToast removeFromSuperview];
    currentToast = nil;
}
@end
