ASM=nasm

SRC_DIR=src
BUILD_DIR=build
QEMU=qemu-system-x86_64

.PHONY: build run clean

all: build run

build:
	@echo "Building project..."
	${ASM} ${SRC_DIR}/boot.asm -f bin -o ${BUILD_DIR}/main.bin

clean:
	@echo "Cleaning build directory..."
	rm -f ${BUILD_DIR}/*.bin

run: build
	@echo "Running project..."
	${QEMU} -drive file=${BUILD_DIR}/main.bin,format=raw
	@echo "Project finished running."
