#import "ObjCVDF.h"
#import "verifier.h"
#include "prover_slow.h"

@implementation ObjCVDF

+ (NSString *)createDiscriminant:(NSData *)seed length:(NSInteger)length
{
    std::vector<uint8_t> seed_vector;
    seed_vector.resize(seed.length);
    
    for(size_t i=0; i<seed.length; i++) {
        seed_vector[i] = ((const uint8_t *)seed.bytes)[i];
    }
    
    integer D = CreateDiscriminant(seed_vector);
    std::string dStr = D.to_string();
    return [NSString stringWithCString:dStr.c_str() encoding:[NSString defaultCStringEncoding]];
}

+ (BOOL)verifyNWesolowski:(NSString *)discriminant
                      x_s:(NSData *)x_s
               proof_blob:(NSData *)proof_blob
               iterations:(uint64_t)iterations
           disc_size_bits:(uint64_t)disc_size_bits
                recursion:(uint64_t)recursion
{
    integer D = integer(std::string([discriminant UTF8String]));
    return CheckProofOfTimeNWesolowski(D, (const uint8_t *)x_s.bytes, (const uint8_t *)proof_blob.bytes, proof_blob.length, iterations, disc_size_bits, recursion);
}

@end
