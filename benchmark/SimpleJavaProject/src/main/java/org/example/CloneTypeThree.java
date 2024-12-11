public class Clone_t3c1 {
    
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
        int s = 0;
        for(int i = 0; i <= n; i++){
            s += i;
        }
        return s;
    }
}

public class Clone_t3c2 {
    
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
        for(int i = 0; i < arg - 1; i++){
            int tmp = b;
            b = a + b;
            a = tmp;
        }
        return a;
    }

    // calculate sum of all numbers from 1 to n
    public static int summ(int n){
        int s = 0;
        for(int i = 0; i <= n; i++){
            s += i;
        }
        return s;
    }
}

public class Clone_t3c3 {
    
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
            b = a - b;
            a = tmp;
        }
        return a;
    }

    // calculate sum of all numbers from 1 to n
    public static int summ(int n){
        int s = 0;
        for(int i = 0; i <= n; i++){
            s -= i;
        }
        return s;
    }
}