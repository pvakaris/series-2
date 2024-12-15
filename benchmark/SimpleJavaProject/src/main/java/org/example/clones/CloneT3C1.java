package org.example.clones;

public class CloneT3C1 {

    // Sum two numbers
    public static int sum(int i, int j) {
        return i + j;
    }

    // Subtract two numbers
    public static int subtract(int i, int j) {
        return i - j;
    }

    // Calculate factorial of a number
    public static int calcFactorial(int arg) {
        if (arg <= 1)
            return 1;
        else
            return arg * calcFactorial(arg - 1);
    }

    // Calculate i-th member of the Fibonacci sequence
    public static int calcFib(int arg) {
        if (arg < 1)
            return -1;
        int a = 1;
        int b = 1;
        for(int i = 1; i < arg; i++){
            int tmp = b;
            b = a + b;
            b = a + b;
            a = tmp;
        }
        return a;
    }

    // Calculate sum of all numbers from 1 to n
    public static int summ(int n) {
        int s = 0;
        for(int i = 0; i <= n; i++) {
            s += i;
        }
        return s;
    }
}
