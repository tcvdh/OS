ASM=nasm

# Use absolute paths regardless of where make is run from
ROOT_DIR:=$(shell pwd)
SRC_DIR:=$(ROOT_DIR)/src
BUILD_DIR:=$(ROOT_DIR)/build
QEMU=qemu-system-x86_64

.PHONY: build run clean ensure_build_dir

all: build run clear

build: ensure_build_dir
	@echo "Building project..."
	$(ASM) $(SRC_DIR)/boot.asm -f bin -o $(BUILD_DIR)/main.bin

ensure_build_dir:
	@mkdir -p $(BUILD_DIR)

clean:
	@echo "Cleaning build directory..."
	rm -rf $(BUILD_DIR)/*.bin

clear:
	@echo "Clearing extra files..."
	rm -rf ${SRC_DIR}/boot boot

run: build
	@echo "Running project..."
	$(QEMU) -drive file=$(BUILD_DIR)/main.bin,format=raw
	@echo "Project finished running."
