//
//  LPMessageCell.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/3/31.
//  Copyright © 2016年 lingpin. All rights reserved.


#import "LPMessageCell.h"
#define LPMessageCellGlobalPadding 10
@interface LPMessageCell ()

// 定义左边整体视图的属性
@property(nonatomic,strong)UIImageView *wholeHeaderView;

// 定义群名字Label属性
@property(nonatomic,strong)UILabel *groupNameLabel;

// 定义显示聊天的Label属性
@property(nonatomic,strong)UILabel *chatLabel;

// 定义时间属性
@property(nonatomic,strong)UILabel *timeLabel;

// 定义右边新消息提醒属性
@property(nonatomic,strong)UIImageView *remindMessagesImage;

// 定义分割线属性
@property(nonatomic,strong)UIView *seperatorLine;
@end

//static NSString *reuseIdentifier = @"LPMessageCell";
@implementation LPMessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self prepareForCell];
    }
    return self;
}

- (void)prepareForCell{
    //添加子控件
    [self.contentView addSubview:self.wholeHeaderView];
    [self.contentView addSubview:self.groupNameLabel];
    [self.contentView addSubview:self.chatLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.remindMessagesImage];
    [self.contentView addSubview:self.seperatorLine];

    //添加约束
    [self.wholeHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(LPMessageCellGlobalPadding);
        make.left.equalTo(self.contentView).offset(LPMessageCellGlobalPadding);
        make.height.width.mas_equalTo(80);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wholeHeaderView).offset(LPMessageCellGlobalPadding);
        make.right.equalTo(self.contentView).offset(-LPMessageCellGlobalPadding);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    [self.remindMessagesImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.timeLabel);
        make.bottom.equalTo(self.wholeHeaderView).offset(-LPMessageCellGlobalPadding);
        make.height.width.mas_offset(7);
    }];
    [self.groupNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wholeHeaderView.mas_right).offset(LPMessageCellGlobalPadding);
        make.top.equalTo(self.wholeHeaderView).offset(LPMessageCellGlobalPadding);
        make.right.equalTo(self.timeLabel.mas_left);
    }];
    [self.chatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.groupNameLabel);
        make.centerY.equalTo(self.remindMessagesImage);
        make.right.equalTo(self.remindMessagesImage.mas_left);
    }];

    [self.seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.groupNameLabel);
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5f);
    }];
}


#pragma mark - getter

-(UIView *)wholeHeaderView{
    if (!_wholeHeaderView) {
        _wholeHeaderView = [[UIImageView alloc] init];
        _wholeHeaderView.backgroundColor = [UIColor greenColor];
    }
    return _wholeHeaderView;
}

-(UILabel *)groupNameLabel{
    if (!_groupNameLabel) {
        _groupNameLabel = [[UILabel alloc] init];
        _groupNameLabel.font = [UIFont boldSystemFontOfSize:16];
        _groupNameLabel.contentMode = UIViewContentModeBottomLeft;
        _groupNameLabel.textColor = [UIColor darkGrayColor];
    }
    return _groupNameLabel;
}

-(UILabel *)chatLabel{
    if (!_chatLabel) {
        _chatLabel = [[UILabel alloc] init];
        _chatLabel.font = [UIFont systemFontOfSize:13];
        _chatLabel.contentMode = UIViewContentModeBottomLeft;
        _chatLabel.textColor = [UIColor darkGrayColor];
    }
    return _chatLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.textColor = [UIColor darkGrayColor];
    }
    return _timeLabel;
}

-(UIImageView *)remindMessagesImage{
    if (!_remindMessagesImage) {
        _remindMessagesImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 7)];
        _remindMessagesImage.backgroundColor = [UIColor redColor];
        _remindMessagesImage.layer.cornerRadius = 3.5;
        _remindMessagesImage.clipsToBounds = YES;
        
    }
    return _remindMessagesImage;
}

-(UIView *)seperatorLine{
    if (!_seperatorLine) {
        _seperatorLine = [[UIView alloc] init];
        _seperatorLine.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _seperatorLine;
}

#pragma mark - setter

-(void)setGroupImage:(UIImage *)groupImage{
    _groupImage = groupImage;
    self.wholeHeaderView.image = groupImage;
}

-(void)setGroupName:(NSString *)groupName{
    _groupName = groupName;
    self.groupNameLabel.text = groupName;
}

-(void)setChatMessage:(NSString *)chatMessage{
    _chatMessage = chatMessage;
    self.chatLabel.text = chatMessage;
}

-(void)setTimeMessage:(NSString *)timeMessage{
    _timeMessage = timeMessage;
    self.timeLabel.text = timeMessage;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
@end
