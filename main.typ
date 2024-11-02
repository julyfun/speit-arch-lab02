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
  Computer Architecture Lab02 \ \
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

#counter(heading).update(0)

== 实验目的

本实验的目的是熟悉 Makefile 的编写和使用，Makefile 是一种用于自动化编译的工具，可以根据源文件的依赖关系自动编译出目标文件，从而简化了编译过程.

== 实验步骤

修改 `Makefile` 文件，使得 `make` 命令可以编译 `vector-test`、`bit_ops` 和 `lfsr` 三个程序.

== 实验分析

以上语法 `$(LFSR_PROG): $(LFSR_OBJS)` 表示 `lfsr` 程序依赖于 `lfsr.o` 和 `test_lfsr.o` 两个目标文件，`$(CC) $(CFLAGS) -g -o $(LFSR_PROG) $(LFSR_OBJS) $(LDFLAGS)` 表示使用 `gcc` 编译器编译 `lfsr` 程序，`-g` 选项表示生成调试信息，`-o` 选项表示输出文件名，`$(LFSR_PROG)` 表示输出文件名，`$(LDFLAGS)` 表示链接选项.

== 问题回答

*1. 删除所有编译程序*

```makefile
clean:
	-rm -rf core *.o *~ "#"*"#" Makefile.bak $(BINARIES) *.dSYM
```

*2. 编译的所有程序*

```makefile
BINARIES=$(VECTOR_PROG) $(BIT_OPS_PROG) $(LFSR_PROG)

all: $(BINARIES)
```

*3. 当前使用的编译器*

编译器和链接器均为 `gcc`，依据:

```makefile
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

```
speit-arch-lab02 λ uname -a
Darwin floriandeMacBook-Air.local 23.5.0 Darwin Kernel Version 23.5.0: Wed May  1 20:16:51 PDT 2024; root:xnu-10063.121.3~5/RELEASE_ARM64_T8103 arm64
```

*7. 创建 `lfsr` 程序的行*

```makefile
$(LFSR_PROG): $(LFSR_OBJS)
	$(CC) $(CFLAGS) -g -o $(LFSR_PROG) $(LFSR_OBJS) $(LDFLAGS)
```

#figure(image("image.png"))

= 练习 1  

== 实验目的

本实验的目的是熟悉位操作的基本操作，包括获取、设置和翻转位. 位操作是计算机系统中的基本操作，可以用于优化代码，提高代码的执行效率.

== 实验步骤

填写 `bit_ops.c` 文件中的三个函数 `get_bit`、`set_bit` 和 `flip_bit`，分别用于获取、设置和翻转位. 通过 `bit_ops.h` 文件中的函数声明，将这三个函数导出. 在 `bit_ops.c` 文件中，使用位操作实现这三个函数.

== 实验分析

`get_bit` 函数通过右移和与操作获取指定位的值，`set_bit` 函数通过与和或操作设置指定位的值，`flip_bit` 函数通过异或操作翻转指定位的值.

== 问题回答

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

#figure(image("image copy.png", height: 50%))

= 练习 2

== 实验目的

本实验的目的是熟悉线性反馈移位寄存器（LFSR）的基本操作，包括计算 LFSR 的下一个状态. LFSR 是一种伪随机数生成器，通过移位和异或操作生成下一个状态. 通过实现 `lfsr_calculate` 函数，可以计算 LFSR 的下一个状态.

== 实验步骤

填写 `lfsr.c` 文件中的 `lfsr_calculate` 函数，用于计算 LFSR 的下一个状态. 通过 `lfsr.h` 文件中的函数声明，将这个函数导出. 在 `lfsr.c` 文件中，使用位操作实现这个函数. 在 `test_lfsr.c` 文件中，使用 `lfsr_calculate` 函数测试 LFSR 的计算结果. 通过 `make lfsr` 命令编译 `lfsr` 程序，通过 `./lfsr` 命令运行 `lfsr` 程序，查看测试结果. 如果测试通过，输出 `Congratulations! It works!`. 

== 实验分析

`lfsr_calculate` 函数通过右移和异或操作计算 LFSR 的下一个状态. 通过右移操作获取最低位的值，通过异或操作计算生成位的值，通过左移和或操作设置下一个状态.

通过右移求异或并在最低位对 $1$ 求与即可得到生成位的值.

== 问题回答

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

#figure(image("image copy 2.png", height: 50%))

= 练习 3

== 实验目的

本实验的目的是熟悉内存管理的基本操作，包括创建、获取、设置和删除内存. 通过实现 `vector_new`、`vector_get`、`vector_set` 和 `vector_delete` 函数，可以创建、获取、设置和删除向量. 向量是一种动态数组，可以根据需要动态增长或缩小. 通过实现这四个函数，可以实现向量的基本操作. 

== 实验步骤

+ 填写 `vector.c` 文件中的 `vector_new`、`vector_get`、`vector_set` 和 `vector_delete` 函数，用于创建、获取、设置和删除向量. 
+ 通过 `vector.h` 文件中的函数声明，将这四个函数导出. 在 `vector.c` 文件中，使用内存管理实现这四个函数. 在 `vector-test.c` 文件中，使用这四个函数测试向量的基本操作.
+ 通过 `make vector-test` 命令编译 `vector-test` 程序，通过 `./vector-test` 命令运行 `vector-test` 程序，查看测试结果. 如果测试通过，输出 `Test complete.`.

== 实验分析

`vector_new` 函数通过 `malloc` 函数分配内存空间，`vector_get` 函数通过数组下标获取向量的值，`vector_set` 函数通过数组下标设置向量的值，`vector_delete` 函数通过 `free` 函数释放内存空间.

== 问题回答

在 `bad_vector_new()` 函数中，指针 `retval` 指向了一个局部变量 `v`，这个变量存储在栈空间上，当函数返回时会自动销毁，所以指针指向了一个无效的内存地址.

`also_bad_vector_new()` 函数则返回了一个值，返回后无法清理 `size` 和 `data` 指针本身所占空间。相比之下，返回指针对于内存管理更友好，这将 `vector_t` 内部变量存储在堆上，可以清理该实例所占所有空间.

这就类似于 C++ 构造函数中的 `new` 操作符，工程中偏向使用 `new` 一个 instance 而不是使用栈上空间.

`vector.c`:

```c
/* Include the system headers we need */
#include <stdio.h>
#include <stdlib.h>

