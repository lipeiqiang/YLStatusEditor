//
//  YLFloatTextView.m
//
//  Created by li peiqiang on 12-9-12.
//
#import <CoreText/CoreText.h>
#import "YLFloatTextView.h"

@implementation YLFloatTextView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
       [self addGestureRecognizer:singleTap];
    }
    return self;
}
- (void)setAttributedString:(NSMutableAttributedString *)attributedString
{
    if (_attributedString != attributedString)
    {
        _attributedString  =attributedString;
        [self setNeedsDisplay];
    }
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, ([self bounds]).size.height );
    CGContextScaleCTM(context, 1.0, -1.0);


    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(self.attributedString));
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat lineHeight = 14.f;
    CGRect otherRect =CGRectMake(0, 0, rect.size.width,rect.size.height);
    CGRect lineRect =CGRectMake(0, rect.size.height-lineHeight, self.firstLineMargin,lineHeight);
    CGPathAddRect(path, NULL, lineRect);
    CGPathAddRect(path, NULL, otherRect);
    
    
//    CGContextSetStrokeColorWithColor(context,[UIColor redColor].CGColor);
//    CGContextStrokeRect(context, otherRect);
//    CGContextSetStrokeColorWithColor(context,[UIColor blueColor].CGColor);
//    CGContextStrokeRect(context, CGRectInset(lineRect, 1, 1));

    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0,0), path, NULL);
    CTFrameDraw(frame, context);

}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect  spaceRect = CGRectMake(0, 0, self.firstLineMargin, self.font.lineHeight);
    if (!CGRectContainsPoint(spaceRect, point))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (void)tap:(UITapGestureRecognizer*)gesture {
    
    if (self.attributedString.length == 0)
    {
        return;
    }
    if (self.target && [self.target respondsToSelector:self.tapAction])
    {
        CGPoint  touchPoint = [gesture locationInView:self];
        CGRect  spaceRect = CGRectMake(0, 0, self.firstLineMargin, self.font.lineHeight);
        if (!CGRectContainsPoint(spaceRect, touchPoint))
        {
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.target performSelector:self.tapAction];
        }
    }
    
}



@end
