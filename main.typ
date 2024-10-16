#set page(paper: "us-letter")
#set heading(numbering: "1.1.")
#set figure(numbering: "1")

#show strong: set text(weight: 900)  // Songti SC 700 不够粗
#show heading: set text(weight: 900)

#set text(
  font: ("New Computer Modern", "FZKai-Z03S")
)

#import "@preview/codelst:2.0.0": sourcecode
#show raw.where(block: true): it => {
  set text(size: 10pt)
  sourcecode(it)
}

// 这是注释
#figure(image("sjtu.png", width: 50%), numbering: none) \ \ \

#align(center, text(17pt)[
  Computer Architecture Lab01 \ \
  #table(
      columns: 2,
      stroke: none,
      rows: (2.5em),
      // align: (x, y) =>
      //   if x == 0 { right } else { left },
      align: (right, left),
      [Name:], [Junjie Fang (Florian)],
      [Student ID:], [521260910018],
      [Date:], [#datetime.today().display()],
    )
])

#pagebreak()

#set page(header: align(right)[
  DB Lab1 Report - Junjie FANG
], numbering: "1")

#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}

// [lib]
#import "@preview/tablem:0.1.0": tablem

#let three-line-table = tablem.with(
  render: (columns: auto, ..args) => {
    table(
      columns: columns,
      stroke: none,
      align: center + horizon,
      table.hline(y: 0),
      table.hline(y: 1, stroke: .5pt),
      table.hline(y: 4, stroke: .5pt),
      table.hline(y: 7, stroke: .5pt),
      ..args,
      table.hline(),
    )
  }
)

#outline(indent: 1.5em)

#set text(12pt)
#show heading.where(level: 1): it => {
  it.body
}
#set list(indent: 0.8em)

// [正文]


= 练习 0

*1. 删除所有编译程序*

```
clean:
	-rm -rf core *.o *~ "#"*"#" Makefile.bak $(BINARIES) *.dSYM
```

*2. 编译的所有程序*

```
BINARIES=$(VECTOR_PROG) $(BIT_OPS_PROG) $(LFSR_PROG)

all: $(BINARIES)
```

*3. 当前使用的编译器*

编译器和链接器均为 `gcc`，依据:

```
CC=gcc
LD=gcc
```

*4. C 标准*

使用的是 C99 标准，依据：

```
CFLAGS=-ggdb -Wall -std=c99
```

*5. 引用变量*

使用 `$(FOO)` 引用 `FOO` 变量.

*6. Darwin 指代的系统*

指的是 macOS 系统. 因为 macOS 是基于 Darwin 内核的.

```sh
speit-arch-lab02 λ uname -a
Darwin floriandeMacBook-Air.local 23.5.0 Darwin Kernel Version 23.5.0: Wed May  1 20:16:51 PDT 2024; root:xnu-10063.121.3~5/RELEASE_ARM64_T8103 arm64
```

*7. 创建 `lfsr` 程序的行*

```
$(LFSR_PROG): $(LFSR_OBJS)
	$(CC) $(CFLAGS) -g -o $(LFSR_PROG) $(LFSR_OBJS) $(LDFLAGS)
```

= 练习 1  

@c1 按要求完成了代码.

= 练习 2

代码见 @c2. 通过右移求异或并在最低位对 $1$ 求与即可得到生成位的值。

= 练习 3

== Explanation for bad new function

在 `bad_vector_new()` 函数中，指针 `retval` 指向了一个局部变量 `v`，这个变量存储在栈空间上，当函数返回时会自动销毁，所以指针指向了一个无效的内存地址。

`also_bad_vector_new()` 函数则返回了一个值，返回后无法清理 `size` 和 `data` 指针本身所占空间。相比之下，返回指针对于内存管理更友好，这将 `vector_t` 内部变量存储在堆上，可以清理该实例所占所有空间。

这就类似于 C++ 构造函数中的 `new` 操作符，工程中偏向使用 `new` 一个 instance 而不是使用栈上空间。

= 附录

== 练习 1 代码 <c1>

```c
#include "bit_ops.h"
#include <stdio.h>

// Return the nth bit of x.
// Assume 0 <= n <= 31
unsigned get_bit(unsigned x, unsigned n) {
    // YOUR CODE HERE
    // Returning -1 is a placeholder (it makes
    // no sense, because get_bit only returns
    // 0 or 1)
    return (x >> n) & 1u;
}
// Set the nth bit of the value of x to v.
// Assume 0 <= n <= 31, and v is 0 or 1
void set_bit(unsigned* x, unsigned n, unsigned v) {
    // YOUR CODE HERE
    *x = (*x & ~(1u << n)) | (v << n);
}
// Flip the nth bit of the value of x.
// Assume 0 <= n <= 31
void flip_bit(unsigned* x, unsigned n) {
    // YOUR CODE HERE
    *x ^= (1u << n);
}
```

*输出*:

```
peit-arch-lab02 λ ./bit_ops 

Testing get_bit()

get_bit(0x0000004e,0): 0x00000000, correct
get_bit(0x0000004e,1): 0x00000001, correct
get_bit(0x0000004e,5): 0x00000000, correct
get_bit(0x0000001b,3): 0x00000001, correct
get_bit(0x0000001b,2): 0x00000000, correct
get_bit(0x0000001b,9): 0x00000000, correct

Testing set_bit()

set_bit(0x0000004e,2,0): 0x0000004a, correct
set_bit(0x0000006d,0,0): 0x0000006c, correct
set_bit(0x0000004e,2,1): 0x0000004e, correct
set_bit(0x0000006d,0,1): 0x0000006d, correct
set_bit(0x0000004e,9,0): 0x0000004e, correct
set_bit(0x0000006d,4,0): 0x0000006d, correct
set_bit(0x0000004e,9,1): 0x0000024e, correct
set_bit(0x0000006d,7,1): 0x000000ed, correct

Testing flip_bit()

flip_bit(0x0000004e,0): 0x0000004f, correct
flip_bit(0x0000004e,1): 0x0000004c, correct
flip_bit(0x0000004e,2): 0x0000004a, correct
flip_bit(0x0000004e,5): 0x0000006e, correct
flip_bit(0x0000004e,9): 0x0000024e, correct
```

== 练习 2 代码 <c2>

```c
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "lfsr.h"

void lfsr_calculate(uint16_t* reg) {
    /* YOUR CODE HERE */
    uint16_t bit = (*reg >> 0) ^ (*reg >> 2) ^ (*reg >> 3) ^ (*reg >> 5);
    *reg = (*reg >> 1) | (bit << 15);
}
```

*输出*:

```
speit-arch-lab02 λ make lfsr && ./lfsr
gcc -c -ggdb -Wall -std=c99 lfsr.c
gcc -ggdb -Wall -std=c99 -g -o lfsr lfsr.o test_lfsr.o 
My number is: 1
My number is: 5185
My number is: 38801
My number is: 52819
My number is: 21116
My number is: 54726
My number is: 26552
My number is: 46916
My number is: 41728
My number is: 26004
My number is: 62850
My number is: 40625
My number is: 647
My number is: 12837
My number is: 7043
My number is: 26003
My number is: 35845
My number is: 61398
My number is: 42863
My number is: 57133
My number is: 59156
My number is: 13312
My number is: 16285
 ... etc etc ... 
Got 65535 numbers before cycling!
Congratulations! It works!
```
