//
//  PictureListViewController.m
//  Mega
//
//  Created by Sergey on 2/1/15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "PictureListViewController.h"
#import "Person.h"
#import "PictureCell.h"
@interface PictureListViewController ()

@end

@implementation PictureListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"People";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tabSegmentControl.items = @[@"People", @"Friends", @"Requests"];
    
    Person *person1 = [[Person alloc] initWithName:@"Linda Cristofssen" profilePicUrl:@"people-profile-1" backgroundPicUrl:@"people-pic-1" sex:@"female" years:@"25歲" location:@"London, UK" commentCount:@"3" restaurant:@"西提牛排敦南店"];
    
    
    Person* person2 = [[Person alloc] initWithName:@"Christopher Bale" profilePicUrl:@"people-profile-2" backgroundPicUrl: @"people-pic-2" sex:@"male" years:@"25歲" location:@"Sacramento, CA" commentCount:@"20" restaurant:@"西提牛排敦南店"];
    
    Person* person3 = [[Person alloc] initWithName:@"Angelina Jolie" profilePicUrl:@"people-profile-3" backgroundPicUrl: @"people-pic-3" sex:@"male" years:@"25歲" location:@"Los Angeles, CA" commentCount:@"21" restaurant:@"西提牛排敦南店"];
    
    Person* person4 = [[Person alloc] initWithName:@"Tom Cruise" profilePicUrl:@"people-profile-4" backgroundPicUrl:@"people-pic-4" sex:@"male" years:@"25歲" location:@"Seattle, WA" commentCount:@"46" restaurant:@"西提牛排敦南店"];
    
    Person* person5 = [[Person alloc] initWithName:@"Adam Sandler" profilePicUrl:@"people-profile-5" backgroundPicUrl: @"people-pic-5" sex:@"male" years:@"25歲" location:@"New York, NY" commentCount:@"31" restaurant:@"西提牛排敦南店"];
    
    people = @[person1, person2, person3, person4, person5];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return people.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PictureCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PictureCell"];

    Person* person = people[indexPath.row];
    
    cell.nameLabel.text = person.name;
    cell.profileImageView.image = [UIImage imageNamed:person.profilePicUrl];
    cell.bgImageView.image = [UIImage imageNamed:person.backgroundPicUrl];
    cell.locationLabel.text = person.location;
    cell.commentsLabel.text = @"\(person.commentCount) Comments";
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*尚未登入的人，就要跳出登入及註冊的頁面*/
    if (![PFUser currentUser]) {
        [self performSegueWithIdentifier:@"signIn" sender:nil];
    }else{
        NSLog(@"我已經登陸了");
    }
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
