# GD32VF103をC言語でプログラミングするやつ (C-programming enabler for GD32VF103)

Sipeed Longan Nano などに使われている GD32VF103 向けのプログラムをC言語で書けるようにする。  
Enable to write programs for GD32VF103, which is used in Sipeed Longan Nano for example, in C.

## 使い方 / How to use

例として、Longan Nanoに載っているRGB LEDを点滅させるプログラム `ltika.c` のコンパイル方法を説明する。  
To illustrate, here is how to compile the program `ltika.c`, whick will blink the RGB LED on Longan Nano.

[JSLinux](https://bellard.org/jslinux/) の中の[「riscv64 / Fedora 33 (Linux) / Console」のもの](https://bellard.org/jslinux/vm.html?cpu=riscv64&url=fedora33-riscv.cfg&mem=256)を起動する。  
Launch the ["riscv64 / Fedora 33 (Linux) / Console" system](https://bellard.org/jslinux/vm.html?cpu=riscv64&url=fedora33-riscv.cfg&mem=256) on [JSLinux](https://bellard.org/jslinux/).

以下のファイルを仮想マシンに入れる。画面左下の矢印アイコンからファイルを入れることができる。  
Put these files to the virtual machine. You can use the icon with an arrow in the left bottom of the screen to put files.

* `risu.txt`
* `startup.s`
* `ltika.c`

以下のコマンドを実行し、ファイルをコンパイルする。  
Execute this command to compile files.

```
gcc -c -march=rv32imc -mabi=ilp32 -O2 startup.s
gcc -c -march=rv32imc -mabi=ilp32 -O2 ltika.c
```

以下のコマンドを実行し、ファイルをリンクする。  
Execute this command to link files.

```
ld -T risu.txt -o ltika.elf startup.o ltika.o
```

以下のコマンドを実行し、成果物をGD32VF103に書き込む用のデータに変換する。  
Execute this command to convert the builded program to data for programming to GD32VF103.

```
objcopy -O binary ltika.elf ltika.bin
```

以下のコマンドを実行し、変換したデータを仮想マシンから取り出す。  
Execute this command to take the converted data out from the virtual machine.

```
export_file ltika.bin
```

## ライセンス / License

他に指定が無いファイルは[MITライセンス](https://opensource.org/licenses/MIT)とする。  
Licensed under [The MIT License](https://opensource.org/licenses/MIT) unless otherwise specified.

以下のファイルは[CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/deed.ja)とする。  
These files are licensed under [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/):

* `risu.txt`
* `startup.s`
