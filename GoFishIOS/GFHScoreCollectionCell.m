//
//  GFHScoreCollectionCell.m
//  GoFishIOS
//
//  Created by Amanda Simon on 1/12/16.
//  Copyright © 2016 RoleModel Software. All rights reserved.
//

#import "GFHScoreCollectionCell.h"

@interface GFHScoreCollectionCell()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation GFHScoreCollectionCell

- (void) setScore:(NSArray *)score {
    _score = score;
    self.scoreLabel.text = [NSString stringWithFormat:@"%@: %d", _score[0], [_score[1] intValue]];
}
@end
