#include "uart.h"

int main(void)
{
	// foo();
	while (1) {
		const char hello[] = "Hello World\n";
		for (int i = 0; i < sizeof(hello); i++)
			uart_printChar(0, hello[i]);
	}
	return 0;
}