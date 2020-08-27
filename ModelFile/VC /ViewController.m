//
//  ViewController.m
//  YBModelFileDemo
//
//  Created by 杨波 on 2019/3/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "ViewController.h"
#import "YBModelFile.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
/* 全局公用配置 (只需设置在使用工具之前就行了) */
        
        //属性或方法是否空行
//        [YBMFConfig shareConfig].fileHHandler.ybmf_skipLine = YES;
//        [YBMFConfig shareConfig].fileMHandler.ybmf_skipLine = YES;
        //是否需要实现 NSCoding 或 NSCopying 协议
//        [YBMFConfig shareConfig].needCoding = NO;
//        [YBMFConfig shareConfig].needCopying = NO;
        //设置类名公用后缀
//        [YBMFConfig shareConfig].fileSuffix = @"File";
        //设置忽略类型
//        [YBMFConfig shareConfig].ignoreType = YBMFIgnoreTypeAllDigital | YBMFIgnoreTypeMutable;
        //设置文件划分策略
//        [YBMFConfig shareConfig].filePartitionMode = YBMFFilePartitionModeApart;
        //设置工程用的字典转模型框架
//        [YBMFConfig shareConfig].framework = YBMFFrameworkMJ;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //解析微博的json
//    [YBModelFile createFileWithName:@"WBTrends" data:@"weibo_0"];
    
    
    //解析json （带独有配置）

    YBMFConfig *config = [YBMFConfig defaultConfig];
    
    //        _framework = YBMFFrameworkYY;
    config.framework = YBMFFrameworkMJ;
    
    
    config.fileNoteHander.ybmf_developer = @"kunnan";
    [YBModelFile createFileWithName:@"KN" data:@"jack" config:config];
    
    
    [self testcalcTextSize];
    
}






#pragma mark - ******** 计算简单文本或者属性字符串的自适应尺寸
- (void)testcalcTextSize{
    
    self.view.backgroundColor = [UIColor greenColor];

    
    CFTimeInterval simpleTextUILabelInterval = 0;
     CFTimeInterval simpleTextNOUILabelInterval = 0;
     CFTimeInterval attributedTextUILabelInterval = 0;
     CFTimeInterval attributedTextNOUILabelInterval = 0;
     NSArray *testStringArray = @[@"您",@"好",@"中",@"国",@"w",@"i",@"d",@"t",@"h",@",",@"。",@"a",@"b",@"c",@"\n", @"1",@"5",@"2",@"j",@"A",@"J",@"0",@"🆚",@"👃",@" "];
     srand(time(NULL));
     for (int i = 0; i < 5000; i++) {
         //随机生成0到100个字符。
         int textLength = rand() % 100;
         NSMutableString *text = [NSMutableString new];
         for (int j = 0; j < textLength; j++) {
             [text appendString:testStringArray[rand()%testStringArray.count]];
         }
         if (text.length == 0)
             continue;
         
         CGSize fitSize = CGSizeMake(rand()%1000, rand()%1000);
         
         //测试简单文本。
         UILabel *label = [UILabel new];
         label.text = text;
         label.numberOfLines = rand() % 100;
         label.textAlignment = rand() % 5;
         label.lineBreakMode = rand() % 7;
         label.font = [UIFont systemFontOfSize:rand()%30 + 5.0];
        
         CFTimeInterval start = CACurrentMediaTime();
         CGSize sz1 = [label sizeThatFits:fitSize];
         simpleTextUILabelInterval += CACurrentMediaTime() - start;
         start = CACurrentMediaTime();
         CGSize sz2 = calcTextSize(fitSize, label.text, label.numberOfLines, label.font, label.textAlignment, label.lineBreakMode, label.minimumScaleFactor, CGSizeZero);
         simpleTextNOUILabelInterval += CACurrentMediaTime() - start;
         NSAssert(CGSizeEqualToSize(sz1, sz2), @"");
         
         //测试富文本
         NSRange range1 = NSMakeRange(0, rand()%text.length);
         NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
         paragraphStyle1.lineSpacing = rand() % 20;
         paragraphStyle1.firstLineHeadIndent = rand() %10;
         paragraphStyle1.paragraphSpacing = rand() % 30;
         paragraphStyle1.headIndent = rand() % 10;
         paragraphStyle1.tailIndent = rand() % 10;
         UIFont *font1 = [UIFont systemFontOfSize:rand() % 20 + 3.0];
         
         NSRange range2 = NSMakeRange(range1.length, text.length - range1.length);
         NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
         paragraphStyle2.lineSpacing = rand() % 20;
         paragraphStyle2.firstLineHeadIndent = rand() %10;
         paragraphStyle2.paragraphSpacing = rand() % 30;
         paragraphStyle2.headIndent = rand() % 10;
         paragraphStyle2.tailIndent = rand() % 10;
         UIFont *font2 = [UIFont systemFontOfSize:rand() % 20 + 3.0];
         
         NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
         [attributedText addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle1,NSFontAttributeName:font1} range:range1];
         [attributedText addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle2,NSFontAttributeName:font2} range:range2];

         label = [UILabel new];
         label.numberOfLines = rand() % 100;
         label.textAlignment = rand() % 5;
         label.lineBreakMode = rand() % 7;
         label.font = [UIFont systemFontOfSize:rand()%30 + 5.0];
         label.attributedText = attributedText;
         
         start = CACurrentMediaTime();
         CGSize sz3 = [label sizeThatFits:fitSize];
         attributedTextUILabelInterval += CACurrentMediaTime() - start;
         start = CACurrentMediaTime();
         CGSize sz4 = calcTextSize(fitSize, label.attributedText, label.numberOfLines, label.font, label.textAlignment, label.lineBreakMode, 0.0, CGSizeZero);
         attributedTextNOUILabelInterval += CACurrentMediaTime() - start;
         NSAssert(CGSizeEqualToSize(sz3, sz4), @"");
     }
     
     simpleTextUILabelInterval *= 1000;
     simpleTextNOUILabelInterval *= 1000;
     attributedTextUILabelInterval *= 1000;
     attributedTextNOUILabelInterval *= 1000;
     NSLog(@"简单文本计算UILabel总耗时(毫秒):%.3f, 平均耗时:%.3f",simpleTextUILabelInterval, simpleTextUILabelInterval / 5000);
     NSLog(@"简单文本计算非UILabel总耗时(毫秒):%.3f, 平均耗时:%.3f",simpleTextNOUILabelInterval, simpleTextNOUILabelInterval / 5000);
     NSLog(@"富文本计算UILabel总耗时(毫秒):%.3f, 平均耗时:%.3f",attributedTextUILabelInterval, attributedTextUILabelInterval / 5000);
     NSLog(@"富文本计算非UILabel总耗时(毫秒):%.3f, 平均耗时:%.3f",attributedTextNOUILabelInterval, attributedTextNOUILabelInterval / 5000);
         
    
    
}

