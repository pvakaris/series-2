package org.example.clones;

public class CloneT1C1{
    
    public static int add(int a, int b) {
        return a + b;
    }

    public static int subtract(int a, int b) {
        return a - b;
    }

    public static int factorial(int n) {
        if (n <= 1)
            return 1;
        else
            return n * factorial(n - 1);
    }

    public static int fib(int n) {
        if (n < 1)
            return -1;
        int a = 1;
        int b = 1;
        for(int i = 1; i < n; i++) {
            int tmp = b;
            b = a + b;
            a = tmp;
        }
        return a;
    }

    public static int summ(int n) {
        if (n < 0)
            return 0;
        int s = 0;
        for(int i = 0; i <= n; i++) {
            s += i;
        }
        return s;
    }
}
