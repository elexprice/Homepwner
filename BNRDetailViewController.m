//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by IE Mixes on 4/3/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"
#import "BNRChangeDateViewController.h"

@interface BNRDetailViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIButton *changeDateButton;

@end

@implementation BNRDetailViewController

- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    // If the device has a camera, take a picture, otherwise,
    // just pick from photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    // Place image picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];
}


- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // Store the image in the BNRImageStore for this key
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    //  Put that image onto the screen in image view
    self.imageView.image = image;
    
    // Take image picker off screen -
    // you must call this dismiss method
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)changeDateButtonClicked:(id)sender
{
     _changeDateVC = [[BNRChangeDateViewController alloc] init];
    
    _changeDateVC.item = self.item;
    
    [self.navigationController pushViewController:_changeDateVC animated:YES];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    // You need an NSDateFormatter that will turn a date into a simple date string
    static NSDateFormatter *dateFormater = nil;
    
    if (!dateFormater) {
        dateFormater = [[NSDateFormatter alloc] init];
        dateFormater.dateStyle = NSDateFormatterMediumStyle;
        dateFormater.timeStyle = NSDateFormatterNoStyle;
    }
    
    // Use filtered NSDate object to set daateLabels contents
    if (!self.changeDateVC){
        NSLog(@"No CDVC");
        
       self.dateField.text = [dateFormater stringFromDate:item.dateCreated];
        
    } else {
        
        //[self.item changeDate: self.changeDateVC.datePicker.date];
        self.dateField.text = [dateFormater stringFromDate:item.dateCreated];
        self.changeDateVC.item = self.item;
    
    }
    NSString *imageKey = self.item.itemKey;
    
    // Get the image for its image key from the image store
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:imageKey];
    
    // Use that image to put on the screen in the imageView
    self.imageView.image = imageToDisplay;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to item
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

-(void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.valueField resignFirstResponder];
}

// Text field delegate method when field is in editing mode
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    // Create a View for done button
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    
    // create a button for done button view and assign an action when button is tapped
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"DONE"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(doneClicked:)];
    
    // add the done button to the done button view
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    
    // add the done button view to the keyboard when the value field is in editing mode
    self.valueField.inputAccessoryView = keyboardDoneButtonView;

}


// method to clear keyboard off view when done button is tapped
-(IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Button Clicked");
    [self.view endEditing:YES];
}


@end
