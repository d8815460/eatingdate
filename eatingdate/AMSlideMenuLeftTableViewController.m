//
//  AMSlideMenuLeftTableViewController.m
//  AMSlideMenu
//
// The MIT License (MIT)
//
// Created by : arturdev
// Copyright (c) 2014 SocialObjects Software. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE

#import "AMSlideMenuLeftTableViewController.h"

#import "AMSlideMenuMainViewController.h"

#import "AMSlideMenuContentSegue.h"

#import "MenuWithIconCell.h"

@interface AMSlideMenuLeftTableViewController ()

@end

@implementation AMSlideMenuLeftTableViewController

/*----------------------------------------------------*/
#pragma mark - Lifecycle -
/*----------------------------------------------------*/

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)openContentNavigationController:(UINavigationController *)nvc
{
#ifdef AMSlideMenuWithoutStoryboards
    AMSlideMenuContentSegue *contentSegue = [[AMSlideMenuContentSegue alloc] initWithIdentifier:@"contentSegue" source:self destination:nvc];
    [contentSegue perform];
#else
    NSLog(@"This methos is only for NON storyboard use! You must define AMSlideMenuWithoutStoryboards \n (e.g. #define AMSlideMenuWithoutStoryboards)");
#endif
}


/*----------------------------------------------------*/
#pragma mark - TableView Delegate -
/*----------------------------------------------------*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    if (indexPath.row == 1) {
        //首頁
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"menu_homepage_pressed_btn"]];
    }else if (indexPath.row == 2) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_publish__normal"]];
    }else if (indexPath.row == 3) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_schedule_normal"]];
    }else if (indexPath.row == 4) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_mail_normal"]];
    }else if (indexPath.row == 5) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_heart_normal"]];
    }else if (indexPath.row == 6) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_history_normal"]];
    }else if (indexPath.row == 7) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_gvip_normal"]];
    }else if (indexPath.row == 8) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_tvip_normal"]];
    }else if (indexPath.row == 9) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_point_normal"]];
    }else if (indexPath.row == 10) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_setting_normal"]];
    }
    
    
    
    if ([self.mainVC respondsToSelector:@selector(navigationControllerForIndexPathInLeftMenu:)]) {
        UINavigationController *navController = [self.mainVC navigationControllerForIndexPathInLeftMenu:indexPath];
        AMSlideMenuContentSegue *segue = [[AMSlideMenuContentSegue alloc] initWithIdentifier:@"ContentSugue" source:self destination:navController];
        [segue perform];
    } else {
        NSString *segueIdentifier = [self.mainVC segueIdentifierForIndexPathInLeftMenu:indexPath];
        if (segueIdentifier && segueIdentifier.length > 0)
        {
            [self performSegueWithIdentifier:segueIdentifier sender:self];
        }
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    
    if (indexPath.row == 1) {
        //首頁
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"menu_homepage_pressed_btn"]];
    }else if (indexPath.row == 2) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_publish__pressed"]];
    }else if (indexPath.row == 3) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_schedule_pressed"]];
    }else if (indexPath.row == 4) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_mail_pressed"]];
    }else if (indexPath.row == 5) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_heart_pressed"]];
    }else if (indexPath.row == 6) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_history_pressed"]];
    }else if (indexPath.row == 7) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_gvip_pressed"]];
    }else if (indexPath.row == 8) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_tvip_pressed"]];
    }else if (indexPath.row == 9) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_point_pressed"]];
    }else if (indexPath.row == 10) {
        [[(MenuWithIconCell *)[tableView cellForRowAtIndexPath:indexPath] logoView] setImage:[UIImage imageNamed:@"btn_menu_setting_pressed"]];
    }
}



@end
