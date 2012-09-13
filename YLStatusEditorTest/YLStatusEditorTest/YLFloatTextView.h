//
//  YLFloatTextView.h
//  
//  Created by li peiqiang on 12-9-12.
//

#import <UIKit/UIKit.h>

@interface YLFloatTextView : UIView
{

}
@property(nonatomic,strong)NSMutableAttributedString* attributedString;
@property(nonatomic)CGFloat     firstLineMargin;
@property(nonatomic,strong)UIFont*  font;
@property(nonatomic,weak)id  target;
@property(nonatomic)SEL  tapAction;
@end
