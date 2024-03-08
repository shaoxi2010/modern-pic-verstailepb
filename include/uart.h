/*
 * Copyright 2013, 2017, Jernej Kovacic
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software. If you wish to use our
 * Amazon FreeRTOS name, please do so in a fair use way that does not cause
 * confusion.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

/**
 * @file
 *
 * Declaration of public functions that handle
 * the board's UART controllers.
 *
 * @author Jernej Kovacic
 */

#ifndef _UART_H_
#define _UART_H_

#ifdef __cplusplus
extern "C" {
#endif
#include <types.h>

void uart_init(u8 nr);

void uart_printChar(u8 nr, char ch);

void uart_print(u8 nr, const char *str);

void uart_enableUart(u8 nr);

void uart_disableUart(u8 nr);

void uart_enableTx(u8 nr);

void uart_disableTx(u8 nr);

void uart_enableRx(u8 nr);

void uart_disableRx(u8 nr);

void uart_enableRxInterrupt(u8 nr);

void uart_disableRxInterrupt(u8 nr);

void uart_clearRxInterrupt(u8 nr);

char uart_readChar(u8 nr);

#ifdef __cplusplus
}
#endif

#endif /* _UART_H_ */