/// 计算简单文本或者属性字符串的自适应尺寸
/// @param fitsSize 指定限制的尺寸，参考UILabel中的sizeThatFits中的参数的意义。
/// @param text 要计算的简单文本NSString或者属性字符串NSAttributedString对象
/// @param numberOfLines 指定最大显示的行数，如果为0则表示不限制最大行数
/// @param font 指定计算时文本的字体，可以为nil表示使用UILabel控件的默认17号字体
/// @param textAlignment 指定文本对齐方式默认是NSTextAlignmentNatural
/// @param lineBreakMode 指定多行时断字模式，默认可以用UILabel的默认断字模式NSLineBreakByTruncatingTail
/// @param minimumScaleFactor 指定文本的最小缩放因子，默认填写0。这个参数用于那些定宽时可以自动缩小文字字体来自适应显示的场景。
/// @param shadowOffset 指定阴影的偏移位置，需要注意的是这个偏移位置是同时指定了阴影颜色和偏移位置才有效。如果不考虑阴影则请传递CGSizeZero，否则阴影会参与尺寸计算。
/// @return 返回自适应的最合适尺寸
CGSize calcTextSize(CGSize fitsSize, id text, NSInteger numberOfLines, UIFont *font, NSTextAlignment textAlignment, NSLineBreakMode lineBreakMode, CGFloat minimumScaleFactor, CGSize shadowOffset) {
    
    if (text == nil || [text length] <= 0) {
        return CGSizeZero;
    }
    
    NSAttributedString *calcAttributedString = nil;

    //如果不指定字体则用默认的字体。
    if (font == nil) {
        font = [UIFont systemFontOfSize:17];
    }
    
    CGFloat systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
        
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = textAlignment;
    paragraphStyle.lineBreakMode = lineBreakMode;
    //系统大于等于11才设置行断字策略。
    if (systemVersion >= 11.0) {
        @try {
            [paragraphStyle setValue:@(1) forKey:@"lineBreakStrategy"];
        } @catch (NSException *exception) {}
    }
        
    if ([text isKindOfClass:NSString.class]) {
        calcAttributedString = [[NSAttributedString alloc] initWithString:(NSString *)text attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle}];
    } else {
        NSAttributedString *originAttributedString = (NSAttributedString *)text;
        //对于属性字符串总是加上默认的字体和段落信息。
        NSMutableAttributedString *mutableCalcAttributedString = [[NSMutableAttributedString alloc] initWithString:originAttributedString.string attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle}];
        
        //再附加上原来的属性。
        [originAttributedString enumerateAttributesInRange:NSMakeRange(0, originAttributedString.string.length) options:0 usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            [mutableCalcAttributedString addAttributes:attrs range:range];
        }];
        
        //这里再次取段落信息，因为有可能属性字符串中就已经包含了段落信息。
        if (systemVersion >= 11.0) {
            NSParagraphStyle *alternativeParagraphStyle = [mutableCalcAttributedString attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:NULL];
            if (alternativeParagraphStyle != nil) {
                paragraphStyle = (NSMutableParagraphStyle*)alternativeParagraphStyle;
            }
        }
        
        calcAttributedString = mutableCalcAttributedString;
    }
    
    //调整fitsSize的值, 这里的宽度调整为只要宽度小于等于0或者显示一行都不限制宽度，而高度则总是改为不限制高度。
    fitsSize.height = FLT_MAX;
    if (fitsSize.width <= 0 || numberOfLines == 1) {
        fitsSize.width = FLT_MAX;
    }
        
    //构造出一个NSStringDrawContext
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    context.minimumScaleFactor = minimumScaleFactor;
    @try {
        //因为下面几个属性都是未公开的属性，所以我们用KVC的方式来实现。
        [context setValue:@(numberOfLines) forKey:@"maximumNumberOfLines"];
        if (numberOfLines != 1) {
            [context setValue:@(YES) forKey:@"wrapsForTruncationMode"];
        }
        [context setValue:@(YES) forKey:@"wantsNumberOfLineFragments"];
    } @catch (NSException *exception) {}
       

    //计算属性字符串的bounds值。
    CGRect rect = [calcAttributedString boundingRectWithSize:fitsSize options:NSStringDrawingUsesLineFragmentOrigin context:context];
    
    //需要对段落的首行缩进进行特殊处理！
    //如果只有一行则直接添加首行缩进的值，否则进行特殊处理。。
    CGFloat firstLineHeadIndent = paragraphStyle.firstLineHeadIndent;
    if (firstLineHeadIndent != 0.0 && systemVersion >= 11.0) {
        //得到绘制出来的行数
        NSInteger numberOfDrawingLines = [[context valueForKey:@"numberOfLineFragments"] integerValue];
        if (numberOfDrawingLines == 1) {
            rect.size.width += firstLineHeadIndent;
        } else {
            //取内容的行数。
            NSString *string = calcAttributedString.string;
            NSCharacterSet *charset = [NSCharacterSet newlineCharacterSet];
            NSArray *lines = [string componentsSeparatedByCharactersInSet:charset]; //得到文本内容的行数
            NSString *lastLine = lines.lastObject;
            NSInteger numberOfContentLines = lines.count - (NSInteger)(lastLine.length == 0);  //有效的内容行数要减去最后一行为空行的情况。
            if (numberOfLines == 0) {
                numberOfLines = NSIntegerMax;
            }
            if (numberOfLines > numberOfContentLines)
                numberOfLines = numberOfContentLines;
            
            //只有绘制的行数和指定的行数相等时才添加上首行缩进！这段代码根据反汇编来实现，但是不理解为什么相等才设置？
            if (numberOfDrawingLines == numberOfLines) {
                rect.size.width += firstLineHeadIndent;
            }
        }
    }
    
    //取fitsSize和rect中的最小宽度值。
    if (rect.size.width > fitsSize.width) {
        rect.size.width = fitsSize.width;
    }
    
    //加上阴影的偏移
    rect.size.width += fabs(shadowOffset.width);
    rect.size.height += fabs(shadowOffset.height);
       
    //转化为可以有效显示的逻辑点, 这里将原始逻辑点乘以缩放比例得到物理像素点，然后再取整，然后再除以缩放比例得到可以有效显示的逻辑点。
    CGFloat scale = [UIScreen mainScreen].scale;
    rect.size.width = ceil(rect.size.width * scale) / scale;
    rect.size.height = ceil(rect.size.height *scale) / scale;
    
    return rect.size;
}

//上述方法的精简版本
NS_INLINE CGSize calcTextSizeV2(CGSize fitsSize, id text, NSInteger numberOfLines, UIFont *font) {
    return calcTextSize(fitsSize, text, numberOfLines, font, NSTextAlignmentNatural, NSLineBreakByTruncatingTail,0.0, CGSizeZero);
}


@end
