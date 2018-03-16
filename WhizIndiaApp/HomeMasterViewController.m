//
//  HomeMasterViewController.m
//  AUTOIApp
//
//  Created by Manzar_Hussain on 11/02/18.
//  Copyright © 2018 AUTOI. All rights reserved.
//

#import "HomeMasterViewController.h"
#import "MenuViewTableViewCell.h"
#import "MenuViewController.h"
#import "ShowSideMenuAnimationView.h"
#import "SideMenuShowInteraction.h"
#import "HideSideMenuAnimationView.h"
#import "SideMenuInteraction.h"
#import "HomeSlaveViewController.h"
#import "AddEditCOntrollerViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DataManager.h"
#import "LoginRequestModal.h"
#import "LoginResponseModal.h"



@interface HomeMasterViewController ()<UIViewControllerTransitioningDelegate, MenuViewDelegate,AddEditCOntrollerDelegate,DataManagerDelegate>
{
    BOOL isMenu;
    BOOL isEdit;
    MenuViewController *menuView;
    HomeSlaveViewController *homeSlaveView;
    ShowSideMenuAnimationView* showSideMenuAnimationViewController;
    HideSideMenuAnimationView* hideSideMenuAnimationViewController;
    
    SideMenuInteraction* sideMenuHideInteractionController;
    SideMenuShowInteraction* sideMenuShowInteractionController;
    AddEditCOntrollerViewController *addEditView;
    UIVisualEffectView *blurEffectView;
    NSString *homeSlaveViewControllerId;
    
}


@property (weak, nonatomic) IBOutlet UIButton *addControllersButtonTapped;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *noControllersLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuButtonTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuButtonLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *settingButtonTrailingConstraint;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editButtonLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addButtonTrailingConstraint;



@end

@implementation HomeMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isMenu = NO;
    
    menuView = [[MenuViewController alloc] init];
    
    showSideMenuAnimationViewController = [[ShowSideMenuAnimationView alloc] init];
    hideSideMenuAnimationViewController = [[HideSideMenuAnimationView alloc] init];
    sideMenuHideInteractionController = [[SideMenuInteraction alloc] init];
    sideMenuShowInteractionController = [[SideMenuShowInteraction alloc] init];
    
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.headerView addGestureRecognizer:tapped];
    
    [self setupUIConstraints];
    [self checkAndSetUpContentView];
    [self setupMenuView];
    [self setUpAddEditView];
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.view.backgroundColor = [UIColor clearColor];
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        //always fill the view
        blurEffectView.frame = self.view.bounds;
        blurEffectView.alpha = 0.0;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
       // [self.view addSubview:blurEffectView];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
   
}

-(void)setUpAddEditView
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AddEditView" bundle:nil];
    addEditView = (AddEditCOntrollerViewController *)[sb instantiateViewControllerWithIdentifier:@"addEditView"];
    addEditView.controllerID = homeSlaveViewControllerId;
    addEditView.view.frame = self.view.frame;
    addEditView.addControllerView.layer.cornerRadius = (10./568.) * kScreenHeight;
    addEditView.editControllerView.layer.cornerRadius = (10./568.) * kScreenHeight;
    [addEditView.cancelButton addTarget:self action:@selector(addEditCancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [addEditView.editCancelButton addTarget:self action:@selector(addEditCancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    addEditView.addControllerView.hidden = YES;
    addEditView.editControllerView.hidden = YES;
    addEditView.delegate = self;
}

-(void)checkAndSetUpContentView
{
    if (homeSlaveViewControllerId == nil || [homeSlaveViewControllerId isEqualToString:@""]) {
        homeSlaveViewControllerId = [[[[[SharedClass  sharedInstance] userObj].controllers allKeys] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"" ascending:YES]]] firstObject];
    }
    
    if ([[[SharedClass sharedInstance] userObj].controllers count]>0) {
        _editButton.hidden = NO;
        [self setUpContentViewFor];
    
    }
    else
    {
        _noControllersLabel.hidden = NO;
        _editButton.hidden = YES;
    }
}

-(void)viewTapped:(UITapGestureRecognizer *)gesture
{
    [self hideMenu:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)setupUIConstraints
{
    _menuButtonTopConstraint.constant = (28./568.) * kScreenHeight;
    _menuButtonLeadingConstraint.constant = _settingButtonTrailingConstraint.constant =(20./320.) * kScreenWidth;
    _contentViewBottomConstraint.constant =  (40./568.) * kScreenHeight;
}

- (IBAction)menuButtonTapped:(id)sender {
    menuView.controllerID = homeSlaveViewControllerId;
    [self hideMenu:NO];
    
}

-(void)setUpContentViewFor
{
    self.noControllersLabel.hidden = YES;
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"HomeSlave" bundle:nil];
    homeSlaveView = (HomeSlaveViewController *)[st instantiateViewControllerWithIdentifier:@"homeSlave"];
    homeSlaveView.controllerID = homeSlaveViewControllerId;
    CGRect frame = self.contentView.frame;
    frame.origin.y = 0.0;
    [self.contentView addSubview:homeSlaveView.view];
    homeSlaveView.view.frame = frame;
}

-(void)setupMenuView{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MenuView" bundle:nil];
    menuView = (MenuViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"sideMenuView"];
    menuView.controllerID = homeSlaveViewControllerId;
    menuView.delegate = self;
    menuView.transitioningDelegate = self;
    
    
}

-(void)hideMenu:(BOOL)yesNo{
    
    
    if (!yesNo) {
        [self presentViewController:menuView animated:YES completion:nil];
    }
    
    isMenu = !yesNo;
    
}

#pragma mark - User Actions

- (IBAction)addButtonTapped:(id)sender
{
    isEdit = NO;
    addEditView.addControllerView.hidden = NO;
    addEditView.editControllerView.hidden = YES;
    [self.view addSubview:blurEffectView];
    [self.view addSubview:addEditView.view];
    
    addEditView.view.alpha = 1.;
    blurEffectView.alpha = 0.0;
    [UIView animateWithDuration:0.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         blurEffectView.alpha = .75;
         
     }
                     completion:nil];
}

