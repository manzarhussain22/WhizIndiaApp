//
//  MenuViewController.m
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 13/02/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuViewTableViewCell.h"

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
    controllerKey = [[[[SharedClass sharedInstance] userObj].controllers allKeys] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"" ascending:YES]]];
    for (NSString *str in controllerKey) {
        [_menuSectionOneItems addObject:[[[SharedClass sharedInstance] userObj].controllers objectForKey:str]];
    }
    _menuSectionTwoItems = [NSArray arrayWithObjects:@"About Us",@"Contact Us",@"Logout", nil];
    if (_menuSectionOneItems.count>0) {
        selectedRowIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    else
    {
        selectedRowIndex = [NSIndexPath indexPathForRow:0 inSection:1];
    }
    _menuTableViewLeadingConstraint.constant = (10./320.) * kScreenWidth;
    _menuTableViewTrailingConstraint.constant = _menuTableViewLeadingConstraint.constant;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
            return _menuSectionOneItems.count;
            break;
        case 1:
            return _menuSectionTwoItems.count;
            break;
        default:
            return 0;
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuViewTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:MenuCellIdentifier forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            cell.titleLabel.text = [_menuSectionOneItems objectAtIndex:indexPath.row];
            break;
        case 1:
            cell.titleLabel.text = [_menuSectionTwoItems objectAtIndex:indexPath.row];
            break;
        default:
            return nil;
            break;
    }
    if (indexPath == selectedRowIndex) {
        cell.backgroundColor = [UIColor colorWithRed:241./255. green:64./255. blue:35./255. alpha:1.0];
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
                [self.delegate showDetailedControllerFor:[controllerKey objectAtIndex:indexPath.row]];
            }
            break;
        case 1:
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



@end
