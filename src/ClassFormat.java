public class ClassFormat {
  public static void main(String[] args) {
    try {
      throw new ClassFormatError("This is a simulated class format error.");
    } catch (InternalError e) {
      e.printStackTrace();
    }
  }
}
