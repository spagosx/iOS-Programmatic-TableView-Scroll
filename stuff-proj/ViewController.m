
#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *leftTabelView;
@property (nonatomic, weak) IBOutlet UITableView *rightTableView;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = tableView == self.leftTabelView ? @"leftId" : @"rightId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"cell %d", indexPath.row + 1];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    cell.backgroundColor = indexPath.row %2 == 0 ? [UIColor redColor] : [UIColor blueColor];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        CGPoint offset = self.leftTabelView.contentOffset; // both tables have same offset so use anyone for reference
        offset.y = scrollView.contentOffset.x;
        self.leftTabelView.contentOffset = offset;
        self.rightTableView.contentOffset = offset;
    } else {
        UIScrollView *programmaticTV = scrollView == self.leftTabelView ? self.rightTableView : self.leftTabelView;
        programmaticTV.contentOffset = scrollView.contentOffset;
        CGPoint collectionViewOffset = self.collectionView.contentOffset;
        collectionViewOffset.x = scrollView.contentOffset.y;
        self.collectionView.contentOffset = collectionViewOffset;
    }
}

@end
