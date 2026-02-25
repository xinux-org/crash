public class InternalErr {
  public static void main(String[] args) {
    try {
      throw new InternalError("This is a simulated internal error", new RuntimeException("Underlying cause"));
    } catch (InternalError e) {
      e.printStackTrace();
    }
  }
}
