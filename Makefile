.PHONY: all build test

all: build test

build: src/lib.rs
	cargo build

test:
	cargo test

src/lib.rs: wrapper.h Makefile
	bindgen --output $@ \
		--ctypes-prefix ::libc \
		--use-core \
		--raw-line "#![allow(non_upper_case_globals)]" \
		--raw-line "#![allow(non_camel_case_types)]" \
		--raw-line "#![allow(non_snake_case)]" \
		--raw-line "#![no_std]" \
		--raw-line "extern crate libc;" \
		--whitelist-function '^(libzfs|lzc|zfs|zpool|zprop|zvol)_.*' \
		--whitelist-type '^(libzfs|lzc|zfs|zpool|zprop|zvol|vdev|diff)_.*' \
		--whitelist-var '^(libzfs|lzc|zfs|zpool|zprop|zvol|ezfs)_.*' \
		$< \
		-- \
		-I/usr/include/libzfs \
		-I/usr/include/libspl

# also to consider: nvpair, nvlist, avl, ddt, spa, dsl, dmu, zio

bindgen:
	cargo install --force --git https://github.com/rust-lang-nursery/rust-bindgen.git --branch master
