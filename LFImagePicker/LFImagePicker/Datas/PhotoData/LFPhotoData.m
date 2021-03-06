//
//  LFPhotoData.m
//  LFImagePicker
//
//  Created by LongFan on 15/9/28.
//  Copyright © 2015年 LongFan. All rights reserved.
//

#import "LFPhotoData.h"

@interface LFPhotoData ()

@property (nonatomic, assign) PHAuthorizationStatus authorizationStatus;
@property (nonatomic, strong) PHCachingImageManager *cachingImageManager;

@end

@implementation LFPhotoData

#pragma mark - public

- (void)configAlbums:(void (^)(void))complete
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            dispatch_async(dispatch_get_main_queue(), ^{
                PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                                                                      subtype:PHAssetCollectionSubtypeAny
                                                                                      options:nil];
                self.smartAlbums = smartAlbums;
                PHFetchResult *userAlbums = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:nil];
                self.userAlbums = userAlbums;
                PHFetchResult *syncedAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                                      subtype:PHAssetCollectionSubtypeAlbumSyncedAlbum
                                                                                      options:nil];
                self.syncedAlbums = syncedAlbums;
                [self configAlbumByAlbums:smartAlbums];
                complete();
            });
        }
    }];
}

- (void)configAlbumByAlbums:(PHFetchResult *)albums
{
    [albums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([collection.localizedTitle isEqualToString:@"Camera Roll"]
            ||[collection.localizedTitle isEqualToString:@"相机胶卷"]
            ||[collection.localizedTitle isEqualToString:@"All Photos"]
            ||[collection.localizedTitle isEqualToString:@"所有照片"]) {
            
            self.album = collection;
            PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
            [self configPhotosByAlbum:assetsFetchResult];
        }
    }];
}

- (void)configPhotosByAlbum:(PHFetchResult *)album
{
    self.assets = album;
}

#pragma mark - getters&setters

- (PHAuthorizationStatus)authorizationStatus
{
    _authorizationStatus = [PHPhotoLibrary authorizationStatus];
    return _authorizationStatus;
}

- (PHCachingImageManager *)cachingImageManager
{
    if (_cachingImageManager == nil) {
        _cachingImageManager = [[PHCachingImageManager alloc] init];
    }
    return _cachingImageManager;
}

@end
