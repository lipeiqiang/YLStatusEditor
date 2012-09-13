//
//  YLStatusEditor.h
//
//  Created by li peiqiang on 12-9-12.
//

#import <UIKit/UIKit.h>
#import "YLFloatTextView.h"
@interface YLStatusEditor : UITextView <UITextViewDelegate> {
    NSString                *placeholder;
    UIColor                  *placeholderColor;
    YLFloatTextView           *floatTextView;
}
@property(nonatomic, retain) NSString *placeholder;
@property(nonatomic, retain) UIColor *placeholderColor;
@property(nonatomic, readonly)YLFloatTextView*  floatTextView;
- (void)textChanged:(NSNotification*)notification;
- (void)setFlowText:(NSMutableAttributedString*)flowText;
@end

