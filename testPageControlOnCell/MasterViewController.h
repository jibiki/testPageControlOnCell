//
//  MasterViewController.h
//  testPageControlOnCell
//
//  Created by 地引秀和 on 2014/07/06.
//  Copyright (c) 2014年 Jibiki Wroks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TitleCell;

@interface MasterViewController : UITableViewController <UIScrollViewDelegate>

@property (strong, nonatomic) TitleCell *dummyTitleCell;

@end
