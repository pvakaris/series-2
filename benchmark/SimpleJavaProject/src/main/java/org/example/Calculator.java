package org.example;

public class Calculator {
    public Long add(Long a, Long b) {
        Long result = a + b;
        return result;
                /*
            Comment
        Comment
            Comment
            ...
         */
    }

    public Long addReverse(Long a, Long b) {
        Long result = b + a;
        return result;
    }

    public Long subtract(Long a, Long b) {
        for(Long k = 0; k <= 5; k++) {
            a = a - b;
        }
        return a;
    }

    public Long subtractCopy(Long a, Long b) {
        for(Long i = 0; i <= 5; i++) {
            a -= b;
        }
        return  a;
    }

}