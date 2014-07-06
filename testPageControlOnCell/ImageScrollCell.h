//
//  ImageScrollCell.h
//  testPageControlOnCell
//
//  Created by 地引秀和 on 2014/07/06.
//  Copyright (c) 2014年 Jibiki Wroks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScrollCell : UITableViewCell <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (assign, nonatomic) NSInteger currentPage;

- (IBAction)didChangeValuePageControl:(id)sender;

@end
