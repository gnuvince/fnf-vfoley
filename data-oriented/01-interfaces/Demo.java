import java.util.Arrays;
import java.util.Iterator;

class Demo {
    static private double iteratorAvg(Iterator<Double> it) {
        double sum = 0.0;
        int len = 0;
        while (it.hasNext()) {
            sum += it.next();
            len += 1;
        }
        return sum / len;
    }

    static private double arrayAvg(double[] it) {
        double sum = 0.0;
        for (double x: it) {
            sum += x;
        }
        return sum / it.length;
    }

    public static void main(String[] args) {
        int iterations = 1000;
        int capacity = 500000;
        long t1, t2;

        t1 = System.nanoTime();
        double[] array = new double[capacity];
        for (int i = 0; i < capacity; ++i) {
            double x = (double) (i % 3);
            array[i] = x;
        }
        t2 = System.nanoTime();
        System.out.println("Array initialization time: " + (t2 - t1) + " ns");

        // try {
        //     System.out.println("Press <Enter> to continue");
        //     System.in.read();
        // } catch (Exception e) {
        // }
        t1 = System.nanoTime();
        for (int i = 0; i < iterations; ++i) {
            iteratorAvg(Arrays.stream(array).iterator());
        }
        t2 = System.nanoTime();
        System.out.println("Iterator: " + (t2 - t1) + " ns");

        // try {
        //     System.out.println("Press <Enter> to continue");
        //     System.in.read();
        // } catch (Exception e) {
        // }
        t1 = System.nanoTime();
        for (int i = 0; i < iterations; ++i) {
            arrayAvg(array);
        }
        t2 = System.nanoTime();
        System.out.println("Array: " + (t2 - t1) + " ns");
    }
}
