public class Printer {
    

    public void printTypeOneA() {
        String word = new String("Hello");
        System.out.println(word);
    }

    public void printTypeOneB() {
        String word = new String("Hello");
        System.out.println(word);

    }

    public void printTypeTwo() {
        var first = new String("world");
        var second = new String("world");
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
