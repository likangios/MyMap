//
//  TestTableViewController.m
//  MyMap
//
//  Created by 李康 on 15/6/11.
//  Copyright (c) 2015年 Luck. All rights reserved.
//

#import "TestTableViewController.h"
#import "TestTableViewCell.h"
#import "ReadViewController.h"

@interface TestTableViewController ()
{
    NSInteger count;
    
    NSMutableArray *_tableViewData;
}
@end

@implementation TestTableViewController
- (NSString *)dataFilePath:(NSString *)sender{
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                        NSUserDomainMask,
                                                        YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:sender];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"story" ofType:@"txt"];
    //gbk编码 如果txt文件为utf-8的则使用NSUTF8StringEncoding
    NSStringEncoding gbk = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //定义字符串接收从txt文件读取的内容
    NSString *str = [[NSString alloc] initWithContentsOfFile:plistPath encoding:gbk error:nil];
    //将字符串转为nsdata类型
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    //将nsdata类型转为NSDictionary
    NSDictionary *pDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"story.plist"];
    //输入写入
    
    [pDic writeToFile:filename atomically:YES];*/
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"精品推荐" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"续读" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    self.title = @"书架";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"story" ofType:@"txt"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSArray *array =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    _tableViewData = [NSMutableArray arrayWithArray:array];
    
    count = ceil(_tableViewData.count/3.0);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Uncomment the following line to preserve selection between presentations.
//     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)leftItemClick{
    
}
- (void)rightItemClick{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.

    return  count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (nil == cell) {
        cell = [[TestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell CleanImages];
    [cell setBookclick:^(NSDictionary *dic){
        
    NSLog(@"dic is %@",dic[@"bookname"]);
        
        
        ReadViewController *read = [[ReadViewController alloc]init];
        read.dic = dic;
        [self.navigationController pushViewController:read animated:YES];        
    }];
    cell.images = [self getDicArrayWithRow:indexPath.row];;
    
    
//    cell.textLabel.text = [NSString stringWithFormat:@"indexPath.row--%ld",(long)indexPath.row];
    
    return cell;
}
- (NSArray *)getDicArrayWithRow:(NSInteger)row{

    int imgcount = 3;
    if (row*3+3>_tableViewData.count) {
        
    imgcount = _tableViewData.count- row*3.0;
        
    }
    NSLog(@"row  is %d",row);
    NSMutableArray *array = [NSMutableArray array];
    for (int i =0 ; i<imgcount; i++) {
        
        NSDictionary *dic0 = _tableViewData[row*3+i];
        
        [array addObject:dic0];
    }
    
    return array;
    
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        count--;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    NSLog(@"fromIndexPath %ld toIndexPath %ld",fromIndexPath.row,toIndexPath.row);
    
}


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
