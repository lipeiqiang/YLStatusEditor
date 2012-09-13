//
//  YLViewController.m
//  YLStatusEditorTest
//
//  Created by li peiqiang on 12-9-13.
//  Copyright (c) 2012年 lipq. All rights reserved.
//
#import <CoreText/CoreText.h>
#import "YLViewController.h"
#import "YLStatusEditor.h"
@interface YLViewController ()

@end

@implementation YLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    YLStatusEditor*  v = [[YLStatusEditor alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    v.font = [UIFont systemFontOfSize:16.f];
    v.backgroundColor = [UIColor whiteColor];
    [v becomeFirstResponder];
    

    NSMutableAttributedString*  floatText =[[NSMutableAttributedString alloc] initWithString:@" 和 xx在一起 at三里屯"];
    UIColor* highLightColor = [UIColor blueColor];
    [floatText addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)highLightColor.CGColor range:NSMakeRange(0, floatText.length)];
    CTFontRef f = CTFontCreateWithName((__bridge CFStringRef)v.font.fontName, v.font.pointSize, NULL);
    [floatText addAttribute:(NSString*)kCTFontAttributeName value:(__bridge id)f range:NSMakeRange(0, floatText.length)];
    CFRelease(f);
    v.floatTextView.attributedString = floatText;
    [self.view addSubview:v];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
