.PHONY: all build test

all: build test

build: src/bindings.rs
	cargo build

test:
	cargo test

src/bindings.rs: wrapper.h Makefile
	bindgen --output $@ \
		--ctypes-prefix ::libc \
		--use-core \
		$< \
		-- \
		-I/usr/include/libzfs \
		-I/usr/include/libspl

bindgen:
	cargo install --force --git https://github.com/rust-lang-nursery/rust-bindgen.git --branch master
