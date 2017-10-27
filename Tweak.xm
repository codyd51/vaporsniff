
// TODO put in common.h
#define PRODUCT_NAME @"VaporSniff"
#define PRODUCT_ERROR_DOMAIN @"com.phillipt.vaporsniff"

#define NSLog(FORMAT, ...) NSLog(@"[%@: %s - %i] %@", PRODUCT_NAME, __FILE__, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__])

@interface PXFirmwareUpdater : NSObject {

}

+ (id)sharedInstance;
- (void)_updateFirmwareForDevice:(id)arg1;
- (void)beginUpdateAtFilePath:(id)arg1;
- (id)currentAppVersionInfoForModel:(id)arg1;
- (void)dfuProgressDidChangeFor:(long long)arg1 outOf:(long long)arg2 to:(long long)arg3 currentSpeedBytesPerSecond:(double)arg4 avgSpeedBytesPerSecond:(double)arg5;
- (void)dfuStateDidChangeTo:(long long)arg1;
- (void)dfuTargetSeen:(id)arg1;
- (void)updateFirmwareForDevice:(id)arg1;

@end

@interface PXPeripheral : NSObject
-(void)setColorTheme:(id)theme;
@end

@interface PXDeviceControlViewController : UIViewController
@end

#import "ColorPicker2/FCColorPickerViewController.h"
//12
@interface PTColorPickerLayout : UICollectionViewFlowLayout

@end

#import <stdint.h>

uint32_t colors[9][13] = {
	{
		0x330000,
		0x331900,
		0x333300,
		0x193300,
		0x003300,
		0x003319,
		0x003333,
		0x001933,
		0x000033,
		0x190033,
		0x330033,
		0x330019,
		0x000000,
	},
	{
		0x660000,
		0x663300,
		0x666600,
		0x336600,
		0x006600,
		0x006633,
		0x006666,
		0x003366,
		0x000066,
		0x330066,
		0x660066,
		0x660033,
		0x202020,
	},
	{
		0x990000,
		0x994C00,
		0x999900,
		0x4C9900,
		0x009900,
		0x00994C,
		0x009999,
		0x004C99,
		0x000099,
		0x4C0099,
		0x990099,
		0x99004C,
		0x404040,
	},
	{
		0xCC0000,
		0xCC6600,
		0xCCCC00,
		0x66CC00,
		0x00CC00,
		0x00CC66,
		0x00CCCC,
		0x0066CC,
		0x0000CC,
		0x6600CC,
		0xCC00CC,
		0xCC0066,
		0x606060,
	},
	{
		0xFF0000,
		0xFF8000,
		0xFFFF00,
		0x80FF00,
		0x00FF00,
		0x00FF80,
		0x00FFFF,
		0x0080FF,
		0x0000FF,
		0x7F00FF,
		0xFF00FF,
		0xFF007F,
		0x808080,
	},
	{
		0xFF3333,
		0xFF9933,
		0xFFFF33,
		0x99FF33,
		0x33FF33,
		0x33FF99,
		0x33FFFF,
		0x3399FF,
		0x3333FF,
		0x9933FF,
		0xFF33FF,
		0xFF3399,
		0xA0A0A0,
	},
	{
		0xFF6666,
		0xFFB266,
		0xFFFF66,
		0xB2FF66,
		0x66FF66,
		0x66FFB2,
		0x66FFFF,
		0x66B2FF,
		0x6666FF,
		0xB266FF,
		0xFF66FF,
		0xFF66B2,
		0xC0C0C0,
	},
	{
		0xFF9999,
		0xFFCC99,
		0xFFFF99,
		0xCCFF99,
		0x99FF99,
		0x99FFCC,
		0x99FFFF,
		0x99CCFF,
		0x9999FF,
		0xCC99FF,
		0xFF99FF,
		0xFF99CC,
		0xE0E0E0,
	},
	{
		0xFFCCCC,
		0xFFE5CC,
		0xFFFFCC,
		0xE5FFCC,
		0xCCFFCC,
		0xCCFFE5,
		0xCCFFFF,
		0xCCE5FF,
		0xCCCCFF,
		0xE5CCFF,
		0xFFCCFF,
		0xFFCCE5,
		0xFFFFFF,
	},
};

#define PICKER_ROWS 9
#define PICKER_COLS 13

@implementation PTColorPickerLayout
- (instancetype)init{
    if ((self = [super init])) {
        self.minimumLineSpacing = 1.0;
        self.minimumInteritemSpacing = 1.0;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}
- (CGSize)itemSize {
    NSInteger numberOfColumns = PICKER_ROWS;
 
    CGFloat itemWidth = (CGRectGetWidth(self.collectionView.frame) - (numberOfColumns - 1)) / numberOfColumns;
    return CGSizeMake(itemWidth, itemWidth);
}

@end

@interface PTColorsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView* colorPickerView;
@end

@implementation PTColorsViewController

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor orangeColor];
    cell.contentView.layer.borderWidth = 1.0;
    cell.contentView.layer.borderColor = [UIColor blackColor].CGColor;
 

    NSArray<NSArray<NSNumber*>*>* colors = @[
    	@[@255, @0, @0], //red
    	@[@255, @128, @0], //orange
    	@[@255, @255, @0], //yellow
    	@[@128, @255, @0], //light green
    	@[@0, @255, @0], //green
    	@[@0, @255, @128], //turqoise
    	@[@0, @255, @255], //teal
    	@[@0, @128, @255], //light blue
    	@[@0, @0, @255], //blue
    	@[@127, @0, @255], //light violet
    	@[@255, @0, @255], //pink
    	@[@255, @0, @127], //hot pink
    	@[@128, @128, @128], //gray
    ];
    /*
   	CGFloat rawColors[] = {colors[indexPath.row][0].floatValue,
   						colors[indexPath.row][1].floatValue,
   						colors[indexPath.row][2].floatValue};

   	NSInteger rowIndex = indexPath.item % indexPath.row;
   	for (int i = 0; i < 3; i++) {
   		rawColors[i] = (rawColors[i] + (rowIndex * 17));
   		if (rawColors[i] >= 255) rawColors[i] -= 255;
   	}
   	*/
   	NSLog(@"VaporSniff indexPath section %d row %d item %d", indexPath.section, indexPath.row, indexPath.item);
   	NSArray<NSNumber*>* rawColors = colors[indexPath.row % PICKER_ROWS];
   	//cell.contentView.backgroundColor = [UIColor colorWithRed:rawColors[0] green:rawColors[1] blue:rawColors[2] alpha:1.0];
   	cell.contentView.backgroundColor = [UIColor colorWithRed:rawColors[0].floatValue green:rawColors[1].floatValue blue:rawColors[2].floatValue alpha:1.0];
 
    return cell;
}
 
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return PICKER_ROWS * PICKER_ROWS;
}

