public class ExceptionInInitializer {
  public static void main(String[] args) {
    try {
      throw new ExceptionInInitializerError("This is a simulated bootstrap method error.");
    } catch (InternalError e) {
      e.printStackTrace();
    }
  }
}
