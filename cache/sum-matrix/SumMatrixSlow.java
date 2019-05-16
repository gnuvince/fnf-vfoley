public class SumMatrixSlow {
    static int N = 4096;

    private static Double[] initMatrix() {
        Double[] m = new Double[N*N];
        for (int i = 0; i < m.length; ++i)
            m[i] = new Double(i % 2);
        return m;
    }

    private static void sumByRow(Double[] m) {
        long t1 = System.nanoTime();
        Double s = 0.0;
        for (int row = 0; row < N; ++row) {
            for (int col = 0; col < N; ++col) {
                s += m[row*N + col];
            }
        }
        long t2 = System.nanoTime();
        System.out.println("sumByRow (" + s + "): " + ((t2 - t1) / 1000) + " micro-seconds");
    }

    private static void sumByCol(Double[] m) {
        long t1 = System.nanoTime();
        Double s = 0.0;
        for (int row = 0; row < N; ++row) {
            for (int col = 0; col < N; ++col) {
                s += m[row + col*N];
            }
        }
        long t2 = System.nanoTime();
        System.out.println("sumByCol (" + s + "): " + ((t2 - t1) / 1000) + " micro-seconds");
    }

    public static void main(String[] args) {
        Double[] m = initMatrix();

        for (String arg: args) {
            for (int i = 0; i < arg.length(); ++i) {
                switch (arg.charAt(i)) {
                case 'r':
                    sumByRow(m);
                    break;
                case 'c':
                    sumByCol(m);
                    break;
                }
            }
        }
    }
}
