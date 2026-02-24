public class UnsupportedClassVersion {
  public static void main(String[] args) {
    try {
      throw new UnsupportedClassVersionError("This is a simulated unsupported class version error.");
    } catch (InternalError e) {
      e.printStackTrace();
    }
  }
}
