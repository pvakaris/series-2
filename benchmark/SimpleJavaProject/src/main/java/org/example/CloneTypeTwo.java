public class CloneTypeTwo {
    public static int doAdd(int x, int y) {
        return x + y;
    }

    public static int doSubtract(int x, int y) {
        return x - y;
    }
    
    public static int op1(int i1, int i2, int i3, int i4){
        int p1 = i1 + i2;
        int p2 = i1 - i2;
        int p3 = p1*p2;
        int p4 = i3/i4;
        int p5 = p4 - p3;
        return p5;
    }

    public static int op2(int i1, int i2, int i3, int i4){
        int p1 = i1 * i2;
        int p2 = i1 + i2;
        int p3 = p2 - p1;
        int p4 = i3 * i4;
        int p5 = i3 - i4;
        int p6 = i3 - 6*i4;
        int p7 = p1 + p2 + p3 + p4 + p5 + p6;
        return p7;
    }
}