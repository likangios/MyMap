//
//  MuLuTableViewController.m
//  MyMap
//
//  Created by 李康 on 15/6/25.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "MuLuTableViewController.h"
#import "ShuQianViewController.h"


@interface MuLuTableViewController ()

@end

@implementation MuLuTableViewController
-(void)setTableViewData:(NSArray *)tableViewData{
    _tableViewData = tableViewData;
    [self.tableView reloadData];
    self.tableView.tableFooterView = [[UIView alloc]init];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.toolbarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"button_shuqian_on"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    rightItem.tintColor = [UIColor grayColor];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)rightBarButtonItemClick{
    
    ShuQianViewController *shuqian = [[ShuQianViewController alloc]init];

    [self.navigationController pushViewController:shuqian animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.tableViewData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = self.tableViewData[indexPath.row];
    
    cell.textLabel.text = dic[@"title"];
    
    if ([self isShowAccessory:indexPath.row]) {
        cell.accessoryType =UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType =UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.tableViewData[indexPath.row];
    if (self.cellBlocks) {
        _cellBlocks(dic);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)isShowAccessory:(NSInteger)index{
    
        NSDictionary *dic = self.tableViewData[index];
        NSNumber *startNum = dic[@"startPage"];
        NSNumber *endNum = dic[@"endPage"];
        if (self.currentPage>=startNum.integerValue&&self.currentPage<=endNum.integerValue) {
            return YES;
        }
        
    return NO;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
