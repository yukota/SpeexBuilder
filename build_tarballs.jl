# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "Speex"
version = v"1.2.0"

# Collection of sources required to build Speex
sources = [
    "http://downloads.us.xiph.org/releases/speex/speex-1.2.0.tar.gz" =>
    "eaae8af0ac742dc7d542c9439ac72f1f385ce838392dc849cae4536af9210094",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd speex-1.2.0/
./configure --prefix=$prefix --host=$target
make
make install
exit

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, libc=:glibc)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libspeex", :libspeex)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)

