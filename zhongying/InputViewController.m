//
//  InputViewController.m
//  zhongying
//
//  Created by LI K on 17/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import "InputViewController.h"

@interface InputViewController ()

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;

@end

@implementation InputViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    textFields = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public Methods
- (void)registerTextField:(UIView *)textField
{
    [textFields addObject:textField];
}

- (void)resignFocus
{
    for (UIView *input in textFields) {
        [input resignFirstResponder];
    }
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textFields containsObject:textField]){
        int index = [textFields indexOfObject:textField];
        if(index != [textFields count] - 1){
            [[textFields objectAtIndex:index + 1] becomeFirstResponder];
        }
        else{
            [self inputFinish];
        }
    }
    return YES;
}

- (void)inputFinish
{
    for (UITextField *text in textFields) {
        [text resignFirstResponder];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    keyboardHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [self keyboardWillShow];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    keyboardHeight = 0;
    [self keyboardWillHide];
}

- (void)keyboardWillShow
{
}

- (void)keyboardWillHide
{
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
