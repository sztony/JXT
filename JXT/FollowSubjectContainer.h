//
//  FollowSubjectContainer.h
//  JXT
//
//  Created by 伍 兵 on 14-8-5.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBCheckBox.h"

@protocol FollowSubjectContainerDelegate <NSObject>
-(void)SubjectContainerClickedCheckBox:(WBCheckBox*)aCheckBox;
@end


@interface FollowSubjectContainer : UIView
{
    NSMutableArray* subjectsArray;
   IBOutlet id<FollowSubjectContainerDelegate> delegate;
}
@property(nonatomic,assign) IBOutlet id<FollowSubjectContainerDelegate> delegate;
-(NSString*)valueString;
-(NSString*)allValueString;
-(void)allCheck:(BOOL)isCheck;
-(void)updateSubjectsArrayWithArray:(NSArray*)aArray;
@end
