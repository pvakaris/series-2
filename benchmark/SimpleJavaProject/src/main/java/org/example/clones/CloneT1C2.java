package org.example.clones;

public class CloneT1C2{

public static int form(int a, int b, int c, int d) {
    int f = a+b;
    int y = f+c;
    return y;
}

public class CalculatorAdvanced{

    public static int add(int a, int b) {
        return a + b; // Return statement
    }

    public static int subtract(int a, int b) {
        return a - b; // Return statement
    }

    public static int factorial(int n) {
        if (n <= 1)
            return 1; // Return statement
        else
            return n * factorial(n - 1); // Return statement
    }

    public static int fib(int n) {
        if (n < 1)
            return -1; // Return statement
        int a = 1;
        int b = 1;
        for(int i = 1; i < n; i++) {
            int tmp = b;
            b = a + b;
            a = tmp;
        }
        return a; // Return statement
    }

    public static int summ(int n) {
        if (n < 0)
            return 0; // Return statement
        int s = 0;
        for(int i = 0; i <= n; i++) {
            s += i;
        }
        return s; // Return statement
    }
}
}