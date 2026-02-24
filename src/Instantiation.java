public class Instantiation {
  public static void main(String[] args) {
    try {
      throw new InstantiationError("This is a simulated instantiation error.");
    } catch (InternalError e) {
      e.printStackTrace();
    }
  }
}
