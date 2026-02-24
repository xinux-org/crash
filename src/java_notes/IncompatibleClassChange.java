public class IncompatibleClassChange {
  public static void main(String[] args) {
    try {
      throw new IncompatibleClassChangeError("This is a simulated incompatible class change error.");
    } catch (InternalError e) {
      e.printStackTrace();
    }
  }
}
