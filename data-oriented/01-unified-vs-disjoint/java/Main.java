import java.util.ArrayList;
import java.util.Scanner;
import java.io.BufferedReader;
import java.io.InputStreamReader;

interface Num {
    float toFloat();
}

class NumInt implements Num {
    int val;
    public NumInt(int v) {
        val = v;
    }

    public float toFloat() {
        return (float)val;
    }
}

class NumFloat implements Num {
    float val;
    public NumFloat(float v) {
        val = v;
    }

    public float toFloat() {
        return val;
    }
}

public class Main {
    static int ITERS = 16;

    public static void main(String[] args) {
        if (args[0].equals("oo")) {
            ooWay();
        } else if (args[0].equals("do")) {
            doWay();
        } else if (args[0].equals("array")) {
            arrayWay();
        }
    }

    static void ooWay() {
        ArrayList<Num> floats = new ArrayList<>();
        BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in));
        long top = System.nanoTime();

        try {
            String line = stdin.readLine();
            while (line != null) {
                try {
                    floats.add(new NumInt(Integer.parseInt(line)));
                } catch (Exception e1) {
                    try {
                        floats.add(new NumFloat(Float.parseFloat(line)));
                    } catch (Exception e2) {
                    }
                }
                line = stdin.readLine();
            }
        } catch (Exception e3) {
        }

        System.err.println("read time: " + humanReadableTime(System.nanoTime() - top));

        for (int t = 0; t < ITERS; ++t) {
            top = System.nanoTime();
            float sum = 0;
            for (Num f: floats) {
                sum += f.toFloat();
            }
            System.out.println("sum: " + sum);
            System.err.println("sum time: " + humanReadableTime(System.nanoTime() - top));
        }
    }

    static void doWay() {
        ArrayList<Integer> ints = new ArrayList<>();
        ArrayList<Float> floats = new ArrayList<>();

        BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in));
        long top = System.nanoTime();

        try {
            String line = stdin.readLine();
            while (line != null) {
                try {
                    ints.add(Integer.parseInt(line));
                } catch (Exception e1) {
                    try {
                        floats.add(Float.parseFloat(line));
                    } catch (Exception e2) {
                    }
                }
                line = stdin.readLine();
            }
        } catch (Exception e3) {
        }
        System.err.println("read time: " + humanReadableTime(System.nanoTime() - top));

        for (int t = 0; t < ITERS; ++t) {
            top = System.nanoTime();
            float sum = 0;
            for (int i: ints) {
                sum += i;
            }
            for (float f: floats) {
                sum += f;
            }
            System.out.println("sum: " + sum);
            System.err.println("sum time: " + humanReadableTime(System.nanoTime() - top));
        }
    }

    static void arrayWay() {
        int[] ints = new int[2000000];
        float[] floats = new float[2000000];
        int i = 0, j = 0;

        BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in));
        long top = System.nanoTime();
        try {
            String line = stdin.readLine();
            while (line != null) {
                try {
                    ints[i++] = Integer.parseInt(line);
                } catch (Exception e1) {
                    try {
                        floats[j++] = Float.parseFloat(line);
                    } catch (Exception e2) {
                    }
                }
                line = stdin.readLine();
            }
        } catch (Exception e3) {
        }
        System.err.println("read time: " + humanReadableTime(System.nanoTime() - top));

        for (int t = 0; t < ITERS; ++t) {
            top = System.nanoTime();
            float sum = 0;
            for (int x: ints) {
                sum += x;
            }
            for (float f: floats) {
                sum += f;
            }
            System.out.println("sum: " + sum);
            System.err.println("sum time: " + humanReadableTime(System.nanoTime() - top));
        }
    }

    static String humanReadableTime(long nano) {
        if (nano < 1000) {
            return nano + " ns";
        } else if (nano < 1000000) {
            double micro = nano / 1000.0;
            return micro + " us";
        } else if (nano < 1000000000) {
            double milli = nano / 1000000.0;
            return milli + " ms";
        } else {
            double sec = nano / 1000000000.0;
            return sec + " s";
        }
    }
}
