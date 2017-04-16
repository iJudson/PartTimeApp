//
//  MerchantCATitleview.m
//  duangongbang
//
//  Created by ljx on 16/4/6.
//  Copyright © 2016年 duangongbang. All rights reserved.
//

#import "MerchantCATitleview.h"

@implementation MerchantCATitleview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame andTYpe:(NSString *)type
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIButton* centre = [[UIButton alloc] initWithFrame:CGRectMake(Width/2 - 83/2, 1,83, 28)];
        [centre setTitle:@"上传资料" forState:UIControlStateNormal];
        centre.backgroundColor = [UIColor clearColor];
        centre.layer.borderWidth = 0.5;
        centre.layer.borderColor = [UIColor whiteColor].CGColor;
        centre.titleLabel.font = [UIFont systemFontOfSize:14];
        centre.layer.cornerRadius = 4;
        [centre setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:centre];
        
        UIImageView * imgright = [[UIImageView alloc]initWithFrame:CGRectMake(centre.frame.origin.x + centre.frame.size.width + 5, 10, 12, 12)];
        imgright.image = [UIImage imageNamed:@"icon_arrows"];
        [self addSubview:imgright];
        
        UIImageView * imgleft = [[UIImageView alloc]initWithFrame:CGRectMake(centre.frame.origin.x - 17, 10, 12, 12)];
        imgleft.image = [UIImage imageNamed:@"icon_arrows"];
        [self addSubview:imgleft];
        
        UIButton* right = [[UIButton alloc] initWithFrame:CGRectMake(imgright.frame.origin.x + imgright.frame.size.width + 5, 1,83, 28)];
        [right setTitle:@"等待审核" forState:UIControlStateNormal];
        right.backgroundColor = [UIColor clearColor];
        right.layer.borderWidth = 0.5;
        right.layer.borderColor = [UIColor whiteColor].CGColor;
        right.titleLabel.font = [UIFont systemFontOfSize:14];
        right.layer.cornerRadius = 4;
        [right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:right];
        
        UIButton* left = [[UIButton alloc] initWithFrame:CGRectMake(imgleft.frame.origin.x - 88, 1,83, 28)];
        [left setTitle:@"信息填写" forState:UIControlStateNormal];
        left.backgroundColor = [UIColor clearColor];
        left.layer.borderWidth = 0.5;
        left.layer.borderColor = [UIColor whiteColor].CGColor;
        left.titleLabel.font = [UIFont systemFontOfSize:14];
        left.layer.cornerRadius = 4;
        [left setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:left];
        
        
                if ([type isEqualToString:@"1"]) {
                    left.backgroundColor =[UIColor whiteColor];
                    [left setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    left.layer.cornerRadius = 4;
                }else if ([type isEqualToString:@"2"])
                {
                    centre.backgroundColor =[UIColor whiteColor];
                    [centre setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    centre.layer.cornerRadius = 4;
                }else if ([type isEqualToString:@"3"])
                {
                    right.backgroundColor =[UIColor whiteColor];
                    [right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    right.layer.cornerRadius = 4;
                }
        
    }
    
    return self;
}

@end
