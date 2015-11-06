//
//  ViewController.m
//  yinong
//
//  Created by christian on 15/5/3.
//  Copyright (c) 2015年 coolsnow. All rights reserved.
//

#import "ViewController.h"
#import "ContentTableCell.h"
#import "YNHttpService.h"
#import "MJRefresh.h"
#import "SendContentController.h"

static NSString *CellTableIdentifier = @"ContenTableCellid";
/**
 * 随机数据
 */
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]
@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *contents;
@property (strong, nonatomic) NSString *up_to_date;
@property (strong, nonatomic) NSString *down_to_date;
@property (nonatomic) int pulltimes;
@property(nonatomic,retain) UITableView *tableView;

@property (nonatomic, strong) UITableViewCell *prototypeCell;

//@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation ViewController

- (void)example01
{
    __weak typeof(self) weakSelf = self;
    
    // 添加传统的下拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    // 马上进入刷新状态
    [self.tableView.legendHeader beginRefreshing];
    
}

- (void)example02
{
    __weak typeof(self) weakSelf = self;
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    YNHttpService *service = [[YNHttpService alloc] init];
    self.contents = [service listOfficalContents:@"0" upDate:@"" downDate:@""];
    NSLog(@"size == %lu",(unsigned long)[self.contents count]);
    UITableView *tableView = (id)[self.view viewWithTag:1];
    
//    tableView.rowHeight = 120;
    UINib *nib = [UINib nibWithNibName:@"ContentTableCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    
    UIEdgeInsets contentInset = tableView.contentInset;
    contentInset.top = 5;
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //[tableView setContentInset:contentInset];
    
    self.tableView =tableView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self performSelector:NSSelectorFromString(@"example01") withObject:nil];
    
    self.prototypeCell  = [self.tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    
    
    
        
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    NSDate *dateNow = [NSDate date];
    [formatter setDateFormat : @"yyyy-MM-dd HH:mm:ss"];
    self.up_to_date = [formatter stringFromDate:dateNow];
    self.down_to_date = [formatter stringFromDate:dateNow];
    NSLog(@"%@", self.up_to_date);
    
   // self.application.applicationIconBadgeNumber = 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0 ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier
                                                             forIndexPath:indexPath];
    
    NSDictionary *rowData = self.contents[indexPath.row];
    cell.contentLabel.text = rowData[@"content"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentTableCell *cell = (ContentTableCell *)self.prototypeCell;
    cell.translatesAutoresizingMaskIntoConstraints = NO;
    cell.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    cell.contentLabel.numberOfLines = 0;
    cell.contentLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.contentLabel.text = self.contents[indexPath.row][@"content"];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
   // NSLog(@"%@, h=%f", cell.contentLabel.text,size.height + 1);
    return 1  + size.height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}

- (NSMutableArray *)contents
{
    if (!_contents) {
        self.contents = [NSMutableArray array];
    }
    return _contents;
}

- (void)loadNewData
{
    YNHttpService *service = [[YNHttpService alloc] init];
    NSMutableArray *tmp = (NSMutableArray *)[service listOfficalContents:@"0" upDate:self.up_to_date downDate:@""];
    
    for(NSDictionary *d in tmp){
        @try {
            [self.contents insertObject:d atIndex:0];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        
    }

    // 刷新表格
    [self.tableView reloadData];
    
    
    
    // 拿到当前的上拉刷新控件，结束刷新状态
    [self.tableView.header endRefreshing];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    NSDate *dateNow = [NSDate date];
    [formatter setDateFormat : @"yyyy-MM-dd HH:mm:ss"];
    self.up_to_date = [formatter stringFromDate:dateNow];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0 ;
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    self.pulltimes++;
    YNHttpService *service = [[YNHttpService alloc] init];
    NSMutableArray *tmp = (NSMutableArray *)[service listOfficalContents:[[NSString alloc] initWithFormat:@"%d",self.pulltimes] upDate:@"" downDate:self.down_to_date];
    
    for(NSDictionary *d in tmp){
        @try {
            [self.contents addObject:d];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        
    }
    
    [self.tableView reloadData];
    [self.tableView.footer endRefreshing];
}

-(void)tapButton:(UIButton *)button
{
    NSLog(@"1111222 == %@",self.navigationController);
    
    SendContentController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"s"];
//    [self presentViewController:vc animated:YES completion:^{}];
    
    [self.navigationController pushViewController:vc  animated:YES];
   
}







@end