#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ObjCVDF : NSObject

+ (NSString *)createDiscriminant:(NSData *)seed length:(NSInteger)length;

+ (BOOL)verifyNWesolowski:(NSString *)discriminant
                      x_s:(NSData *)x_s
              proof_blob:(NSData *)proof_blob
               iterations:(uint64_t)iterations
           disc_size_bits:(uint64_t)disc_size_bits
                recursion:(uint64_t)recursion;

@end

NS_ASSUME_NONNULL_END
