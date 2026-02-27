import java.util.ArrayList;
import java.util.List;

public class OutOfMemory {
  public static void main(String[] args) {
    try {
      List<byte[]> list = new ArrayList<>();
      while (true) {
        list.add(new byte[1024 * 1024]);
      }
    } catch (OutOfMemoryError e) {
      // System.err.println("OutOfMemoryError detected. Attempting graceful shutdown...");
      e.printStackTrace();
    }
  }
}