- (IBAction)editButtonTapped:(id)sender {
    {
        isEdit = YES;
        [self.view addSubview:blurEffectView];
        [self.view addSubview:addEditView.view];
        addEditView.addControllerView.hidden = YES;
        addEditView.editControllerView.hidden = NO;
        addEditView.controllerID = homeSlaveView.controllerID;
        addEditView.view.alpha = 1.;
        blurEffectView.alpha = 0.0;
        [UIView animateWithDuration:0.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
         {
             blurEffectView.alpha = .75;
             
         }
                         completion:nil];
    }
}

#pragma AddEdit View User Actions
-(void)addEditCancelButtonTapped
{
    
    [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^
     {
         blurEffectView.alpha = 0.0;
         addEditView.view.alpha = 0.0;
     }
                     completion:^(BOOL finished){
                         if (finished) {
                             [addEditView.view removeFromSuperview];
                             [blurEffectView removeFromSuperview];
                         }
                     }];
}

#pragma mark - MenuView Delegate
-(void)dismissMenuView
{
    [self hideMenu:YES];
    
}
-(void)showDetailedControllerFor:(NSString *)controllerID
{
    if ([controllerID isEqualToString:@"Logout"]) {
        [self dismissViewControllerAnimated:NO completion:nil];
        return;
    }
    homeSlaveViewControllerId = controllerID;
    [self setUpContentViewFor];
    if (![menuSection2Array containsObject:controllerID]) {
       [self setUpAddEditView];
        _editButton.hidden = NO;
        _addButton.hidden = NO;
    }
    else
    {
        _editButton.hidden = YES;
        _addButton.hidden = YES;
    }
}

#pragma mark - Transition Delegates

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return showSideMenuAnimationViewController;
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return hideSideMenuAnimationViewController;
    
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    
    return sideMenuShowInteractionController.interactionInProgress ? sideMenuShowInteractionController : nil;
    
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    
    return sideMenuHideInteractionController.interactionInProgress ? sideMenuHideInteractionController : nil;
    
}

#pragma mark - AddEditController Delegate

-(void)addEditControllerSuccess
{
    [self refreshUserData];
}

-(void)addEditControllerFailure
{
    [self addEditCancelButtonTapped];
}

#pragma mark - Refresh UserData

-(void)refreshUserData
{
    DataManager *manager = [[DataManager alloc] init];
    manager.delegate = self;
    [manager startLoginServiceWithParams:[self prepareDictionaryForLogin]];
}
#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryForLogin {
    
    LoginRequestModal* loginObj = [[LoginRequestModal alloc] init];
    loginObj.email = [[SharedClass sharedInstance] username];
    loginObj.password = [[SharedClass sharedInstance] password];
    return [loginObj createRequestDictionary];
    
}

#pragma mark - DataManager Delegate
-(void)didFinishServiceWithSuccess:(LoginResponseModal *)responseData
{
    [[SharedClass sharedInstance] setUserObj:responseData];
    if ([[[SharedClass sharedInstance] userObj].homeId isEqualToString:@"1"]) {
        [self checkAndSetUpContentView];
        [self setupMenuView];
    }
    else
    {
        NSLog(@"Error in login %@",responseData.homeId);
    }
    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",isEdit?@"Updated Successfully":@"Added Successfully"]];
    [self addEditCancelButtonTapped];
}

-(void)didFinishServiceWithFailure:(NSString *)errorMsg
{
    [SVProgressHUD dismiss];
    [self addEditCancelButtonTapped];
}


@end
