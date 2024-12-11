package org.example;

public class Main {
    public static void main(String[] args) {
        System.out.println("Today we will perform calculations!");
        runCalculations();
    }

    private static void runCalculations() {
        var calculator = new Calculator();
        System.out.println(calculator.add((long) 1, (long) 2));

        System.out.println(CloneT1C1.fib(15));
    }
}