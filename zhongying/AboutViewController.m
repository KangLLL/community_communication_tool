//
//  AboutViewController.m
//  zhongying
//
//  Created by lk on 14-4-14.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AboutViewController.h"
#import "CommonConsts.h"
#import "UserInformation.h"
#import "MobClick.h"


#define HOME_PAGE_URL           @"http://xiaohuangquan.com"
#define CLIENT_PHONE_NUMBER     @"400801808"
#define CELL_REUSE_IDENTIFIER   @"Cell"

#define SHARE_MESSAGE_FORMAT    @"我正在使用小黄犬业主助手，你也赶快加入吧！！下载狂击：http://www.xiaohuangquan.com/d.php?u=%@"
#define SHARE_MESSAGE_TEXT      @"我正在使用小黄犬业主助手，你也赶快加入吧！！下载狂击：http://www.xiaohuangquan.com/d.php"

@interface AboutViewController ()

- (void)constructSelectionTable;
- (void)showSelectionTable;
- (void)hideSelectionTable;

- (NSString *)getShareText;

@end

@implementation AboutViewController

@synthesize buttonPhone, buttonUrl, viewConnect, viewMask;

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
    
    NSString *plainText = self.buttonUrl.titleLabel.text;
    NSDictionary *attributes = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInt:1]};
    NSRange range = [plainText rangeOfString:plainText];
    NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
    [styledText setAttributes:attributes range:range];
    self.buttonUrl.titleLabel.attributedText = styledText;
    
    
    plainText = self.buttonPhone.titleLabel.text;
    range = [plainText rangeOfString:plainText];
    styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
    [styledText setAttributes:attributes range:range];
    self.buttonPhone.titleLabel.attributedText = styledText;
    
    self.viewConnect.layer.borderWidth = 1;
    self.viewConnect.layer.borderColor = [UIColor grayColor].CGColor;
    self.viewConnect.layer.cornerRadius = 5;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSelectionTable)];
    [self.viewMask addGestureRecognizer:tapGesture];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions

- (IBAction)toHomePage:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:HOME_PAGE_URL]];
}

- (IBAction)dialPhone:(id)sender
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",CLIENT_PHONE_NUMBER];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    /*
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",CLIENT_PHONE_NUMBER];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
     */
}

- (IBAction)share:(id)sender
{
    [self showSelectionTable];
}

- (IBAction)checkUpdate:(id)sender
{
    NSLog(@"update");
    //[MobClick checkUpdate];
}

#pragma mark - Table Delegate

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    if(indexPath.row == 0){
        cell.imageView.image = [UIImage imageNamed:@"mail.png"];
        cell.textLabel.text = @"电子邮件";
    }
    else if(indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:@"message.png"];
        cell.textLabel.text = @"信息";
    }
    else if(indexPath.row == 2){
        cell.imageView.image = [UIImage imageNamed:@"weibo.png"];
        cell.textLabel.text = @"新浪微博";
    }
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    head.backgroundColor = [UIColor blackColor];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 200, 32)];
    title.text = @"    分享给邻居";
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    [head addSubview:title];
    return head;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        if([MFMailComposeViewController canSendMail]){
            MFMailComposeViewController *mcvc = [[MFMailComposeViewController alloc] init];
            mcvc.mailComposeDelegate = self;
            [mcvc setMessageBody:[self getShareText] isHTML:NO];
            [self presentViewController:mcvc animated:YES completion:nil];
        }
        else{
            [self showErrorMessage:@"此设备不能发邮件"];
        }
    }
    else if(indexPath.row == 1){
        if([MFMessageComposeViewController canSendText]){
            MFMessageComposeViewController *mcvc = [[MFMessageComposeViewController alloc] init];
            mcvc.messageComposeDelegate = self;
            mcvc.body = [self getShareText];
            [self presentViewController:mcvc animated:YES completion:nil];
        }
        else{
            [self showErrorMessage:@"此设备不能发短信"];
        }
    }
    else if(indexPath.row == 2){
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo])
        {
            SLComposeViewController *weiboController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
            weiboController.completionHandler = ^(SLComposeViewControllerResult result){
                switch (result) {
                    case SLComposeViewControllerResultCancelled:{
                        NSLog(@"cancel");
                    }
                        break;
                    case SLComposeViewControllerResultDone:{
                        NSLog(@"done");
                    }
                        break;
                    default:
                        break;
                }
                /*
                [weiboController dismissViewControllerAnimated:YES completion:^{
                }];
                 */
            };
            [weiboController setInitialText:[self getShareText]];
            [self presentViewController:weiboController animated:YES completion:nil];
        }
        else{
            [self showErrorMessage:@"此设备不能发新浪微博"];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self hideSelectionTable];
}

#pragma mark - Private Methods
- (void)constructSelectionTable
{
    tableOptions = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, 300, 0)];
    [tableOptions registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_REUSE_IDENTIFIER];
    tableOptions.dataSource = self;
    tableOptions.delegate = self;
    tableOptions.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableOptions];
    
    [tableOptions reloadData];
}

- (void)showSelectionTable
{
    if(tableOptions == nil){
        [self constructSelectionTable];
    }
    self.viewMask.hidden = NO;
    tableOptions.hidden = NO;
    
    float totalHeight = tableOptions.contentSize.height;
    float maxHeight = self.view.bounds.size.height - 2 * MIN_SELECTION_MARGIN;
    
    CGRect newFrame = tableOptions.frame;
    newFrame.size.height = MIN(totalHeight, maxHeight);
    tableOptions.frame = newFrame;
    tableOptions.center = self.view.center;
}

- (void)hideSelectionTable
{
    tableOptions.hidden = YES;
    self.viewMask.hidden = YES;
}

- (NSString *)getShareText
{
    if([UserInformation instance].userId != nil){
        return [NSString stringWithFormat:SHARE_MESSAGE_FORMAT, [UserInformation instance].userId];
    }
    else{
        return SHARE_MESSAGE_TEXT;
    }
}

#pragma mark - Message Delegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultSent:{
            NSLog(@"sent");
        }
            break;
        case MessageComposeResultCancelled:{
            NSLog(@"cancel");
        }
            break;
        case MessageComposeResultFailed:{
            NSLog(@"fail");
        }
            break;
        default:
            break;
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Mail Delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultCancelled:{
            NSLog(@"cancel");
        }
            break;
        case MFMailComposeResultFailed:{
            NSLog(@"fail");
        }
            break;
        case MFMailComposeResultSaved:{
            NSLog(@"save");
        }
            break;
        case MFMailComposeResultSent:{
            NSLog(@"sent");
        }
            break;
        default:
            break;
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
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
