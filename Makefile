.PHONY: all build test

all: build test

build: src/bindings.rs
	cargo build

test:
	cargo test

src/bindings.rs: wrapper.h
	bindgen --output $@ wrapper.h -- -I/usr/include/libzfs -I/usr/include/libspl
