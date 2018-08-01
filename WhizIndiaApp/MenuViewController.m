    //
//  MenuViewController.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 13/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuViewTableViewCell.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import "iSwitches.h"
#import "UserProfile.h"

@interface MenuViewController ()
{
    NSArray *controllerKey;
    NSIndexPath *selectedRowIndex;
}
@property (weak, nonatomic) IBOutlet UIView *topTapView;
@property (weak, nonatomic) IBOutlet UIView *rightTapview;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuTableViewTrailingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuTableViewLeadingConstraint;
@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *profilePicImageViewLeadingConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userNameLabelLeadingConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *profileEditButtonLeadingConstraints;

@property (strong, nonatomic) NSMutableArray *menuSectionOneItems;
@property (strong, nonatomic) NSArray *menuSectionTwoItems;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _menuSectionOneItems = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *topTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMenu:)];
    UITapGestureRecognizer *rightTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMenu:)];
    [self.topTapView addGestureRecognizer:topTapGesture];
    [self.rightTapview addGestureRecognizer:rightTapGesture];
//    controllerKey = [[[[SharedClass sharedInstance] userObj].controllers allKeys] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"" ascending:YES]]];
//    for (NSString *str in [[[RealmHelper sharedInstance] fetchiSwitches] valueForKey:iSwitchNameKey]) {
//        [_menuSectionOneItems addObject:str];
//    }
    _menuSectionTwoItems = menuSection2Array;
    [self updateUXConstraints];
    [self updateProfileCell];
}
-(void)updateProfileCell
{
    self.profilePicImageView.layer.cornerRadius = ((self.profilePicImageView.frame.size.width/320.) * kScreenWidth) / 2;
    self.profilePicImageView.clipsToBounds = YES;
    self.profilePicImageView.layer.borderWidth = 2.0f;
    self.profilePicImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    if ([GIDSignIn sharedInstance].currentUser.profile.hasImage) {
        NSUInteger dimension = round(self.profilePicImageView.frame.size.width * [[UIScreen mainScreen] scale]);
        NSURL *imageURL = [[GIDSignIn sharedInstance].currentUser.profile imageURLWithDimension:dimension];
        
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL: imageURL];
            dispatch_async(dispatch_get_main_queue(), ^{
                if ( data == nil )
                {
                    self.profilePicImageView.image = [UIImage imageNamed:@"Avatar"];
                    
                }
                else
                {
                    self.profilePicImageView.image = [UIImage imageWithData: data];
                }
            });
        });
    }
    else
    {
        self.profilePicImageView.image = [UIImage imageNamed:@"Avatar"];
    }
    NSString *userName = [[[UserProfile allObjects] objectAtIndex:0] valueForKey:Profile_User_Name];
    self.userNameLabel.text = userName;
}
-(void)updateUXConstraints {
    _menuTableViewLeadingConstraint.constant = (0./320.) * kScreenWidth;
    _menuTableViewTrailingConstraint.constant = _menuTableViewLeadingConstraint.constant;
    _profilePicImageViewLeadingConstraints.constant = (20./320.) * kScreenWidth;
    _userNameLabelLeadingConstraints.constant = (15./320.) * kScreenWidth;
    _profileEditButtonLeadingConstraints.constant = (12./320.) * kScreenWidth;
    
    [_userNameLabel setFont:[UIFont fontWithName:@"System-Bold" size:(15./568) * kScreenHeight]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![_menuSectionTwoItems containsObject:_controllerID]) {
        int count = -1;
        if ([_controllerID isEqualToString:@"Matrix"]) {
            count++;
        }
        for (NSString *str in controllerKey) {
            count++;
            if ([str isEqualToString:_controllerID]) {
                break;
            }
        }
        selectedRowIndex = [NSIndexPath indexPathForRow:count inSection:1];
    }
    else
    {
        int count = -1;
        for (NSString *str in _menuSectionTwoItems) {
            count++;
            if ([str isEqualToString:_controllerID]) {
                break;
            }
        }
        selectedRowIndex = [NSIndexPath indexPathForRow:count inSection:2];
    }
    [self.menuTableView reloadData];
}

-(void)dismissMenu:(UITapGestureRecognizer*)recognizer
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate dismissMenuView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return [[[RealmHelper sharedInstance] fetchiSwitches] count];
            break;
        case 2:
            return _menuSectionTwoItems.count;
            break;
        default:
            return 0;
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuViewTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:MenuCellIdentifier forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            cell.titleLabel.text = @"Add iSwitch";
            break;
        case 1:
        {
            iSwitches *iSwitch = [[[RealmHelper sharedInstance] fetchiSwitches] objectAtIndex:indexPath.row];
            cell.titleLabel.text = iSwitch.iSwitchName;
            break;
        }
        case 2:
            cell.titleLabel.text = [_menuSectionTwoItems objectAtIndex:indexPath.row];
            break;
        default:
            return nil;
            break;
    }
    if (indexPath == selectedRowIndex) {
        cell.backgroundColor = [UIColor clearColor];
    }
    else
    {
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

#pragma mark - TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissMenu:nil];
    switch (indexPath.section) {
        case 0:
            if ([self.delegate respondsToSelector:@selector(showDetailedControllerFor:)]) {
                [self.delegate showDetailedControllerFor:@"Add iSwitch"];
            }
            break;
        case 1:
            if ([self.delegate respondsToSelector:@selector(showDetailedControllerFor:)]) {
                iSwitches *iSwitch = [[[RealmHelper sharedInstance] fetchiSwitches] objectAtIndex:indexPath.row];
                [self.delegate showDetailedControllerFor:iSwitch.iSwitchId];
            }
            break;
        case 2:
            if ([self.delegate respondsToSelector:@selector(showDetailedControllerFor:)]) {
                [self.delegate showDetailedControllerFor:[_menuSectionTwoItems objectAtIndex:indexPath.row]];
            }
            break;
        default:
            break;
    }
    selectedRowIndex = indexPath;
    [self.menuTableView reloadData];

}
- (IBAction)editProfileButtonTapped:(id)sender {
}



@end
