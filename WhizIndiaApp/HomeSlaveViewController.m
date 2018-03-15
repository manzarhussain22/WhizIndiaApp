//
//  HomeSlaveViewController.m
//  WhizIndiaApp
//
//  Created by Manzar_Hussain on 08/03/18.
//  Copyright © 2018 WhizIndia. All rights reserved.
//

#import "HomeSlaveViewController.h"
#import "ContentTableViewCell.h"

@interface HomeSlaveViewController ()
{
    NSDictionary *controllerDescriptor;
    NSMutableArray *controllerNameArr;
}
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

@end

@implementation HomeSlaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    controllerDescriptor = [[[SharedClass sharedInstance] userObj].userDict objectForKey:_controllerID];
    controllerNameArr = [[NSMutableArray alloc] init];
    for (NSString *key in [[controllerDescriptor allKeys] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"" ascending:YES]]]) {
        [controllerNameArr addObject:[controllerDescriptor objectForKey:key]];
    }
    
    if ([menuSection2Array containsObject:_controllerID]) {
        self.controllerTitle.text = [_controllerID uppercaseString];
    }
    else
    {
    self.controllerTitle.text = [[[[SharedClass sharedInstance] userObj].controllers objectForKey:_controllerID] uppercaseString];
    }
}

#pragma mark - TableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return controllerDescriptor.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentTableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:ContentCellIdentifier forIndexPath:indexPath];
    contentCell.detailDescription.text = [controllerNameArr objectAtIndex:indexPath.section];
    return contentCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (5./568.) * kScreenHeight; // you can have your own choice, of course
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}


@end
