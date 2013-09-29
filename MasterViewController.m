//
//  MasterViewController.m
//  FavoriteLocals
//
//  Created by Gina Mullins on 9/10/13.
//  Copyright (c) 2013 Little Peculiar. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "BouncePresentAnimationController.h"
#import "ShrinkDismissAnimationController.h"
#import "FlipAnimationController.h"
#import "SwipeInteractionController.h"
#import "NormalTableCell.h"
#import "CollectionTableCell.h"
#import "LocationInfo.h"

#define kTypeTable  11
#define kTypeColl   12

NSString * const REUSE_NORMAL_TABLE_CELLID = @"NormalTableCell";
NSString * const REUSE_COLLECTION_TABLE_CELLID = @"CollectionTableCell";



@interface MasterViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>


@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *collectionData;
@property (nonatomic, strong) NSArray *tableData;

- (void)registerNibs;
- (void)loadDataFromParse;

@end

@implementation MasterViewController
{
    BouncePresentAnimationController *_bounceAnimationController;
    ShrinkDismissAnimationController *_shrinkDismissAnimationController;
    FlipAnimationController *_flipAnimationController;
    SwipeInteractionController *_swipeInteractionController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"Surf's Up", @"Surf's Up");
        
        // The className to query on
        self.parseClassName = @"Locals";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
        
        // create the transition
        _bounceAnimationController = [BouncePresentAnimationController new];
        _shrinkDismissAnimationController = [ShrinkDismissAnimationController new];
        _flipAnimationController = [FlipAnimationController new];
        _swipeInteractionController = [SwipeInteractionController new];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self registerNibs];
    
    // Add observer that will allow the nested collection cell to trigger the view controller select row at index path
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didSelectItemFromCollectionView:)
                                                 name:@"didSelectItemFromCollectionView" object:nil];
    
    [self loadDataFromParse];
    self.navigationController.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)registerNibs
{
    UINib *tableCellNib = [UINib nibWithNibName:REUSE_NORMAL_TABLE_CELLID bundle:[NSBundle bundleForClass:[NormalTableCell class]]];
    [self.tableView registerNib:tableCellNib forCellReuseIdentifier:REUSE_NORMAL_TABLE_CELLID];
    UINib *collectionCellNib = [UINib nibWithNibName:REUSE_COLLECTION_TABLE_CELLID bundle:[NSBundle bundleForClass:[CollectionTableCell class]]];
    [self.tableView registerNib:collectionCellNib forCellReuseIdentifier:REUSE_COLLECTION_TABLE_CELLID];
}

- (void)loadDataFromParse
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            // load the data arrays
            NSMutableArray *topTen = [[NSMutableArray alloc] initWithCapacity:10];
            NSMutableArray *others = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < [objects count]; i++)
            {
                PFObject *object = [objects objectAtIndex:i];
                LocationInfo *info = [[LocationInfo alloc]
                                      initLocationWithInfo:(NSString*)[object objectForKey:@"name"]
                                      city:(NSString*)[object objectForKey:@"city"]
                                      country:(NSString*)[object objectForKey:@"country"]
                                      imageFile:(PFFile*)[object objectForKey:@"imageFile"]
                                      desc:(NSString*)[object objectForKey:@"desc"]
                                      rank:(NSInteger)[[object objectForKey:@"rank"] integerValue] ];
                
                if (info.rank <= 10)
                {
                    [topTen addObject:info];
                }
                else
                {
                    [others addObject:info];
                }
            }
            
            // sort the arrays
            // sort playlist by current order nbr
            NSString *sortString = @"rank";
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortString ascending:YES];
            self.collectionData = [topTen sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
            self.tableData = [others sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
            
        } else
        {
            NSLog(@"Error:%@", [error description]);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"didSelectItemFromCollectionView" object:nil];
}


#pragma mark - Table View



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 1;
    else
    {
        return [self.tableData count];
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        CollectionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSE_COLLECTION_TABLE_CELLID];
        
        [cell loadCollectionData:self.collectionData];
        
        return cell;
    }
    else
    {
        NormalTableCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSE_NORMAL_TABLE_CELLID];
        
        LocationInfo *info = [self.tableData objectAtIndex:indexPath.row];
        
        // Configure the cell
        PFFile *thumbnail = info.imageFile;
        PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
        thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
        thumbnailImageView.file = thumbnail;
        [thumbnailImageView loadInBackground];
        
        cell.cellTitle.text = info.name;
        
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.tableDetailViewController)
    {
        self.tableDetailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    self.tableDetailViewController.detailInfo = [self.tableData objectAtIndex:indexPath.row];
    self.tableDetailViewController.detailType = kTypeTable;
    [self.navigationController pushViewController:self.tableDetailViewController animated:YES];
}

#pragma mark UITableViewDelegate methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *header = @"";
    if (section == 0)
    {
        header = @"Top 10";
    }
    else
    {
        header = @"Surf Locations";
    }
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 180.0;
    }
    else
    {
        return 70.0;
    }
}

#pragma mark - NSNotification to select table cell

- (void) didSelectItemFromCollectionView:(NSNotification *)notification
{
   LocationInfo *collInfo = [notification object];
    if (collInfo)
    {
        if (!self.collectionDetailViewController)
        {
            self.collectionDetailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
            self.collectionDetailViewController.transitioningDelegate = self;
        }
        self.collectionDetailViewController.detailInfo = collInfo;
        self.collectionDetailViewController.detailType = kTypeColl;
        [self.navigationController presentViewController:self.collectionDetailViewController animated:YES completion:nil];
    }
}

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed
{
    return _shrinkDismissAnimationController;
}

#pragma mark UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController: (UIViewController *)source
{
    return _bounceAnimationController;
}

- (id<UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush)
    {
        [_swipeInteractionController wireToViewController:toVC];
    }
    
    _flipAnimationController.reverse = operation == UINavigationControllerOperationPop;
    return _flipAnimationController;
}

- (id <UIViewControllerInteractiveTransitioning>) navigationController:(UINavigationController *)navigationController
                           interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController
{
    return _swipeInteractionController.interactionInProgress ? _swipeInteractionController : nil;
}

@end
