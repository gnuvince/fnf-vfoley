import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Random;
import java.util.Set;

class Room {
    boolean lightIsOn;
    LinkedList<Room> neighbors;

    Room() {
        lightIsOn = true;
        neighbors = new LinkedList<>();
    }

    void link(Room otherRoom) {
        neighbors.add(otherRoom);
    }
}

class Initial {
    static int NUM_ROOMS = 1<<16;
    static int NUM_FLIPS = 101;

    static Room createManor() {
        Random rng = new Random(9999);
        Room[] rooms = new Room[NUM_ROOMS];

        for (int i = 0; i < NUM_ROOMS; ++i) {
            rooms[i] = new Room();
        }

        for (int i = 0; i < NUM_ROOMS; ++i) {
            int numNeighbors = rng.nextInt(5) + 1;
            for (int j = 0; j < numNeighbors; ++j) {
                int neighbor = rng.nextInt(NUM_ROOMS);
                rooms[i].link(rooms[j]);
                rooms[j].link(rooms[i]);
            }
        }

        return rooms[0];
    }

    static void bfs(Room startRoom) {
        Set<Room> seen = new HashSet<>();
        Queue<Room> queue = new LinkedList<>();

        queue.add(startRoom);
        while (!queue.isEmpty()) {
            Room curr = queue.remove();
            curr.lightIsOn = !curr.lightIsOn;

            seen.add(curr);
            for (Room neighbor: curr.neighbors) {
                if (!seen.contains(neighbor)) {
                    queue.add(neighbor);
                }
            }
        }
    }

    public static void main(String[] args) {
        Room startRoom = createManor();
        System.out.println(startRoom.lightIsOn);
        for (int i = 0; i < NUM_FLIPS; ++i) {
            bfs(startRoom);
        }
        System.out.println(startRoom.lightIsOn);
    }
}
