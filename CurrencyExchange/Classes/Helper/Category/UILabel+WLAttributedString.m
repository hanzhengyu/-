//
//  UILabel+WLAttributedString.m
//  NSMutableAttributedStringDemo
//
//  Created by wangguoliang on 16/7/26.
//  Copyright © 2016年 wangguoliang. All rights reserved.
//

#import "UILabel+WLAttributedString.h"
#import <CoreText/CoreText.h>
#import <objc/runtime.h>
@implementation UILabel (WLAttributedString)

//获取斜体
UIFont *GetVariationOfFontWithTrait(UIFont *baseFont, CTFontSymbolicTraits trait)
{
    CGFloat fontSize = [baseFont pointSize];
    CFStringRef baseFontName = (__bridge CFStringRef)[baseFont fontName];
    CTFontRef baseCTFont = CTFontCreateWithName(baseFontName, fontSize, NULL);
    CTFontRef ctFont = CTFontCreateCopyWithSymbolicTraits(baseCTFont, 0, NULL, trait, trait);
    NSString *variantFontName = CFBridgingRelease(CTFontCopyName(ctFont, kCTFontPostScriptNameKey));
    
    UIFont *variantFont = [UIFont fontWithName:variantFontName size:fontSize];
    CFRelease(ctFont);
    CFRelease(baseCTFont);
    return variantFont;
};

#pragma mark - 改变字段字体
- (void)wl_changeFontWithTextFont:(UIFont *)textFont
{
    [self wl_changeFontWithTextFont:textFont changeText:self.text];
}
- (void)wl_changeFontWithTextFont:(UIFont *)textFont changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSCaseInsensitiveSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSFontAttributeName value:textFont range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字段间距
- (void)wl_changeSpaceWithTextSpace:(CGFloat)textSpace
{
    [self wl_changeSpaceWithTextSpace:textSpace changeText:self.text];
}
- (void)wl_changeSpaceWithTextSpace:(CGFloat)textSpace changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSCaseInsensitiveSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:(id)kCTKernAttributeName value:@(textSpace) range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变行间距
- (void)wl_changeLineSpaceWithTextLineSpace:(CGFloat)textLineSpace
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:textLineSpace];
    [self wl_changeParagraphStyleWithTextParagraphStyle:paragraphStyle];
}
#pragma mark - 段落样式
- (void)wl_changeParagraphStyleWithTextParagraphStyle:(NSParagraphStyle *)paragraphStyle
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    [self setAttributedText:attributedString];
}

#pragma mark - 改变字段颜色
- (void)wl_changeColorWithTextColor:(UIColor *)textColor
{
    [self wl_changeColorWithTextColor:textColor changeText:self.text];
}
- (void)wl_changeColorWithTextColor:(UIColor *)textColor changeText:(NSString *)text
{
    [self wl_changeColorWithTextColor:textColor changeTexts:@[text]];
}

