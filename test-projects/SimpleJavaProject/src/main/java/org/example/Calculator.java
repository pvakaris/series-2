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

    public Long subtract(Long a, Long b) {
        System.out.println(a);

        for(Long k = 0; k <= 5; k++) {
            System.out.println(k);
        }
        return  a - b;
    }

    public Long subtractCopy(Long a, Long b) {

        System.out.println(b);

        for(Long i = 0; i <= 5; i++) {
            System.out.println(i);
        }
        return  a - b;
    }

    public Long addReverse(Long a, Long b) {
        Long result = a + b;
        return result;
    }
}
