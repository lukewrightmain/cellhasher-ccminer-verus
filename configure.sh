# To change the cuda arch, edit Makefile.am and run ./build.sh
# Optimized for sustained performance across all cores
# Tuned for Cortex-A710 (3 cores, good balance of speed + thermal efficiency)
# Works well on X2 (when not throttled), A710 (optimal), and A510 (still fast)

# Enhanced optimization flags for maximum mining performance
extracflags="-O3 -ffast-math -funroll-loops -finline-functions -fomit-frame-pointer -fpic -pthread -flto -fuse-ld=lld -D_REENTRANT"

# Alignment flags for cache efficiency (64-byte cache lines on ARM)
alignflags="-falign-functions=64 -falign-jumps=64 -falign-labels=64 -falign-loops=64"

# Memory optimization flags
memflags="-fvectorize -fslp-vectorize -fvectorize-slp-aggressive -mllvm -enable-loop-distribute -mllvm -loop-unswitch-threshold=200000"

# Hybrid approach: A710 tuning for best sustained performance (avoids X2 throttling)
./configure CXXFLAGS="-Rpass-missed=loop-vectorize -Rpass-analysis=loop-vectorize $extracflags $alignflags $memflags -march=armv8.6-a+crypto+sha3+sm4+dotprod+i8mm+bf16 -mtune=cortex-a710" CFLAGS="$extracflags $alignflags $memflags -march=armv8.6-a+crypto+sha3+sm4+dotprod+i8mm+bf16 -mtune=cortex-a710" CXX=clang++ CC=clang LDFLAGS="-flto -fuse-ld=lld -pthread"
