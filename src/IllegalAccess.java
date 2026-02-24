public class IllegalAccess {
  public static void main(String[] args) {
    try {
      throw new IllegalAccessErrorError("This is a simulated illagal access error.");
    } catch (InternalError e) {
      e.printStackTrace();
    }
  }
}
