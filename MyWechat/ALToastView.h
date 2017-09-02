#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ALToastView : UIView {
@private
	UILabel *_textLabel;
}

+ (void)toastInView:(UIView *)parentView withText:(NSString *)text;
+ (void)removeToastView;
@end
