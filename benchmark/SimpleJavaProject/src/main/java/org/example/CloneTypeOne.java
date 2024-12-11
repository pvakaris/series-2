public class Clone_t1c1 {
    
    public static int add(int a, int b) {
        return a + b;
    }

    public static int subtract(int a, int b) {
        return a - b;
    }

    public static int factorial(int n){
        if (n <= 1)
            return 1;
        else
            return n * factorial(n - 1);
    }

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

public class Clone_t1c2 {
    
    public static int add(int a, int b) {
        return a + b;//return statement
    }

    public static int subtract(int a, int b) {
        return a - b;//return statement
    }

    public static int factorial(int n){
        if (n <= 1)
            return 1;//return statement
        else
            return n * factorial(n - 1);//return statement
    }

    public static int fib(int n){
        if (n < 1)
            return -1;//return statement
        int a = 1;
        int b = 1;
        for(int i = 1; i < n; i++){
            int tmp = b;
            b = a + b;
            a = tmp;
        }
        return a;//return statement
    }

    public static int summ(int n){
        if (n < 0)
            return 0;//return statement
        int s = 0;
        for(int i = 0; i <= n; i++){
            s += i;
        }
        return s;//return statement
    }
}