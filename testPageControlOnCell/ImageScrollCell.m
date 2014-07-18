//
//  ImageScrollCell.m
//  testPageControlOnCell
//
//  Created by 地引秀和 on 2014/07/06.
//  Copyright (c) 2014年 Jibiki Wroks. All rights reserved.
//

#import "ImageScrollCell.h"

@implementation ImageScrollCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([[scrollView class] isSubclassOfClass:[UIScrollView class]]) {
        CGFloat pageWidth = scrollView.frame.size.width;
        if ((NSInteger)fmod(scrollView.contentOffset.x, pageWidth) == 0) {
            NSInteger currentPage = scrollView.contentOffset.x / pageWidth;
            self.currentPage = currentPage;
 
            // Page Control
            self.pageControl.currentPage = currentPage;
            
            NSLog(@"scrollView.width=%f", scrollView.frame.size.width);
        }
        
    }
}

#pragma mark - PageControl

- (IBAction)didChangeValuePageControl:(id)sender
{
    NSInteger currentPage = self.pageControl.currentPage;
    self.currentPage = currentPage;
    
    // Scroll View
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * currentPage;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

@end
