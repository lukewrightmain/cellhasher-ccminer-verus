# To change the cuda arch, edit Makefile.am and run ./build.sh
# Optimized for sustained performance across all cores
# Tuned for Cortex-A710 (3 cores, good balance of speed + thermal efficiency)
# Works well on X2 (when not throttled), A710 (optimal), and A510 (still fast)

# Optimized flags for ARM mining (tested for Termux compatibility)
extracflags="-O3 -ffast-math -funroll-loops -finline-functions -fomit-frame-pointer -fpic -pthread -D_REENTRANT"

# Cache alignment for ARM (conservative values that work)
alignflags="-falign-functions=16 -falign-jumps=16 -falign-labels=16"

# A710 tuning for best sustained performance (avoids X2 throttling)
./configure CXXFLAGS="$extracflags $alignflags -march=armv8.6-a+crypto+sha3+sm4+dotprod+i8mm+bf16 -mtune=cortex-a710" CFLAGS="$extracflags $alignflags -march=armv8.6-a+crypto+sha3+sm4+dotprod+i8mm+bf16 -mtune=cortex-a710" CXX=clang++ CC=clang LDFLAGS="-pthread"
