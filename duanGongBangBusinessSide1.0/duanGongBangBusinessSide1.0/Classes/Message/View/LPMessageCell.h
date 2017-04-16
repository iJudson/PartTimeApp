//
//  LPMessageCell.h
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/3/31.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPMessageCell : UITableViewCell

// 定义显示的群图片属性
@property(nonatomic,copy)UIImage *groupImage;
// 定义群名字属性
@property(nonatomic,copy)NSString *groupName;
// 定义聊天信息属性
@property(nonatomic,copy)NSString *chatMessage;
// 定义时间信息属性
@property(nonatomic,copy)NSString *timeMessage;

@end
