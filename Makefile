.PHONY: all build test

all: build test

build: src/lib.rs
	cargo build

test:
	cargo test

src/lib.rs: wrapper.h
	bindgen --output $@ \
		--raw-line "#![allow(non_upper_case_globals)]" \
		--raw-line "#![allow(non_camel_case_types)]" \
		--raw-line "#![allow(non_snake_case)]" \
		wrapper.h \
		-- \
		-I/usr/include/libzfs \
		-I/usr/include/libspl
