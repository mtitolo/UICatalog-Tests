/*
     File: MainViewController.m 
 Abstract: The application's main view controller (front page).
  
  Version: 2.10 
  
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple 
 Inc. ("Apple") in consideration of your agreement to the following 
 terms, and your use, installation, modification or redistribution of 
 this Apple software constitutes acceptance of these terms.  If you do 
 not agree with these terms, please do not use, install, modify or 
 redistribute this Apple software. 
  
 In consideration of your agreement to abide by the following terms, and 
 subject to these terms, Apple grants you a personal, non-exclusive 
 license, under Apple's copyrights in this original Apple software (the 
 "Apple Software"), to use, reproduce, modify and redistribute the Apple 
 Software, with or without modifications, in source and/or binary forms; 
 provided that if you redistribute the Apple Software in its entirety and 
 without modifications, you must retain this notice and the following 
 text and disclaimers in all such redistributions of the Apple Software. 
 Neither the name, trademarks, service marks or logos of Apple Inc. may 
 be used to endorse or promote products derived from the Apple Software 
 without specific prior written permission from Apple.  Except as 
 expressly stated in this notice, no other rights or licenses, express or 
 implied, are granted by Apple herein, including but not limited to any 
 patent rights that may be infringed by your derivative works or by other 
 works in which the Apple Software may be incorporated. 
  
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE 
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION 
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS 
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND 
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS. 
  
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL 
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, 
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED 
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), 
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE 
 POSSIBILITY OF SUCH DAMAGE. 
  
 Copyright (C) 2011 Apple Inc. All Rights Reserved. 
  
 */

#import "MainViewController.h"

#import "ButtonsViewController.h"
#import "TextFieldController.h"
#import "TextViewController.h"
#import "SegmentViewController.h"
#import "AlertsViewController.h"

#import "Constants.h"

static NSString *kCellIdentifier = @"MyIdentifier";
static NSString *kTitleKey = @"title";
static NSString *kExplainKey = @"explanation";
static NSString *kViewControllerKey = @"viewController";

@implementation MainViewController

@synthesize menuList;

- (void)viewDidLoad
{	
	[super viewDidLoad];
	
	// construct the array of page descriptions we will use (each description is a dictionary)
	//
	self.menuList = [NSMutableArray array];
	
	// for showing various UIButtons:
	ButtonsViewController *buttonsViewController = [[ButtonsViewController alloc]
														initWithNibName:@"ButtonsViewController" bundle:nil];
	[self.menuList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								NSLocalizedString(@"ButtonsTitle", @""), kTitleKey,
								NSLocalizedString(@"ButtonsExplain", @""), kExplainKey,
                              buttonsViewController, kViewControllerKey,
							  nil]];
	[buttonsViewController release];
	
	// for showing various UITextFields:
	TextFieldController *textFieldViewController = [[TextFieldController alloc]
														initWithNibName:@"TextFieldController" bundle:nil];
	[self.menuList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								NSLocalizedString(@"TextFieldTitle", @""), kTitleKey,
                                NSLocalizedString(@"TextFieldExplain", @""), kExplainKey,
								textFieldViewController, kViewControllerKey,
							  nil]];
	[textFieldViewController release];
    
	// for showing UITextView:
	TextViewController *textViewController = [[TextViewController alloc]
												initWithNibName:@"TextViewController" bundle:nil];
	[self.menuList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								NSLocalizedString(@"TextViewTitle", @""), kTitleKey,
                                NSLocalizedString(@"TextViewExplain", @""), kExplainKey,
								textViewController, kViewControllerKey,
							  nil]];
	[textViewController release];	
	
	// for showing various UISegmentedControls:
	SegmentViewController *segmentViewController = [[SegmentViewController alloc]
														initWithNibName:@"SegmentViewController" bundle:nil];
	[self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
								NSLocalizedString(@"SegmentTitle", @""), kTitleKey,
                                NSLocalizedString(@"SegmentExplain", @""), kExplainKey,
								segmentViewController, kViewControllerKey,
							  nil]];
	[segmentViewController release];
	// for showing various UIActionSheets and UIAlertViews:
	AlertsViewController *alertsViewController = [[AlertsViewController alloc]
														initWithNibName:@"AlertsViewController" bundle:nil];
	[self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
								NSLocalizedString(@"AlertTitle", @""), kTitleKey,
                                NSLocalizedString(@"AlertExplain", @""), kExplainKey,
								alertsViewController, kViewControllerKey,
							  nil]];
	[alertsViewController release];
	
	// create a custom navigation bar button and set it to always say "Back"
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
}

// called after the view controller's view is released and set to nil.
// For example, a memory warning which causes the view to be purged. Not invoked as a result of -dealloc.
// So release any properties that are loaded in viewDidLoad or can be recreated lazily.
//
- (void)viewDidUnload
{
	[super viewDidUnload];
	
	self.menuList = nil;
}

- (void)dealloc
{
	[menuList release];	
	[super dealloc];
}


#pragma mark -
#pragma mark UIViewController delegate

- (void)viewWillAppear:(BOOL)animated
{
	// this UIViewController is about to re-appear, make sure we remove the current selection in our table view
	NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
	[self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
}


#pragma mark -
#pragma mark UITableViewDelegate

// the table's selection has changed, switch to that item's UIViewController
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIViewController *targetViewController = [[self.menuList objectAtIndex: indexPath.row] objectForKey:kViewControllerKey];
	[[self navigationController] pushViewController:targetViewController animated:YES];
}


#pragma mark -
#pragma mark UITableViewDataSource

// tell our table how many rows it will have, in our case the size of our menuList
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.menuList count];
}

// tell our table what kind of cell to use and its title for the given row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	cell.textLabel.text = [[self.menuList objectAtIndex:indexPath.row] objectForKey:kTitleKey];
    cell.detailTextLabel.text = [[self.menuList objectAtIndex:indexPath.row] objectForKey:kExplainKey];
    
    cell.accessibilityLabel = cell.textLabel.text;
    
	return cell;
}

@end


