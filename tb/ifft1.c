#include <stdio.h>
typedef struct complex
{
    int real;
    int imag;
} complex;

int main(void)
{
    complex input[8] = {{100, 0}, {10, 0}, {10, 0}, {10, 0}, {10, 0}, {10, 0}, {10, 0}, {10, 0}};

    complex butterfly1[8];
    butterfly1[0].real = ((input[0].real << 8) + (input[4].real << 8)) >> 8;
    butterfly1[0].imag = (((-input[0].imag) << 8) + ((-input[4].imag) << 8)) >> 8;
    butterfly1[1].real = ((input[0].real << 8) - (input[4].real << 8)) >> 8;
    butterfly1[1].imag = (((-input[0].imag) << 8) - ((-input[4].imag) << 8)) >> 8;
    butterfly1[2].real = ((input[2].real << 8) + (input[6].real << 8)) >> 8;
    butterfly1[2].imag = (((-input[2].imag) << 8) + ((-input[6].imag) << 8)) >> 8;
    butterfly1[3].real = ((input[2].real << 8) - (input[6].real << 8)) >> 8;
    butterfly1[3].imag = (((-input[2].imag) << 8) - ((-input[6].imag) << 8)) >> 8;
    butterfly1[4].real = ((input[1].real << 8) + (input[5].real << 8)) >> 8;
    butterfly1[4].imag = (((-input[1].imag) << 8) + ((-input[5].imag) << 8)) >> 8;
    butterfly1[5].real = ((input[1].real << 8) - (input[5].real << 8)) >> 8;
    butterfly1[5].imag = (((-input[1].imag) << 8) - ((-input[5].imag) << 8)) >> 8;
    butterfly1[6].real = ((input[3].real << 8) + (input[7].real << 8)) >> 8;
    butterfly1[6].imag = (((-input[3].imag) << 8) + ((-input[7].imag) << 8)) >> 8;
    butterfly1[7].real = ((input[3].real << 8) - (input[7].real << 8)) >> 8;
    butterfly1[7].imag = (((-input[3].imag) << 8) - ((-input[7].imag) << 8)) >> 8;
    complex butterfly2[8];
    butterfly2[0].real = ((butterfly1[0].real << 8) + (butterfly1[2].real << 8)) >> 8;
    butterfly2[0].imag = ((butterfly1[0].imag << 8) + (butterfly1[2].imag << 8)) >> 8;
    butterfly2[1].real = ((butterfly1[1].real << 8) + (butterfly1[3].imag << 8)) >> 8;
    butterfly2[1].imag = ((butterfly1[1].imag << 8) - (butterfly1[3].real << 8)) >> 8;
    butterfly2[2].real = ((butterfly1[0].real << 8) - (butterfly1[2].real << 8)) >> 8;
    butterfly2[2].imag = ((butterfly1[0].imag << 8) - (butterfly1[2].imag << 8)) >> 8;
    butterfly2[3].real = ((butterfly1[1].real << 8) - (butterfly1[3].imag << 8)) >> 8;
    butterfly2[3].imag = ((butterfly1[1].imag << 8) + (butterfly1[3].real << 8)) >> 8;
    butterfly2[4].real = ((butterfly1[4].real << 8) + (butterfly1[6].real << 8)) >> 8;
    butterfly2[4].imag = ((butterfly1[4].imag << 8) + (butterfly1[6].imag << 8)) >> 8;
    butterfly2[5].real = ((butterfly1[5].real << 8) + (butterfly1[7].imag << 8)) >> 8;
    butterfly2[5].imag = ((butterfly1[5].imag << 8) - (butterfly1[7].real << 8)) >> 8;
    butterfly2[6].real = ((butterfly1[4].real << 8) - (butterfly1[6].real << 8)) >> 8;
    butterfly2[6].imag = ((butterfly1[4].imag << 8) - (butterfly1[6].imag << 8)) >> 8;
    butterfly2[7].real = ((butterfly1[5].real << 8) - (butterfly1[7].imag << 8)) >> 8;
    butterfly2[7].imag = ((butterfly1[5].imag << 8) + (butterfly1[7].real << 8)) >> 8;
    complex butterfly3[8];
    butterfly3[0].real = ((butterfly2[0].real << 8) + (butterfly2[4].real << 8)) >> 8;
    butterfly3[0].imag = (-((butterfly2[0].imag << 8) + (butterfly2[4].imag << 8)) >> 8);
    butterfly3[1].real = ((butterfly2[1].real << 8) + butterfly2[5].real * 181 + butterfly2[5].imag * 181) >> 8;
    butterfly3[1].imag = (-((butterfly2[1].imag << 8) + butterfly2[5].imag * 181 - butterfly2[5].real * 181) >> 8);
    butterfly3[2].real = ((butterfly2[2].real << 8) + (butterfly2[6].real << 8)) >> 8;
    butterfly3[2].imag = (-((butterfly2[2].imag << 8) + (butterfly2[6].imag << 8)) >> 8);
    butterfly3[3].real = ((butterfly2[3].real << 8) - butterfly2[7].real * 181 + butterfly2[7].imag * 181) >> 8;
    butterfly3[3].imag = (-((butterfly2[3].imag << 8) - butterfly2[7].imag * 181 - butterfly2[7].real * 181) >> 8);
    butterfly3[4].real = ((butterfly2[0].real << 8) - (butterfly2[4].real << 8)) >> 8;
    butterfly3[4].imag = (-((butterfly2[0].imag << 8) - (butterfly2[4].imag << 8)) >> 8);
    butterfly3[5].real = ((butterfly2[1].real << 8) - butterfly2[5].real * 181 - butterfly2[5].imag * 181) >> 8;
    butterfly3[5].imag = (-((butterfly2[1].imag << 8) - butterfly2[5].imag * 181 + butterfly2[5].real * 181) >> 8);
    butterfly3[6].real = ((butterfly2[2].real << 8) - (butterfly2[6].real << 8)) >> 8;
    butterfly3[6].imag = (-((butterfly2[2].imag << 8) + (butterfly2[6].imag << 8)) >> 8);
    butterfly3[7].real = ((butterfly2[3].real << 8) + butterfly2[7].real * 181 - butterfly2[7].imag * 181) >> 8;
    butterfly3[7].imag = (-((butterfly2[3].imag << 8) + butterfly2[7].imag * 181 + butterfly2[7].real * 181) >> 8);
    for (int i = 0; i < 16; i++)
    {
        printf("%d\n", butterfly3[i]);
    }
}