//
//  HomeSlaveViewController.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 08/03/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "HomeSlaveViewController.h"
#import "ContentTableViewCell.h"
#import "MQTTHelper.h"

#define mqttTopic @"/test/light1"

@interface HomeSlaveViewController ()<ContentTableViewCellDelegate,MQTTHelperDelegate>
{
    NSDictionary *controllerDescriptor;
    NSArray *deviceIDArr;
    NSMutableArray *controllerNameArr;
    BOOL isSwitchOn;
    MQTTHelper *mqttHelper;
    NSString *contentDeviceID;
}
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

@end

@implementation HomeSlaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _buttonStatus = [[NSMutableDictionary alloc] init];
    controllerDescriptor = [[[SharedClass sharedInstance] userObj].userDict objectForKey:_controllerID];
    controllerNameArr = [[NSMutableArray alloc] init];
    deviceIDArr = [[controllerDescriptor allKeys] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"" ascending:YES]]];
    for (NSString *key in deviceIDArr) {
        [controllerNameArr addObject:[controllerDescriptor objectForKey:key]];
        [_buttonStatus setObject:[NSNumber numberWithBool:NO] forKey:key];
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
    contentCell.deviceID = [deviceIDArr objectAtIndex:indexPath.section];
    contentCell.detailDescription.text = [controllerNameArr objectAtIndex:indexPath.section];
    contentCell.indexPath = indexPath;
    contentCell.delegate = self;
    [contentCell.controllerSwitch setOn:((NSNumber *)[_buttonStatus objectForKey:[deviceIDArr objectAtIndex:indexPath.section]]).boolValue animated:YES];
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

#pragma mark - ContentCellDelegate

-(void)switchTapped:(BOOL)isOn forDeviceID:(NSString *)deviceID
{
    contentDeviceID = deviceID;
    [_buttonStatus setObject:[NSNumber numberWithBool:isOn] forKey:deviceID];
    isSwitchOn = isOn;
    mqttHelper = [[MQTTHelper alloc] init];
    mqttHelper.delegate = self;
    [mqttHelper initiateConnection];
}

-(void)reloadCellOnFailure
{
    [_buttonStatus setObject:[NSNumber numberWithBool:!isSwitchOn] forKey:contentDeviceID];
    [_contentTableView reloadData];
}

-(void)reloadCellOnSuccess
{
    [_buttonStatus setObject:[NSNumber numberWithBool:isSwitchOn] forKey:contentDeviceID];
    [_contentTableView reloadData];
}

#pragma mark - MQTTHelperDelegate
-(void)connectedSuccessfully
{
    NSUInteger index = ((NSNumber *)[_buttonStatus objectForKey:contentDeviceID]).unsignedIntegerValue;
    NSData *data = [NSData dataWithBytes:&index length:sizeof(index)];
    [mqttHelper subscribeToTopic:mqttTopic completionhandler:^(BOOL sucess){
        if (sucess) {
            [mqttHelper publishMessage:data];
        }
        else
        {
            [self reloadCellOnFailure];
        }
    }];
}

-(void)connectionError:(NSError *)error
{
    [self reloadCellOnFailure];
}

-(void)connectionRefused:(NSError *)error
{
    [self reloadCellOnFailure];;
}

-(void)protocolError:(NSError *)error
{
    [self reloadCellOnFailure];
}

-(void)messageDeliveredForTopic:(NSString *)topic
{
    if ([topic isEqualToString:mqttTopic]) {
        [self reloadCellOnSuccess];
    }
}

@end