- (void)wl_changeColorWithTextColor:(UIColor *)textColor changeTexts:(NSArray <NSString *>*)texts
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    for (NSString *text in texts) {
        NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
        if (textRange.location != NSNotFound) {
            [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:textRange];
        }
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字段背景颜色
- (void)wl_changeBgColorWithBgTextColor:(UIColor *)bgTextColor
{
    [self wl_changeBgColorWithBgTextColor:bgTextColor changeText:self.text];
}
- (void)wl_changeBgColorWithBgTextColor:(UIColor *)bgTextColor changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSBackgroundColorAttributeName value:bgTextColor range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字段连笔字 value值为1或者0
- (void)wl_changeLigatureWithTextLigature:(NSNumber *)textLigature
{
    [self wl_changeLigatureWithTextLigature:textLigature changeText:self.text];
}
- (void)wl_changeLigatureWithTextLigature:(NSNumber *)textLigature changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSLigatureAttributeName value:textLigature range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字间距
- (void)wl_changeKernWithTextKern:(NSNumber *)textKern
{
    [self wl_changeKernWithTextKern:textKern changeText:self.text];
}
- (void)wl_changeKernWithTextKern:(NSNumber *)textKern changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSKernAttributeName value:textKern range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的删除线 textStrikethroughStyle 为NSUnderlineStyle
- (void)wl_changeStrikethroughStyleWithTextStrikethroughStyle:(NSNumber *)textStrikethroughStyle
{
    [self wl_changeStrikethroughStyleWithTextStrikethroughStyle:textStrikethroughStyle changeText:self.text];
}
- (void)wl_changeStrikethroughStyleWithTextStrikethroughStyle:(NSNumber *)textStrikethroughStyle changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSStrikethroughStyleAttributeName value:textStrikethroughStyle range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的删除线颜色
- (void)wl_changeStrikethroughColorWithTextStrikethroughColor:(UIColor *)textStrikethroughColor
{
    [self wl_changeStrikethroughColorWithTextStrikethroughColor:textStrikethroughColor changeText:self.text];
}
- (void)wl_changeStrikethroughColorWithTextStrikethroughColor:(UIColor *)textStrikethroughColor changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSStrikethroughColorAttributeName value:textStrikethroughColor range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的下划线 textUnderlineStyle 为NSUnderlineStyle
- (void)wl_changeUnderlineStyleWithTextStrikethroughStyle:(NSNumber *)textUnderlineStyle
{
    [self wl_changeUnderlineStyleWithTextStrikethroughStyle:textUnderlineStyle changeText:self.text];
}
- (void)wl_changeUnderlineStyleWithTextStrikethroughStyle:(NSNumber *)textUnderlineStyle changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:textUnderlineStyle range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的下划线颜色
- (void)wl_changeUnderlineColorWithTextStrikethroughColor:(UIColor *)textUnderlineColor
{
    [self wl_changeUnderlineColorWithTextStrikethroughColor:textUnderlineColor changeText:self.text];
}
- (void)wl_changeUnderlineColorWithTextStrikethroughColor:(UIColor *)textUnderlineColor changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSUnderlineColorAttributeName value:textUnderlineColor range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的颜色
- (void)wl_changeStrokeColorWithTextStrikethroughColor:(UIColor *)textStrokeColor
{
    [self wl_changeStrokeColorWithTextStrikethroughColor:textStrokeColor changeText:self.text];
}
- (void)wl_changeStrokeColorWithTextStrikethroughColor:(UIColor *)textStrokeColor changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSStrokeColorAttributeName value:textStrokeColor range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的描边
- (void)wl_changeStrokeWidthWithTextStrikethroughWidth:(NSNumber *)textStrokeWidth
{
    [self wl_changeStrokeWidthWithTextStrikethroughWidth:textStrokeWidth changeText:self.text];
}
- (void)wl_changeStrokeWidthWithTextStrikethroughWidth:(NSNumber *)textStrokeWidth changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSStrokeWidthAttributeName value:textStrokeWidth range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的阴影
- (void)wl_changeShadowWithTextShadow:(NSShadow *)textShadow
{
    [self wl_changeShadowWithTextShadow:textShadow changeText:self.text];
}
- (void)wl_changeShadowWithTextShadow:(NSShadow *)textShadow changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSShadowAttributeName value:textShadow range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的特殊效果
- (void)wl_changeTextEffectWithTextEffect:(NSString *)textEffect
{
    [self wl_changeTextEffectWithTextEffect:textEffect changeText:self.text];
}
- (void)wl_changeTextEffectWithTextEffect:(NSString *)textEffect changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSTextEffectAttributeName value:textEffect range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的文本附件
- (void)wl_changeAttachmentWithTextAttachment:(NSTextAttachment *)textAttachment
{
    [self wl_changeAttachmentWithTextAttachment:textAttachment changeText:self.text];
}
- (void)wl_changeAttachmentWithTextAttachment:(NSTextAttachment *)textAttachment changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSAttachmentAttributeName value:textAttachment range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的链接
- (void)wl_changeLinkWithTextLink:(NSString *)textLink
{
    [self wl_changeLinkWithTextLink:textLink changeText:self.text];
}
- (void)wl_changeLinkWithTextLink:(NSString *)textLink changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSLinkAttributeName value:textLink range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的基准线偏移 value>0坐标往上偏移 value<0坐标往下偏移
- (void)wl_changeBaselineOffsetWithTextBaselineOffset:(NSNumber *)textBaselineOffset
{
    [self wl_changeBaselineOffsetWithTextBaselineOffset:textBaselineOffset changeText:self.text];
}
- (void)wl_changeBaselineOffsetWithTextBaselineOffset:(NSNumber *)textBaselineOffset changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSBaselineOffsetAttributeName value:textBaselineOffset range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的倾斜 value>0向右倾斜 value<0向左倾斜
- (void)wl_changeObliquenessWithTextObliqueness:(NSNumber *)textObliqueness
{
    [self wl_changeObliquenessWithTextObliqueness:textObliqueness changeText:self.text];
}
- (void)wl_changeObliquenessWithTextObliqueness:(NSNumber *)textObliqueness changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSObliquenessAttributeName value:textObliqueness range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字粗细 0就是不变 >0加粗 <0加细
- (void)wl_changeExpansionsWithTextExpansion:(NSNumber *)textExpansion
{
    [self wl_changeExpansionsWithTextExpansion:textExpansion changeText:self.text];
}
- (void)wl_changeExpansionsWithTextExpansion:(NSNumber *)textExpansion changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSExpansionAttributeName value:textExpansion range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字方向 NSWritingDirection
- (void)wl_changeWritingDirectionWithTextExpansion:(NSArray *)textWritingDirection changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSWritingDirectionAttributeName value:textWritingDirection range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的水平或者竖直 1竖直 0水平
- (void)wl_changeVerticalGlyphFormWithTextVerticalGlyphForm:(NSNumber *)textVerticalGlyphForm changeText:(NSString *)text
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSRange textRange = [self.text rangeOfString:text options:NSBackwardsSearch];
    if (textRange.location != NSNotFound) {
        [attributedString addAttribute:NSVerticalGlyphFormAttributeName value:textVerticalGlyphForm range:textRange];
    }
    self.attributedText = attributedString;
}

