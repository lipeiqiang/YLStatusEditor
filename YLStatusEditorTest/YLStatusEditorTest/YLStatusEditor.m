//
//  YLStatusEditor.m
//
//  Created by li peiqiang on 12-9-12.
//

#import "YLStatusEditor.h"

@implementation YLStatusEditor
@synthesize placeholder, placeholderColor;
@synthesize floatTextView;
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        
        floatTextView = [[YLFloatTextView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        floatTextView.font = self.font;
        [self addSubview:floatTextView];
        
        [floatTextView addObserver:self forKeyPath:@"attributedString" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self textChanged:nil];
}



- (void)textChanged:(NSNotification *)notification {
//    if ([[self placeholder] length] == 0)
//        return;
    if ([[self text] length] == 0 && floatTextView.attributedString.length ==0 ) {
        [[self viewWithTag:999] setAlpha:1];
    } else {
        [[self viewWithTag:999] setAlpha:0];
    }
    NSRange  reservedRange = self.selectedRange;
    self.selectedRange = NSMakeRange(self.text.length, 0);
    CGPoint cursorPosition = [self caretRectForPosition:self.selectedTextRange.start].origin;
    self.selectedRange = reservedRange;
    
    floatTextView.frame = CGRectMake(8, cursorPosition.y, self.frame.size.width-16, self.frame.size.height);
    floatTextView.firstLineMargin = cursorPosition.x;
    [floatTextView setNeedsDisplay];

}
- (void)setFlowText:(NSMutableAttributedString*)flowText
{
    floatTextView.attributedString = flowText;
    [floatTextView setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    
    if ([[self placeholder] length] > 0) {
        UILabel* label =  (UILabel*)[self viewWithTag:999];
        if (!label)
        {
            label = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, self.bounds.size.width - 16, self.bounds.size.height)];
            [self addSubview:label];
            
            [label setFont:self.font];
            [label setTextColor:self.placeholderColor];
            [label setText:self.placeholder];
            [label setTag:999];
            [label setNumberOfLines:100];
            [label setLineBreakMode:UILineBreakModeWordWrap];
            [self sendSubviewToBack:label];
        }
        [label setAlpha:0];
        CGSize labelSize = [label.text sizeWithFont:label.font
                                  constrainedToSize:label.frame.size lineBreakMode:label.lineBreakMode];
        CGRect frame = label.frame;
        frame.size.height = labelSize.height;
        label.frame = frame;
    }
    if ([[self text] length] == 0 && [[self placeholder] length] > 0 && floatTextView.attributedString.length == 0) {
        [[self viewWithTag:999] setAlpha:1];
    }
    else
    {
        
    }
    [super drawRect:rect];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"attributedString"])
    {
        [self setNeedsDisplay];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [floatTextView removeObserver:self forKeyPath:@"attributedString"];
}
@end