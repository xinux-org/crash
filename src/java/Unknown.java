public class Unknown {
  public static void main(String[] args) {
    try {
      throw new UnknownError("This is a simulated unknown error.");
    } catch (InternalError e) {
      e.printStackTrace();
    }
  }
}
