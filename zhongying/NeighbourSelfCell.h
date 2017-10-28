//
//  NeighbourSelfCell.h
//  zhongying
//
//  Created by lik on 14-4-11.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "MessageCell.h"

@interface NeighbourSelfCell : MessageCell{
    UIImageView *viewBackground;
}

+ (float)getCellHeightAccordingToContent:(NSString *)content;

@end
