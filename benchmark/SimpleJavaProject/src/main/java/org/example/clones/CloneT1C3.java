package org.example.clones;

public class CloneT1C3{

    /* This is a 
    multi-string comment,
    which checks
    how multi-string comments are processed*/
    public static int add(int a, int b) {
        return a + b; // Return statement
    }

    /* This is a 
    multi-string comment,
    which checks
    how multi-string comments are processed
    */
    public static int subtract(int a, int b) {
        return a - b; // Return statement
    }

    /*
    This is a 
    multi-string comment,
    which checks
    how multi-string comments are processed*/
    public static int factorial(int n) {
        if (n <= 1)
            return 1; // Return statement
        else
            return n * factorial(n - 1); // Return statement
    }

    /*
    This is a 
    multi-string comment,
    which checks
    how multi-string comments are processed
    */
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