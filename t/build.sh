gcc 00-struct-sizes.c `pkg-config --cflags libgtop-2.0` -fPIC -shared -o 00-struct-sizes.so `pkg-config --libs libgtop-2.0`
