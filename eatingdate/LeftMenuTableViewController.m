//
//  LeftMenuTableViewController.m
//  eatingdate
//
//  Created by 駿逸 陳 on 2015/7/5.
//  Copyright (c) 2015年 駿逸 陳. All rights reserved.
//

#import "LeftMenuTableViewController.h"
#import "ProfileCell.h"
#import "MenuWithIconCell.h"
#import "MenuWithOutIconCell.h"

@interface LeftMenuTableViewController ()

@end

@implementation LeftMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 13;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ProfileCell *cell0;
    MenuWithIconCell *cell1;
    MenuWithOutIconCell *cell2;
    
    if (indexPath.row == 0) {
        cell0 = [tableView dequeueReusableCellWithIdentifier:@"ProfileCell" forIndexPath:indexPath];
        //會員檔案
        
        return cell0;
        
    }else if (indexPath.row == 1){
        cell1 = [tableView dequeueReusableCellWithIdentifier:@"MenuWithIconCell" forIndexPath:indexPath];
        cell1.logoView.image = [UIImage imageNamed:@""];
        cell1.titleLabel.text = @"首頁";
        cell1.unReadCircle.hidden = true;
        cell1.unReadNumberLabel.hidden = true;
        return cell1;
    }else if (indexPath.row == 2){
        cell1 = [tableView dequeueReusableCellWithIdentifier:@"MenuWithIconCell" forIndexPath:indexPath];
        cell1.logoView.image = [UIImage imageNamed:@"btn_menu_publish__pressed"];
        cell1.titleLabel.text = @"發佈約";
        cell1.unReadCircle.hidden = true;
        cell1.unReadNumberLabel.hidden = true;
        return cell1;
    }else if (indexPath.row == 3){
        cell1 = [tableView dequeueReusableCellWithIdentifier:@"MenuWithIconCell" forIndexPath:indexPath];
        cell1.logoView.image = [UIImage imageNamed:@"btn_menu_schedule_pressed"];
        cell1.titleLabel.text = @"吃飯行事曆";
        cell1.unReadCircle.hidden = true;
        cell1.unReadNumberLabel.hidden = true;
        return cell1;
    }else if (indexPath.row == 4){
        cell1 = [tableView dequeueReusableCellWithIdentifier:@"MenuWithIconCell" forIndexPath:indexPath];
        cell1.logoView.image = [UIImage imageNamed:@"btn_menu_mail_pressed"];
        cell1.titleLabel.text = @"訊息通知";
        cell1.unReadCircle.hidden = true;
        cell1.unReadNumberLabel.hidden = true;
        return cell1;
    }else if (indexPath.row == 5){
        cell1 = [tableView dequeueReusableCellWithIdentifier:@"MenuWithIconCell" forIndexPath:indexPath];
        cell1.logoView.image = [UIImage imageNamed:@"btn_menu_heart_pressed"];
        cell1.titleLabel.text = @"口袋名單";
        cell1.unReadCircle.hidden = true;
        cell1.unReadNumberLabel.hidden = true;
        return cell1;
    }else if (indexPath.row == 6){
        cell1 = [tableView dequeueReusableCellWithIdentifier:@"MenuWithIconCell" forIndexPath:indexPath];
        cell1.logoView.image = [UIImage imageNamed:@"btn_menu_history_pressed"];
        cell1.titleLabel.text = @"歷史清單";
        cell1.unReadCircle.hidden = true;
        cell1.unReadNumberLabel.hidden = true;
        return cell1;
    }else if (indexPath.row == 7){
        cell1 = [tableView dequeueReusableCellWithIdentifier:@"MenuWithIconCell" forIndexPath:indexPath];
        cell1.logoView.image = [UIImage imageNamed:@"btn_menu_gvip_pressed"];
        cell1.titleLabel.text = @"GVIP";
        cell1.unReadCircle.hidden = true;
        cell1.unReadNumberLabel.hidden = true;
        return cell1;
    }else if (indexPath.row == 8){
        cell1 = [tableView dequeueReusableCellWithIdentifier:@"MenuWithIconCell" forIndexPath:indexPath];
        cell1.logoView.image = [UIImage imageNamed:@"btn_menu_tvip_pressed"];
        cell1.titleLabel.text = @"TVIP";
        cell1.unReadCircle.hidden = true;
        cell1.unReadNumberLabel.hidden = true;
        return cell1;
    }else if (indexPath.row == 9){
        cell1 = [tableView dequeueReusableCellWithIdentifier:@"MenuWithIconCell" forIndexPath:indexPath];
        cell1.logoView.image = [UIImage imageNamed:@"btn_menu_point_pressed"];
        cell1.titleLabel.text = @"點數查詢";
        cell1.unReadCircle.hidden = true;
        cell1.unReadNumberLabel.hidden = true;
        return cell1;
    }else if (indexPath.row == 10){
        cell1 = [tableView dequeueReusableCellWithIdentifier:@"MenuWithIconCell" forIndexPath:indexPath];
        cell1.logoView.image = [UIImage imageNamed:@"btn_menu_setting_pressed"];
        cell1.titleLabel.text = @"設定";
        cell1.unReadCircle.hidden = true;
        cell1.unReadNumberLabel.hidden = true;
        return cell1;
    } else if (indexPath.row == 11){
        cell2 = [tableView dequeueReusableCellWithIdentifier:@"MenuWithOutIconCell" forIndexPath:indexPath];
        cell2.titleLabel.text = @"意見回饋";
        return cell2;
    } else {
        cell2 = [tableView dequeueReusableCellWithIdentifier:@"MenuWithOutIconCell" forIndexPath:indexPath];
        cell2.titleLabel.text = @"服務條款";
        return cell2;
    }
    
    
    
    // Configure the cell...
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 120;
    }else {
        return 80;
    }
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
