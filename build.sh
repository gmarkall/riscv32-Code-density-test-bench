#!/bin/bash

CFLAGS="-msave-restore -g -march=rv32imc -Os -std=gnu99 -fgcse-las -fdata-sections -ffunction-sections -mabi=ilp32 -mcmodel=medany -Wall -Werror -Wextra -pedantic -finline-growth-bias=2"
LDFLAGS="-Os -Wl,--gc-sections -Wl,--start-group -g -nostartfiles -Wl,--end-group"

BASEDIR=$(cd "`dirname \"$0\"`"; pwd)

SINGLE_FILE_BENCHMARKS="Agrassive_Compress Avoiding_Long_Branches_and_Multiplication_Peephole Improved_Switch_Table_Creation Improve_Inling Improving_Multiple_Uses_Of_Store_Zero Masking_To_Byte Prefer_Inline common_load_store_base_address_offset disable_loop_peeling memcpy"

TWO_FILE_BENCHMARKS="Improve_Use_Of_Temporaries Save_Restore_Library_Functions Small_Constant_Creation"

ODD_DIRS="lto_test_case"

function clean()
{
  echo "Cleaning...";
  cd $BASEDIR;
  rm -rf output;
}

function build_single_file_benchmark()
{
  echo "Building $1...";
  SRCDIR=$BASEDIR/$1;
  BUILDDIR=$BASEDIR/output/$1;
  mkdir -p $BUILDDIR;
  cd $BUILDDIR;
  riscv32-unknown-elf-gcc $CFLAGS -c $SRCDIR/main.c
  riscv32-unknown-elf-gcc $LDFLAGS main.o -o main.elf
  riscv32-unknown-elf-objdump -dr main.elf > disass.s
  cd $BASEDIR;
}

function build_two_file_benchmark()
{
  echo "Building $1...";
  SRCDIR=$BASEDIR/$1;
  BUILDDIR=$BASEDIR/output/$1;
  mkdir -p $BUILDDIR;
  cd $BUILDDIR;
  riscv32-unknown-elf-gcc $CFLAGS -c $SRCDIR/main.c
  riscv32-unknown-elf-gcc $CFLAGS -c $SRCDIR/funcs.c
  riscv32-unknown-elf-gcc $LDFLAGS main.o funcs.o -o main.elf
  riscv32-unknown-elf-objdump -dr main.elf > disass.s
  cd $BASEDIR;
}

function build_benchmarks()
{
  mkdir -p $BASEDIR/output;

  echo "Building single file benchmarks...";
  for d in $SINGLE_FILE_BENCHMARKS; do
    build_single_file_benchmark $d;
  done;

  echo "Building two file benchmarks...";
  for d in $TWO_FILE_BENCHMARKS; do
    build_two_file_benchmark $d;
  done;
}

function size_benchmark()
{
  BUILDDIR=$BASEDIR/output;
  cd $BUILDDIR;
  riscv32-unknown-elf-size --format=gnu $1/main.elf | grep main.elf
}

function size_benchmarks()
{
  for d in $SINGLE_FILE_BENCHMARKS $TWO_FILE_BENCHMARKS; do
    size_benchmark $d;
  done;
}

clean
build_benchmarks
size_benchmarks
