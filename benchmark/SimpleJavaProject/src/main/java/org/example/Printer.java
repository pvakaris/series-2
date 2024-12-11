package org.example;

/*
    Simple Java class containing simple code clones of type I, II and III
 */
public class Printer {

    public void printTypeOneA() {
        String word = "Hello";
        System.out.println(word);
    }

    public void printTypeOneB() {
        String word = "Hello";
        System.out.println(word);

    }

    public void printTypeTwo() {
        var first = "world";
        var second = "world";
        System.out.println(first);
        System.out.println(second);
    }

    public void printTypeThreeA(String bword) {
        var aword = bword + " something";
        System.out.println(aword);
    }

    public void printTypeThreeB(String bword) {
        var aword = bword + " something" + " more";
        System.out.println(aword);
    }
}
