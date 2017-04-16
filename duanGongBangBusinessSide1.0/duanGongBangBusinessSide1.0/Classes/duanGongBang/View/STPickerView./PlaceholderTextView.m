//
//  PlaceholderTextView.m
//  SaleHelper
//
//  Created by gitBurning on 14/12/8.
//  Copyright (c) 2014年 Burning_git. All rights reserved.
//

#import "PlaceholderTextView.h"

@interface PlaceholderTextView()<UITextViewDelegate>
{
    UILabel *PlaceholderLabel;

}

@end
@implementation PlaceholderTextView

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        
        
        
        [self awakeFromNib];
        
    }
    return self;
}


- (void)awakeFromNib {
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidEnd:) name:UITextViewTextDidEndEditingNotification object:self];


    float left=5,top=2,hegiht=30;
    
    self.placeholderColor = [UIColor lightGrayColor];
    PlaceholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(left, top
                                                               , CGRectGetWidth(self.frame)-2*left, hegiht)];
    
//    int Tox = 0;
//    if (IS_IPHONE_6) {
//         Tox = 55;
//    }
//    
    if (self.tag == 1022) {
        PlaceholderLabel.frame  =CGRectMake(Width - 222, top
                                            ,100, hegiht);
        PlaceholderLabel.textAlignment = NSTextAlignmentRight;

    }
    
    PlaceholderLabel.font=self.placeholderFont?self.placeholderFont:self.font;
    [self addSubview:PlaceholderLabel];
    PlaceholderLabel.text=self.placeholder;
        PlaceholderLabel.textColor=self.placeholderColor;
        PlaceholderLabel.text=self.placeholder;

    [self setContentInset:UIEdgeInsetsMake(2, 3, 0, -12)];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)setPlaceholder:(NSString *)placeholder{
    if (self.text.length == 0 || [self.text isEqualToString:@""]) {
        PlaceholderLabel.hidden = NO;
        
        PlaceholderLabel.text=placeholder;

    }
    else
    {
        PlaceholderLabel.hidden = YES;
    }
    
//    _placeholder=placeholder;

    
}

- (void)DidEnd:(NSNotification*)noti
{
    
    
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];;
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    [paragraphStyle setLineSpacing:7];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
//    self.attributedText = attributedString;

    
    CGSize size;
    
    int A;
    int B;
    
    if ([self.Type isEqualToString:@"Mc"]) {
        A = 54;
        B = 164;
    }
    else
    {
        A = 30;
        B = 140;
    }
    

    if (self.tag == 1012) {
    size =  [self.text boundingRectWithSize:CGSizeMake(Width - A, 999999999) options:NSStringDrawingUsesLineFragmentOrigin
                                                                 attributes:@{
                                                                              NSFontAttributeName:[UIFont systemFontOfSize:15],
                                                                            }context:nil].size;
    }
    else
    {
        size =  [self.text boundingRectWithSize:CGSizeMake(Width - B, 999999999) options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{
                                                  NSFontAttributeName:[UIFont systemFontOfSize:15],
                                                  }context:nil].size;
    }
    
    [self.delegate_TextH refreshlaceholderTextH:size.height andIndexPath:self.btnIndexPath andtext:self.text andtag:self.tag];

}
-(void)DidChange:(NSNotification*)noti{
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        PlaceholderLabel.hidden=YES;
    }
    
    if (self.text.length > 0) {
        PlaceholderLabel.hidden=YES;
    }
    else{
        PlaceholderLabel.hidden=NO;
    }
    
    
    
//    CGSize size =  [self.text boundingRectWithSize:CGSizeMake(Width - 30, 999999999) options:NSStringDrawingUsesLineFragmentOrigin
//                                        attributes:@{
//                                                     NSFontAttributeName:[UIFont systemFontOfSize:15],
//                                                     }context:nil].size;

    if (self.tag == 1022) {

    self.textAlignment = NSTextAlignmentRight;

    }
    
//    NSLog(@"%f",size.height);
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [PlaceholderLabel removeFromSuperview];
    
//    [super dealloc];

}

@end

