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
        Long result = b + a; // Comment after the code on the same line
        return result;
    }

    public Long subtractFiveTimes(Long a, Long b) {
        for(int k = 0; k <= 5; k++) {
            a = a - b;
        }
        return a;
    }

    public Long subtractFiveTimesCopy(Long a, Long b) {
        // Comment single line
        for(int i = 0; i <= 5; i++) {
            a -= b;
        }
        return  a;
    }

}