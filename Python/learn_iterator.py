#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# FILE: learn_iterator.py
# AUTHOR: haya14busa
# License: MIT license
#
#     Permission is hereby granted, free of charge, to any person obtaining
#     a copy of this software and associated documentation files (the
#     "Software"), to deal in the Software without restriction, including
#     without limitation the rights to use, copy, modify, merge, publish,
#     distribute, sublicense, and/or sell copies of the Software, and to
#     permit persons to whom the Software is furnished to do so, subject to
#     the following conditions:
#
#     The above copyright notice and this permission notice shall be included
#     in all copies or substantial portions of the Software.
#
#     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
#     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
#     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
#     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
#     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
#=============================================================================


class IterFibonacchi:
    def __init__(self, max=100):
        self.max = max

    def __iter__(self):
        self._a = 0
        self._b = 1
        return self

    def __next__(self):
        if self._a <= self.max:
            result = self._a
            self._a, self._b = self._b, self._a + self._b
            return result
        else:
            raise StopIteration

    @property
    def max(self):
        return self._max

    @max.setter
    def max(self, value):
        self._max = value


def main():
    fibo = IterFibonacchi(1000)
    fibo.max = 100
    print('==========')
    print('for loop')
    for i in fibo:
        print(i)

    print('==========')
    print('list access')
    print(list(fibo)[5])

    print('==========')
    print('iter() & next()')
    fibo2 = IterFibonacchi(100)
    i = iter(fibo2)
    print(next(i))  # -> 0
    print(next(i))  # -> 1
    print(next(i))  # -> 1
    print(next(i))  # -> 2
    print(next(i))  # -> 3

    print('==========')
    print('enumerate()')
    fibo3 = IterFibonacchi(1000)
    for i, fibo in enumerate(fibo3):
        print(str(i).ljust(2, ' ') + ' : ' + str(fibo))

if __name__ == '__main__':
    main()
