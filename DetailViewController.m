//
//  DetailViewController.m
//  FavoriteLocals
//
//  Created by Gina Mullins on 9/10/13.
//  Copyright (c) 2013 Little Peculiar. All rights reserved.
//

#import "DetailViewController.h"
#import "LocationInfo.h"
#import <Parse/Parse.h>

#define kTypeTable  11
#define kTypeColl   12


@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UIView *bottomView;
@property (nonatomic, weak) IBOutlet PFImageView *surfImage;
@property (nonatomic, weak) IBOutlet UILabel *surfLocation;
@property (nonatomic, weak) IBOutlet UILabel *surfRank;
@property (nonatomic, weak) IBOutlet UITextView *surfDesc;

@end

@implementation DetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *rankStr = [NSString stringWithFormat:@"# %i", self.detailInfo.rank];
    self.title = NSLocalizedString(rankStr, rankStr);
    
    // setup the view
    self.view.backgroundColor = [UIColor colorWithRed:0.34f green:0.67f blue:0.53f alpha:1.0f];
    //self.bottomView.backgroundColor = [UIColor colorWithRed:0.34f green:0.67f blue:0.53f alpha:1.0f];
    PFFile *thumbnail = self.detailInfo.imageFile;
    self.surfImage.file = thumbnail;
    [self.surfImage loadInBackground];
    
    self.surfDesc.text = self.detailInfo.desc;
    self.surfLocation.text = [NSString stringWithFormat:@"%@, %@", self.detailInfo.city, self.detailInfo.country];
    self.surfRank.text = [NSString stringWithFormat:@"# %i", self.detailInfo.rank];
    
    if (self.detailType == kTypeColl)
    {
        NSLog(@"Collection Pressed");
        [self.bottomView setHidden:NO];
    }
    else
    {
        NSLog(@"table Pressed");
        [self.bottomView setHidden:YES];
    }
}

- (IBAction)doneButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}
							
@end
