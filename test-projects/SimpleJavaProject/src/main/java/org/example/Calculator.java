package org.example;

public class Calculator {
    public static int add(int a, int b) {
        return a + b;
                /*
            Comment
        Comment
            Comment
            ...
         */
    }

    public static int addReverse(int a, int b) {
        return b + a;
        // Another comment
    }
}

public class CalculatorAdvanced {
    public static int add(int a, int b) {
        return a + b;
    }

    public static int subtract(int a, int b) {
        return a - b;
    }
    
    public static int formula1(int a, int b, int c, int d){
        int t1 = a + b;
        int t2 = a - b;
        int t3 = t1*t2;
        int t4 = c/d;
        int t5 = t4 - t3;
        return t5;
    }

    public static int formula2(int a, int b, int c, int d){
        int t1 = a * b;
        int t2 = a + b;
        int t3 = t2 - t3;
        int t4 = c * d;
        int t5 = c - d;
        int t6 = c - 6*d;
        int t7 = t1 + t2 + t3 + t4 + t5 + t6;
        return t7;
    }
}

public class CloneType2 {
    public static int doAdd(int x, int y) {
        return x + y;
    }

    public static int doSubtract(int x, int y) {
        return x - y;
    }
    
    public static int op1(int i1, int i2, int i3, int i4){
        int p1 = i1 + i2;
        int p2 = i1 - i2;
        int p3 = p1*p2;
        int p4 = i3/i4;
        int p5 = p4 - p3;
        return p5;
    }

    public static int op2(int i1, int i2, int i3, int i4){
        int p1 = i1 * i2;
        int p2 = i1 + i2;
        int p3 = p2 - p3;
        int p4 = i3 * i4;
        int p5 = i3 - i4;
        int p6 = i3 - 6*i4;
        int p7 = p1 + p2 + p3 + p4 + p5 + p6;
        return p7;
    }
}

public class CloneType3 {
    public static int doAdd(int x, int y) {
        return x + y;
    }

    public static int doSubtract(int x, int y) {
        return x - y;
    }

    public static int op1(int i1, int i2, int i3, int i4){
        int p1 = i1 + i2;
        int p2 = i1 - i2;
        int p3 = p1*p2;
        int p4 = i3/i4;
        int p5 = p4 - p3;
        return p5;
    }

    public static int op2(int i1, int i2, int i3, int i4){
        int p1 = i1 * i2;
        int p2 = i1 + i2;
        int p3 = p2 - p3;
        int p4 = i3 * i4;
        int p5 = i3 - i4;
        int p6 = i3 - 6*i4;
        int p7 = i1 + i2 + i3 + i4;
        int p8 = p1 + p2 + p3 + p4 + p5 + p6 + p7;
        return p8;
    }
}