#pragma mark - 改变字的两端对齐
- (void)wl_changeCTKernWithTextCTKern:(NSNumber *)textCTKern
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    [attributedString addAttribute:(id)kCTKernAttributeName value:textCTKern range:NSMakeRange(0, self.text.length-1)];
    self.attributedText = attributedString;
}


- (void)wl_changgeColors:(NSArray <UIColor *>*)colors texts:(NSArray<NSString *> *)texts
{
    for (int i = 0; i < colors.count; i++) {
        [self wl_changeColorWithTextColor:colors[i] changeText:texts[i]];
    }
}
- (void)wl_changgeColors:(NSArray <UIColor *>*)colors texts:(NSArray<NSString *> *)texts fonts:(NSArray <UIFont *>*)fonts
{
    [self wl_changgeColors:colors texts:texts];
    for (int i = 0; i < texts.count; i++) {
        [self wl_changeFontWithTextFont:fonts[i] changeText:texts[i]];
    }
}


#pragma mark - 复制粘贴功能
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copyText:));
}

- (void)attachTapHandler {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *g = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:g];
}

//  处理手势相应事件
- (void)handleTap:(UIGestureRecognizer *)g {
    [self becomeFirstResponder];
    
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyText:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:item]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    
}

//  复制时执行的方法
- (void)copyText:(id)sender {
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        if (self.text) {
            pBoard.string = self.text;
        } else {
            pBoard.string = self.attributedText.string;
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return [objc_getAssociatedObject(self, @selector(isCopyable)) boolValue];
}

- (void)setIsCopyable:(BOOL)number {
    objc_setAssociatedObject(self, @selector(isCopyable), [NSNumber numberWithBool:number], OBJC_ASSOCIATION_ASSIGN);
    [self attachTapHandler];
}

- (BOOL)isCopyable {
    return [objc_getAssociatedObject(self, @selector(isCopyable)) boolValue];
}


- (NSArray *)getLinesArrayOfStringInLabel{
    NSString *text = [self text];
    UIFont   *font = [self font];
    CGRect    rect = [self frame];
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return (NSArray *)linesArray;
}


@end
