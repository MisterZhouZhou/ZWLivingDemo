//
//  ZWMeinfoView.m
//  Live
//

#import "ZWMeinfoView.h"
#import "ZWUserHelper.h"
@interface ZWMeinfoView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation ZWMeinfoView

+(instancetype)loadInfoView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZWMeinfoView" owner:self options:nil] lastObject];
}

-(void)showInfo
{
    self.nameLabel.text = [ZWUserHelper sharedUser].username;
    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.layer.masksToBounds = YES;
    [self.iconImageView downloadImage:[ZWUserHelper sharedUser].iconUrl placeholder:@"default_head"];
}

@end
