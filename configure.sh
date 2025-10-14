# To change the cuda arch, edit Makefile.am and run ./build.sh
# Optimized for Cortex-X2 (ARMv8.6-A with crypto extensions)

extracflags="-O3 -ffast-math -funroll-loops -finline-functions -fomit-frame-pointer -fpic -pthread -flto -fuse-ld=lld -D_REENTRANT -falign-functions=16 -falign-jumps=16 -falign-labels=16"

# Option 2: Explicit -march + -mtune (recommended for max control)
./configure CXXFLAGS="-Rpass-missed=loop-vectorize -Rpass-analysis=loop-vectorize $extracflags -march=armv8.6-a+crypto+sha3+sm4+dotprod+i8mm+bf16 -mtune=cortex-x2" CFLAGS="$extracflags -march=armv8.6-a+crypto+sha3+sm4+dotprod+i8mm+bf16 -mtune=cortex-x2 -mllvm -enable-loop-distribute" CXX=clang++ CC=clang LDFLAGS="-flto -fuse-ld=lld -pthread"
