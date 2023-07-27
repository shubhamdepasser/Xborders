//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<advance_pdf_viewer/FlutterPluginPdfViewerPlugin.h>)
#import <advance_pdf_viewer/FlutterPluginPdfViewerPlugin.h>
#else
@import advance_pdf_viewer;
#endif

#if __has_include(<connectivity/FLTConnectivityPlugin.h>)
#import <connectivity/FLTConnectivityPlugin.h>
#else
@import connectivity;
#endif

#if __has_include(<file_picker/FilePickerPlugin.h>)
#import <file_picker/FilePickerPlugin.h>
#else
@import file_picker;
#endif

#if __has_include(<flutter_barcode_scanner/SwiftFlutterBarcodeScannerPlugin.h>)
#import <flutter_barcode_scanner/SwiftFlutterBarcodeScannerPlugin.h>
#else
@import flutter_barcode_scanner;
#endif

#if __has_include(<flutter_inappwebview/InAppWebViewFlutterPlugin.h>)
#import <flutter_inappwebview/InAppWebViewFlutterPlugin.h>
#else
@import flutter_inappwebview;
#endif

#if __has_include(<image_picker/FLTImagePickerPlugin.h>)
#import <image_picker/FLTImagePickerPlugin.h>
#else
@import image_picker;
#endif

#if __has_include(<path_provider/FLTPathProviderPlugin.h>)
#import <path_provider/FLTPathProviderPlugin.h>
#else
@import path_provider;
#endif

#if __has_include(<permission_handler/PermissionHandlerPlugin.h>)
#import <permission_handler/PermissionHandlerPlugin.h>
#else
@import permission_handler;
#endif

#if __has_include(<sqflite/SqflitePlugin.h>)
#import <sqflite/SqflitePlugin.h>
#else
@import sqflite;
#endif

#if __has_include(<syncfusion_flutter_pdfviewer/SyncfusionFlutterPdfViewerPlugin.h>)
#import <syncfusion_flutter_pdfviewer/SyncfusionFlutterPdfViewerPlugin.h>
#else
@import syncfusion_flutter_pdfviewer;
#endif

#if __has_include(<wifi_info_flutter/WifiInfoFlutterPlugin.h>)
#import <wifi_info_flutter/WifiInfoFlutterPlugin.h>
#else
@import wifi_info_flutter;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterPluginPdfViewerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterPluginPdfViewerPlugin"]];
  [FLTConnectivityPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTConnectivityPlugin"]];
  [FilePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FilePickerPlugin"]];
  [SwiftFlutterBarcodeScannerPlugin registerWithRegistrar:[registry registrarForPlugin:@"SwiftFlutterBarcodeScannerPlugin"]];
  [InAppWebViewFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"InAppWebViewFlutterPlugin"]];
  [FLTImagePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTImagePickerPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
  [SyncfusionFlutterPdfViewerPlugin registerWithRegistrar:[registry registrarForPlugin:@"SyncfusionFlutterPdfViewerPlugin"]];
  [WifiInfoFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"WifiInfoFlutterPlugin"]];
}

@end
