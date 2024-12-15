package org.example.clones;

public class CloneT2C3 {
    
    public static int sum(int i, int j) {
        return i + j;
    }

    public static int subtract(int i, int j) {
        return i - j;
    }

    public static int calcFactorial(int arg) {
        if (arg <= 1) return 1;
        else return arg * calcFactorial(arg - 1);
    }

    public static int clacFib(int arg) {
        if (arg < 1) return -1;
        int a = 1;
        int b = 1;
        for (int i = 1; i < arg; i++) {
            int tmp = b;
            b = a + b;
            a = tmp;
        }
        return a;
    }

    public static int summ(int n) {
        if (n < 0) return 0;
        int s = 0;
        for (int i = 0; i <= n; i++) s += i;
        return s;
    }
}