/* Include our header */
#include "vector.h"

/* Define what our struct is */
struct vector_t {
    size_t size;
    int* data;
};

/* Utility function to handle allocation failures. In this
   case we print a message and exit. */
static void allocation_failed() {
    fprintf(stderr, "Out of memory.\n");
    exit(1);
}

/* Bad example of how to create a new vector */
vector_t* bad_vector_new() {
    /* Create the vector and a pointer to it */
    vector_t *retval, v;
    retval = &v;

    /* Initialize attributes */
    retval->size = 1;
    retval->data = malloc(sizeof(int));
    if (retval->data == NULL) {
        allocation_failed();
    }

    retval->data[0] = 0;
    return retval;
}

/* Another suboptimal way of creating a vector */
vector_t also_bad_vector_new() {
    /* Create the vector */
    vector_t v;

    /* Initialize attributes */
    v.size = 1;
    v.data = malloc(sizeof(int));
    if (v.data == NULL) {
        allocation_failed();
    }
    v.data[1] = 0;
    return v;
}

/* Create a new vector with a size (length) of 1
   and set its single component to zero... the
   RIGHT WAY */
vector_t* vector_new() {
    /* Declare what this function will return */
    vector_t* retval;

    /* First, we need to allocate memory on the heap for the struct */
    retval = (vector_t*)malloc(sizeof(vector_t));

    /* Check our return value to make sure we got memory */
    if (retval == NULL) {
        allocation_failed();
    }

    /* Now we need to initialize our data.
       Since retval->data should be able to dynamically grow,
       what do you need to do? */
    retval->size = 1;
    retval->data = (int*)malloc(sizeof(int) * retval->size);

    /* Check the data attribute of our vector to make sure we got memory */
    if (retval->data == NULL) {
        free(retval); //Why is this line necessary?
        allocation_failed();
    }

    /* Complete the initialization by setting the single component to zero */
    /* YOUR CODE HERE */ retval->data[0] = 0;

    /* and return... */
    return retval;
}

/* Return the value at the specified location/component "loc" of the vector */
int vector_get(vector_t* v, size_t loc) {
    /* If we are passed a NULL pointer for our vector, complain about it and exit. */
    if (v == NULL) {
        fprintf(stderr, "vector_get: passed a NULL vector.\n");
        abort();
    }

    /* If the requested location is higher than we have allocated, return 0.
     * Otherwise, return what is in the passed location.
     */
    if (loc < v->size) {
        return v->data[loc];
    } else {
        return 0;
    }
}

/* Free up the memory allocated for the passed vector.
   Remember, you need to free up ALL the memory that was allocated. */
void vector_delete(vector_t* v) {
    /* YOUR SOLUTION HERE */
    free(v->data);
    free(v);
    v = NULL;
}

/* Set a value in the vector. If the extra memory allocation fails, call
   allocation_failed(). */
void vector_set(vector_t* v, size_t loc, int value) {
    /* What do you need to do if the location is greater than the size we have
     * allocated?  Remember that unset locations should contain a value of 0.
     */
    /* YOUR SOLUTION HERE */
    if (loc < v->size) {
        v->data[loc] = value;
        return;
    }
    int* space = (int*)malloc((loc + 1) * sizeof(int));
    int i = 0;
    for (; i < v->size; i++) {
        space[i] = v->data[i];
    }
    for (; i < loc + 1; i++) {
        space[i] = 0;
    }
    free(v->data);
    v->size = loc + 1;
    v->data = space;
    v->data[loc] = value;
}
```

== 练习 3 测试 <c4>

#figure(image("image copy 3.png"))

`vector-test` 目标的 Makefile 如下：

```makefile
VECTOR_OBJS=vector.o vector-test.o
VECTOR_PROG=vector-test

...

$(VECTOR_PROG): $(VECTOR_OBJS)
	$(CC) $(CFLAGS) -g -o $(VECTOR_PROG) $(VECTOR_OBJS) $(LDFLAGS)
```
