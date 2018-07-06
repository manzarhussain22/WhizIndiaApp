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
#import "BEMSimpleLineGraphView.h"

#define mqttTopic @"/test/light1"

@interface HomeSlaveViewController ()<ContentTableViewCellDelegate,MQTTHelperDelegate,BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>
{
    NSDictionary *controllerDescriptor;
    NSArray *deviceIDArr;
    NSMutableArray *controllerNameArr;
    BOOL isSwitchOn;
    MQTTHelper *mqttHelper;
    NSString *contentDeviceID;
    NSMutableArray *graphPoints;
    NSMutableArray *arrayOfDates;
}
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *matrixView;

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
        if ([_controllerID isEqualToString:@"Matrix"]) {
            self.controllerTitle.text = [_controllerID uppercaseString];
            _matrixView.hidden = NO;
            _contentTableView.hidden = YES;
            [self setupGraphData];
            [self setupMatrix];
        }
        else
        {
            self.controllerTitle.text = [[[[SharedClass sharedInstance] userObj].controllers objectForKey:_controllerID] uppercaseString];
            _matrixView.hidden = YES;
            _contentTableView.hidden = NO;
        }
    
    }
   
}

-(void)setupGraphData
{
    NSDate *baseDate = [NSDate date];
    BOOL showNullValue = true;
    graphPoints = [NSMutableArray new];
    for (int i = 0; i<9; i++) {
        [graphPoints addObject:@([self getRandomFloat])];
        if (i == 0) {
            [arrayOfDates addObject:baseDate]; // Dates for the X-Axis of the graph
        } else if (showNullValue && i == 4) {
            [arrayOfDates addObject:[self dateForGraphAfterDate:arrayOfDates[i-1]]]; // Dates for the X-Axis of the graph
            graphPoints[i] = @(BEMNullGraphValue);
        } else {
            [arrayOfDates addObject:[self dateForGraphAfterDate:arrayOfDates[i-1]]]; // Dates for the X-Axis of the graph
        }
    }
}

-(void)setupMatrix
{
    _matrixView.dataSource = self;
    _matrixView.delegate = self;
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 0.0
    };
    // Apply the gradient to the bottom portion of the graph
    self.matrixView.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    
    // Enable and disable various graph properties and axis displays
    self.matrixView.enableTouchReport = YES;
    self.matrixView.enablePopUpReport = YES;
    self.matrixView.enableYAxisLabel = YES;
    self.matrixView.autoScaleYAxis = YES;
    self.matrixView.alwaysDisplayDots = NO;
    self.matrixView.enableReferenceXAxisLines = YES;
    self.matrixView.enableReferenceYAxisLines = YES;
    self.matrixView.enableReferenceAxisFrame = YES;
    
    // Draw an average line
    self.matrixView.averageLine.enableAverageLine = YES;
    self.matrixView.averageLine.alpha = 0.6;
    self.matrixView.averageLine.color = [UIColor darkGrayColor];
    self.matrixView.averageLine.width = 2.5;
    self.matrixView.averageLine.dashPattern = @[@(2),@(2)];
    
    // Set the graph's animation style to draw, fade, or none
    self.matrixView.animationGraphStyle = BEMLineAnimationDraw;
    
    // Dash the y reference lines
    self.matrixView.lineDashPatternForReferenceYAxisLines = @[@(2),@(2)];
    
    // Show the y axis values with this format string
    self.matrixView.formatStringForValues = @"%.1f";
    self.matrixView.enableBezierCurve = YES;
   UIColor *color = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    self.matrixView.colorTop = color;
    self.matrixView.colorBottom = color;
    self.matrixView.backgroundColor = color;
    self.matrixView.animationGraphStyle = BEMLineAnimationFade;

}
- (NSDate *)dateForGraphAfterDate:(NSDate *)date {
    NSTimeInterval secondsInTwentyFourHours = 24 * 60 * 60;
    NSDate *newDate = [date dateByAddingTimeInterval:secondsInTwentyFourHours];
    return newDate;
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

- (float)getRandomFloat {
    float i1 = (float)(arc4random() % 1000000) / 100 ;
    return i1;
}

#pragma mark - Matrix DataSource

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return graphPoints.count;
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    return [[graphPoints objectAtIndex:index] doubleValue];
}

#pragma mark - Matrix Datadelegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 2;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    
    NSString *label = [self labelForDateAtIndex:index];
    return [label stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
}

- (NSString *)labelForDateAtIndex:(NSInteger)index {
    NSDate *date = arrayOfDates[index];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"MM/dd";
    NSString *label = [df stringFromDate:date];
    return label;
}

@end
