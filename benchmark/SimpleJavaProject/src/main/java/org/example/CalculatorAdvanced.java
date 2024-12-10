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
        int t3 = t2 - t1;
        int t4 = c * d;
        int t5 = c - d;
        int t6 = c - 6*d;
        int t7 = t1 + t2 + t3 + t4 + t5 + t6;
        return t7;
    }
}
