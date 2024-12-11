package org.example.clones;

public class CalculatorAdvanced {
    
    // sum two numbers
    public static int add(int a, int b) {
        return a + b;
    }

    // subtract two numbers
    public static int subtract(int a, int b) {
        return a - b;
    }

    // calculate factorial of a number
    public static int factorial(int n){
        if (n <= 1)
            return 1;
        else
            return n * factorial(n - 1);
    }

    // calculate i-th member of fibonachi sequence
    public static int fib(int n){
        if (n < 1)
            return -1;
        int a = 1;
        int b = 1;
        for(int i = 1; i < n; i++){
            int tmp = b;
            b = a + b;
            a = tmp;
        }
        return a;
    }

    // calculate sum of all numbers from 1 to n
    public static int summ(int n){
        if (n < 0)
            return 0;
        int s = 0;
        for(int i = 0; i <= n; i++){
            s += i;
        }
        return s;
    }
}
