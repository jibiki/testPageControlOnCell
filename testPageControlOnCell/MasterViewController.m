//
//  MasterViewController.m
//  testPageControlOnCell
//
//  Created by 地引秀和 on 2014/07/06.
//  Copyright (c) 2014年 Jibiki Wroks. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "ImageScrollCell.h"
#import "TitleCell.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.dummyTitleCell = [self.tableView dequeueReusableCellWithIdentifier:@"TitleCell"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
        TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
        
        [self updateTitleCell:cell atIndexPath:indexPath];
//        cell.separatorInset = UIEdgeInsetsZero;
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        return cell;
    }
    else if (row == 1) {
        ImageScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        
        NSInteger numOfPages = 4;
        CGFloat width = cell.scrollView.bounds.size.width;
        CGFloat height = cell.scrollView.bounds.size.height;
        NSArray *colors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor yellowColor]];
        
        
        cell.scrollView.delegate = cell;
        cell.scrollView.clipsToBounds = NO;
        cell.scrollView.contentSize = CGSizeMake(numOfPages * width, height);
        for (int i = 0; i < numOfPages; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
            label.text = [NSString stringWithFormat:@"%dページ", i + 1];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = colors[i];
            [cell.scrollView addSubview:label];
            
        }
        
        cell.pageControl.numberOfPages = numOfPages;
        
        return cell;
    }
    
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self updateTitleCell:self.dummyTitleCell atIndexPath:indexPath];
            [self.dummyTitleCell layoutSubviews];
            CGFloat height = [self.dummyTitleCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            
            return height + 1;
            
        default:
            return 260;
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)updateTitleCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            TitleCell *titleCell = (TitleCell*)cell;
            titleCell.titleLabel.text = @"Quick brown fox jumps over the lazy dog.";
            break;
        }
            
        default:
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
