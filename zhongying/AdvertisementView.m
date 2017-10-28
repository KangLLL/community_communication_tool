//
//  AdvertisementView.m
//  zhongying
//
//  Created by lk on 14-5-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AdvertisementView.h"
#import "AdvertisementParameter.h"

@interface AdvertisementView()

- (void)pageMoveToRight;
- (void)pageMoveToLeft;
- (void)setPageFrame;

- (void)autoPage;

- (void)touchAdvertisement:(id)sender;

@end

@implementation AdvertisementView

@synthesize container, pageControl;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        pages = [NSMutableArray array];
        cacher = [[DownloadCacher alloc] init];
        advertisementUrls = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc
{
    [autoPageTimer invalidate];
}

#pragma mark - Public Method

- (void)displayAdvertiseWithImages:(NSArray *)array
{
    self.pageControl.hidden = NO;
    [self.pageControl setNumberOfPages:[array count]];
    
    NSMutableArray *temp = [NSMutableArray arrayWithArray:array];
    while([temp count] < 3){
        for (UIImage *image in array) {
            [temp addObject:image];
        }
    }
    
    for(UIView *view in pages){
        [view removeFromSuperview];
    }
    [pages removeAllObjects];
    [autoPageTimer invalidate];
    for (int i = 0; i < [temp count]; i ++) {
        UIImage *image = [temp objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.tag = i % [array count];
        [self.container addSubview:imageView];
        [pages addObject:imageView];
    }
    
    self.container.contentSize = CGSizeMake(self.container.bounds.size.width * [temp count], self.container.bounds.size.height);
    [self setPageFrame];
    
    [self pageMoveToRight];
    [self.container setContentOffset:CGPointMake(self.container.bounds.size.width, 0) animated:NO];
    
    autoPageTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(autoPage) userInfo:nil repeats:YES];
}


- (void)displayAdvertiseWithAdvertisementResponse:(GetAdvertisementsResponseParameter *)response
{
    self.pageControl.hidden = NO;
    [advertisementUrls removeAllObjects];
    
    NSArray *original = response.advertisements;
    
    [self.pageControl setNumberOfPages:[original count]];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:response.advertisements];
    while([temp count] < 3){
        for (AdvertisementParameter *param in original) {
            AdvertisementParameter *newParam = [[AdvertisementParameter alloc] init];
            newParam.imageUrl = param.imageUrl;
            newParam.advertisementUrl = param.advertisementUrl;
            [temp addObject:newParam];
        }
    }
    
    for(UIView *view in pages){
        [view removeFromSuperview];
    }
    [pages removeAllObjects];
    [autoPageTimer invalidate];
        
    
    for (int i = 0; i < [temp count]; i ++) {
        AdvertisementParameter *param = [temp objectAtIndex:i];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.container.bounds.size.width, self.container.bounds.size.height)];
        view.tag = i % [original count];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.container.bounds.size.width, self.container.bounds.size.height)];
        [cacher getImageWithUrl:param.imageUrl andCell:nil inImageView:imageView withActivityView:nil];
        [view addSubview:imageView];
        if(param.advertisementUrl != nil && [param.advertisementUrl length] > 0 && [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:param.advertisementUrl]]){
            [advertisementUrls setObject:param.advertisementUrl forKey:[NSNumber numberWithInt:i %[original count]]];
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.container.bounds.size.width, self.container.bounds.size.height)];
            [button addTarget:self action:@selector(touchAdvertisement:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        }
        [self.container addSubview:view];
        [pages addObject:view];
    }
        
    self.container.contentSize = CGSizeMake(self.container.bounds.size.width * [temp count], self.container.bounds.size.height);
    [self setPageFrame];
    
    [self pageMoveToRight];
    [self.container setContentOffset:CGPointMake(self.container.bounds.size.width, 0) animated:NO];
    
    autoPageTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(autoPage) userInfo:nil repeats:YES];
}

- (int)currentDisplayPage
{
    CGFloat pageWidth = self.container.bounds.size.width;
    
    int page = floor((self.container.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    UIView *v = [pages objectAtIndex:page];
    return v.tag;
}

#pragma mark - Scroll Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.container.bounds.size.width;
    
    int page = floor((self.container.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if(page == 0) {
        [self pageMoveToRight];
        CGPoint p = CGPointZero;
        p.x = pageWidth;
        [scrollView setContentOffset:p animated:NO];
    } else if (page == [pages count] - 1) {
        [self pageMoveToLeft];
        CGPoint p = CGPointZero;
        p.x = ([pages count] - 2) * pageWidth;
        [scrollView setContentOffset:p animated:NO];
    }
    
    [self.pageControl setCurrentPage:[self currentDisplayPage]];
}



#pragma mark - Private Methods
- (void)touchAdvertisement:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSNumber *key = [NSNumber numberWithInt:button.superview.tag];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[advertisementUrls objectForKey:key]]];
}


- (void)autoPage
{
    if([pages count] >= 3){
        [UIView beginAnimations:@"autoPage" context:nil];
        [UIView animateWithDuration:0.5 animations:^{
            CGPoint newOffset = self.container.contentOffset;
            newOffset.x += self.container.bounds.size.width;
            self.container.contentOffset = newOffset;
        } completion:^(BOOL finished) {
            if(self.container.contentOffset.x == ([pages count] - 1) * self.container.bounds.size.width){
                [self pageMoveToLeft];
                CGPoint newOffset = self.container.contentOffset;
                newOffset.x -= self.container.bounds.size.width;
                [self.container setContentOffset:newOffset animated:NO];
                [self.pageControl setCurrentPage:[self currentDisplayPage]];
            }
        }];
        [UIView commitAnimations];
    }
}

- (void)pageMoveToRight
{
    NSMutableArray *temp = [NSMutableArray array];
    [temp addObject:[pages objectAtIndex:[pages count] - 1]];
    for(int i = 0; i < [pages count] - 1; i ++){
        [temp addObject:[pages objectAtIndex:i]];
    }
    pages = temp;
    
    [self setPageFrame];
}

- (void)pageMoveToLeft {
    NSMutableArray *temp = [NSMutableArray array];
    for(int i = 1; i < [pages count]; i ++){
        [temp addObject:[pages objectAtIndex:i]];
    }
    [temp addObject:[pages objectAtIndex:0]];
    pages = temp;
    
    [self setPageFrame];
}

- (void)setPageFrame
{
    for(int i = 0; i < [pages count]; i ++){
        UIView *view = [pages objectAtIndex:i];
        view.frame = CGRectMake(i * self.container.bounds.size.width, 0, self.container.bounds.size.width, self.container.bounds.size.height);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