-(void)viewWillAppear:(BOOL)animated {
	self.view.backgroundColor = [UIColor whiteColor];

	UILabel* l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
	l.text = @"Choose your PAX's LED color";
	l.center = CGPointMake(self.view.center.x, self.view.frame.size.height * 0.025);
	l.textColor = [UIColor blackColor];
	l.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:l];

	UILabel* l2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
	l2.text = @"by @phillipten";
	l2.center = CGPointMake(self.view.center.x, self.view.frame.size.height * 0.1);
	l2.textColor = [UIColor blackColor];
	l2.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:l2];


	PTColorPickerLayout* collectionLayout = [[PTColorPickerLayout alloc] init];
	CGRect colorPickerViewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.75);
	self.colorPickerView = [[UICollectionView alloc] initWithFrame:colorPickerViewFrame collectionViewLayout:collectionLayout];
	self.colorPickerView.center = CGPointMake(self.view.center.x, self.view.frame.size.height * 0.7);
	[self.colorPickerView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
	[self.view addSubview:self.colorPickerView];

	self.colorPickerView.delegate = self;
	self.colorPickerView.dataSource = self;
	[self.colorPickerView reloadData];

	NSLog(@"colorPickerView %@", self.colorPickerView);

	UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[closeButton setTitle:@"Close" forState:UIControlStateNormal];
	[closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

	CGSize screenSize = [[UIScreen mainScreen] bounds].size;
	closeButton.frame = CGRectMake(0, 0, 100, 100);
	closeButton.center = CGPointMake(screenSize.width / 2, screenSize.height * 0.975);
	[self.view addSubview:closeButton];
	NSLog(@"closeButton %@", closeButton);
}

-(void)closeButtonPressed:(UIButton*)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)selectedColorChanged:(id)sender {
	NSLog(@"selectedColorChanged %@", sender);
}

@end

%hook PXDeviceControlViewController

-(void)viewDidAppear:(BOOL)animated {
	NSLog(@"viewDidAppear");

	UIButton* colorsButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[colorsButton setTitle:@"Colors" forState:UIControlStateNormal];
	[colorsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[colorsButton addTarget:self action:@selector(colorsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

	CGSize screenSize = [[UIScreen mainScreen] bounds].size;
	colorsButton.frame = CGRectMake(0, 0, 100, 100);
	colorsButton.center = CGPointMake(screenSize.width * 0.25, screenSize.height * 0.9);
	[self.view addSubview:colorsButton];
	NSLog(@"colorsButton %@", colorsButton);
	/*
	FCColorPickerViewController* vc = [FCColorPickerViewController colorPicker];
	[self.navigationController pushViewController:vc animated:YES];
	*/
}

%new
-(void)colorsButtonPressed:(UIButton*)sender {
	NSLog(@"Colors pressed");
	PTColorsViewController* vc = [[PTColorsViewController alloc] init];
	//FCColorPickerViewController* vc = [[FCColorPickerViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
}

%end

%hook PXPeripheral
-(void)setColorTheme:(id)theme {
	NSLog(@"setColorTheme %@", theme);
	%orig;
}
%end

%hook PXFirmwareUpdater

- (void)_updateFirmwareForDevice:(id)arg1 {
	NSLog(@"_updateFirmwareForDevice: %@", arg1);
	%orig;
}

- (void)beginUpdateAtFilePath:(id)arg1 {
	NSLog(@"beginUpdateAtFilePath: %@", arg1);
	%orig;
}

- (id)currentAppVersionInfoForModel:(id)arg1 {
	NSLog(@"currentAppVersionInfoForModel: %@", arg1);
	return %orig;
}

- (void)dfuProgressDidChangeFor:(long long)arg1 outOf:(long long)arg2 to:(long long)arg3 currentSpeedBytesPerSecond:(double)arg4 avgSpeedBytesPerSecond:(double)arg5 {
	NSLog(@"dfuProgressDidChangeFor: %lld outOf: %lld to: %lld currentSpeedBytesPerSecond: %f avgSpeedBytesPerSecond: %f", arg1, arg2, arg3, arg4, arg5);
	%orig;
}

- (void)dfuStateDidChangeTo:(long long)arg1 {
	%orig;
	NSLog(@"dfuStateDidChangeTo: %lld", arg1);
}

- (void)dfuTargetSeen:(id)arg1 {
	NSLog(@"dfuTargetSeen: %@", arg1);
	%orig;
}

- (void)updateFirmwareForDevice:(id)arg1 {
	NSLog(@"updateFirmwareForDevice: %@", arg1);
	%orig;
}

%end
