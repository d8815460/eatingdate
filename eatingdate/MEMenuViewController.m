// MEMenuViewController.m
// TransitionFun
//
// Copyright (c) 2013, Michael Enriquez (http://enriquez.me)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MEMenuViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "ProfileCell.h"
#import "MenuWithIconCell.h"
#import "MenuWithOutIconCell.h"

@interface MEMenuViewController ()
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) UINavigationController *transitionsNavigationController;
@end

@implementation MEMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // topViewController is the transitions navigation controller at this point.
    // It is initially set as a User Defined Runtime Attributes in storyboards.
    // We keep a reference to this instance so that we can go back to it without losing its state.
    
    //一進來的第一個首頁
    self.transitionsNavigationController = (UINavigationController *)self.slidingViewController.topViewController;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

#pragma mark - Properties

#pragma mark - UITableViewDataSource

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *homeNav = [homeStoryBoard instantiateViewControllerWithIdentifier:@"profileNav"];
        self.slidingViewController.topViewController = homeNav;
    }else if (indexPath.row == 1) {
        UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *homeNav = [homeStoryBoard instantiateViewControllerWithIdentifier:@"homeNav"];
        self.slidingViewController.topViewController = homeNav;
    }else if (indexPath.row == 2) {
        UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *homeNav = [homeStoryBoard instantiateViewControllerWithIdentifier:@"homeNav"];
        self.slidingViewController.topViewController = homeNav;
    }else if (indexPath.row == 3) {
        UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *homeNav = [homeStoryBoard instantiateViewControllerWithIdentifier:@"homeNav"];
        self.slidingViewController.topViewController = homeNav;
    }else if (indexPath.row == 4) {
        UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *homeNav = [homeStoryBoard instantiateViewControllerWithIdentifier:@"homeNav"];
        self.slidingViewController.topViewController = homeNav;
    }else if (indexPath.row == 5) {
        UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *homeNav = [homeStoryBoard instantiateViewControllerWithIdentifier:@"homeNav"];
        self.slidingViewController.topViewController = homeNav;
    }else if (indexPath.row == 6) {
        UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *homeNav = [homeStoryBoard instantiateViewControllerWithIdentifier:@"homeNav"];
        self.slidingViewController.topViewController = homeNav;
    }else if (indexPath.row == 7) {
        UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *homeNav = [homeStoryBoard instantiateViewControllerWithIdentifier:@"homeNav"];
        self.slidingViewController.topViewController = homeNav;
    }else if (indexPath.row == 8) {
        UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *homeNav = [homeStoryBoard instantiateViewControllerWithIdentifier:@"homeNav"];
        self.slidingViewController.topViewController = homeNav;
    }else if (indexPath.row == 9) {
        UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *homeNav = [homeStoryBoard instantiateViewControllerWithIdentifier:@"homeNav"];
        self.slidingViewController.topViewController = homeNav;
    }else if (indexPath.row == 10) {
        UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *homeNav = [homeStoryBoard instantiateViewControllerWithIdentifier:@"homeNav"];
        self.slidingViewController.topViewController = homeNav;
    }else if (indexPath.row == 11) {
        UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *homeNav = [homeStoryBoard instantiateViewControllerWithIdentifier:@"homeNav"];
        self.slidingViewController.topViewController = homeNav;
    }else if (indexPath.row == 12) {
        UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *homeNav = [homeStoryBoard instantiateViewControllerWithIdentifier:@"homeNav"];
        self.slidingViewController.topViewController = homeNav;
    }else {
        
    }
    [self.slidingViewController resetTopViewAnimated:YES];
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
        cell1.logoView.image = [UIImage imageNamed:@"menu_homepage_pressed_btn"];
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




@end
