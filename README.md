# TabItemsDemo
### 给collectView添加手势
```
   UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPressed:)];
   [_collectView addGestureRecognizer:longPress];
```
## 以下是最主要的实现方法
### 实现手势方法和collectView的代理方法canMoveItemAtIndexPath和moveItemAtIndexPath
这三个方法是iOS9.0之后的
```
- (void)onLongPressed:(UILongPressGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:sender.view];
    NSIndexPath *indexPath = [_collectView indexPathForItemAtPoint:point];
    if(indexPath.section == 0&&indexPath.item!=0){
        switch (sender.state) {
            case UIGestureRecognizerStateBegan: {
                _showDeleteBtn=YES;
                [_collectView reloadSections:[NSIndexSet indexSetWithIndex:0]];
                if (indexPath) {
                    if (@available(iOS 9.0, *)) {
                        [_collectView beginInteractiveMovementForItemAtIndexPath:indexPath];
                    } else {
                        // Fallback on earlier versions
                    }
                }
                break;
            }
            case UIGestureRecognizerStateChanged: {
                if (@available(iOS 9.0, *)) {
                    [_collectView updateInteractiveMovementTargetPosition:point];
                } else {
                    // Fallback on earlier versions
                }
                break;
            }
            case UIGestureRecognizerStateEnded: {
                if (@available(iOS 9.0, *)) {
                    [_collectView endInteractiveMovement];
                } else {
                    // Fallback on earlier versions
                }
                break;
            }
            default: {
                if (@available(iOS 9.0, *)) {
                    [_collectView cancelInteractiveMovement];
                } else {
                    // Fallback on earlier versions
                }
                break;
            }
        }
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0&&indexPath.item!=0) {
        return YES;
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.section == 0 && destinationIndexPath.section == 0) {
        [_selectArray exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
    }
}

```
![image](https://github.com/lsfA1/TabItemsDemo/raw/master/TabItemsDemo/img/01.png)
