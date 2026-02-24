public class NoSuchField {
  public static void main(String[] args) {
    try {
      throw new NoSuchFieldError("This is a simulated no such field error.");
    } catch (InternalError e) {
      e.printStackTrace();
    }
  }
}
