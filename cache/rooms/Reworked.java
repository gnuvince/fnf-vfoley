import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Random;

class Manor {
    int num_rooms;
    boolean[] lights;
    ArrayList<ArrayList<Integer>> neighbors;

    Manor(int num_rooms) {
        this.num_rooms = num_rooms;
        lights = new boolean[num_rooms];
        neighbors = new ArrayList<>();
        for (int i = 0; i < num_rooms; ++i) {
            lights[i] = true;
            neighbors.add(new ArrayList<>());
        }
        linkRooms();
    }

    void linkRooms() {
        Random rng = new Random(9999);

        for (int i = 0; i < num_rooms; ++i) {
            int numNeighbors = rng.nextInt(5) + 1;
            for (int j = 0; j < numNeighbors; ++j) {
                int neighbor = rng.nextInt(num_rooms);
                neighbors.get(i).add(j);
                neighbors.get(j).add(i);
            }
        }
    }

    void bfs() {
        boolean[] seen = new boolean[num_rooms];
        Queue<Integer> queue = new LinkedList<>();

        queue.add(0);
        while (!queue.isEmpty()) {
            int curr = queue.remove();
            seen[curr] = true;
            lights[curr] = !lights[curr];

            for (int neighbor: neighbors.get(curr)) {
                if (!seen[neighbor]) {
                    queue.add(neighbor);
                }
            }
        }
    }

    void flipLights() {
        for (int i = 0; i < num_rooms; ++i) {
            lights[i] = !lights[i];
        }
    }

    boolean lightAt(int room) {
        return lights[room];
    }
}

class Reworked {
    static int NUM_ROOMS = 1<<16;
    static int NUM_FLIPS = 101;

    public static void main(String[] args) {
        Manor manor = new Manor(NUM_ROOMS);
        System.out.println(manor.lightAt(0));
        for (int i = 0; i < NUM_FLIPS; ++i) {
            manor.bfs();
        }
        System.out.println(manor.lightAt(0));
    }

}
