//
//  CityLocationViewController.h
//  duangongbangUser
//
//  Created by ljx on 15/3/27.
//  Copyright (c) 2015年 duangongbang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityLocationViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) BOOL justChooseCity;
@property (assign, nonatomic) BOOL beforeRigistView;
@property (assign, nonatomic) BOOL chooseCityAndChangeSchool;

@end
