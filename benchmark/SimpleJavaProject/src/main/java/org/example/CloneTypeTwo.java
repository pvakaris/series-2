public class Clone_t2c1 {
    
    // sum two numbers
    public static int sum(int i, int j) {
        return i + j;
    }

    // subtract two numbers
    public static int subtract(int i, int j) {
        return i - j;
    }

    // calculate factorial of a number
    public static int calcFactorial(int arg){
        if (arg <= 1)
            return 1;
        else
            return arg * factorial(arg - 1);
    }

    // calculate i-th member of fibonachi sequence
    public static int clacFib(int arg){
        if (arg < 1)
            return -1;
        int a = 1;
        int b = 1;
        for(int i = 1; i < arg; i++){
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

public class Clone_t2c2 {
    
    public static int sum(int i, int j) 
    {
        return i + j;
    }

    public static int subtract(int i, int j) 
    {
        return i - j;
    }

    public static int calcFactorial(int arg)
    {
        if (arg <= 1)
            return 1;
        else
            return arg * factorial(arg - 1);
    }

    public static int clacFib(int arg)
    {
        if (arg < 1)
            return -1;
        int a = 1;
        int b = 1;
        for(int i = 1; i < arg; i++){
            int tmp = b;
            b = a + b;
            a = tmp;
        }
        return a;
    }

    public static int summ(int n)
    {
        if (n < 0)
            return 0;
        int s = 0;
        for(int i = 0; i <= n; i++){
            s += i;
        }
        return s;
    }
}

public class Clone_t2c3 {
    public static int sum(int i, int j) { return i + j; }
    public static int subtract(int i, int j) { return i - j; }
    public static int calcFactorial(int arg){
        if (arg <= 1) return 1;
        else return arg * factorial(arg - 1);}
    public static int clacFib(int arg){
        if (arg < 1) return -1;
        int a = 1;
        int b = 1;
        for(int i = 1; i < arg; i++){int tmp = b;b = a + b;a = tmp;}
        return a;
    }
    public static int summ(int n)
    {
        if (n < 0) return 0;
        int s = 0;
        for(int i = 0; i <= n; i++) s += i;
        return s;
    }
}