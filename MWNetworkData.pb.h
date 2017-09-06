// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import <ProtocolBuffers/ProtocolBuffers.h>

// @@protoc_insertion_point(imports)

@class MWNetworkData;
@class MWNetworkDataBuilder;



@interface MwnetworkDataRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

#define MWNetworkData_type @"type"
#define MWNetworkData_str_data @"strData"
#define MWNetworkData_from_usr @"fromUsr"
#define MWNetworkData_to_usr @"toUsr"
@interface MWNetworkData : PBGeneratedMessage<GeneratedMessageProtocol> {
@private
  BOOL hasType_:1;
  BOOL hasStrData_:1;
  BOOL hasFromUsr_:1;
  BOOL hasToUsr_:1;
  SInt32 type;
  NSString* strData;
  NSString* fromUsr;
  NSString* toUsr;
}
- (BOOL) hasType;
- (BOOL) hasStrData;
- (BOOL) hasFromUsr;
- (BOOL) hasToUsr;
@property (readonly) SInt32 type;
@property (readonly, strong) NSString* strData;
@property (readonly, strong) NSString* fromUsr;
@property (readonly, strong) NSString* toUsr;

+ (instancetype) defaultInstance;
- (instancetype) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (MWNetworkDataBuilder*) builder;
+ (MWNetworkDataBuilder*) builder;
+ (MWNetworkDataBuilder*) builderWithPrototype:(MWNetworkData*) prototype;
- (MWNetworkDataBuilder*) toBuilder;

+ (MWNetworkData*) parseFromData:(NSData*) data;
+ (MWNetworkData*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MWNetworkData*) parseFromInputStream:(NSInputStream*) input;
+ (MWNetworkData*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (MWNetworkData*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (MWNetworkData*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface MWNetworkDataBuilder : PBGeneratedMessageBuilder {
@private
  MWNetworkData* resultMwnetworkData;
}

- (MWNetworkData*) defaultInstance;

- (MWNetworkDataBuilder*) clear;
- (MWNetworkDataBuilder*) clone;

- (MWNetworkData*) build;
- (MWNetworkData*) buildPartial;

- (MWNetworkDataBuilder*) mergeFrom:(MWNetworkData*) other;
- (MWNetworkDataBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (MWNetworkDataBuilder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasType;
- (SInt32) type;
- (MWNetworkDataBuilder*) setType:(SInt32) value;
- (MWNetworkDataBuilder*) clearType;

- (BOOL) hasStrData;
- (NSString*) strData;
- (MWNetworkDataBuilder*) setStrData:(NSString*) value;
- (MWNetworkDataBuilder*) clearStrData;

- (BOOL) hasFromUsr;
- (NSString*) fromUsr;
- (MWNetworkDataBuilder*) setFromUsr:(NSString*) value;
- (MWNetworkDataBuilder*) clearFromUsr;

- (BOOL) hasToUsr;
- (NSString*) toUsr;
- (MWNetworkDataBuilder*) setToUsr:(NSString*) value;
- (MWNetworkDataBuilder*) clearToUsr;
@end


// @@protoc_insertion_point(global_scope)
