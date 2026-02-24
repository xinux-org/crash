public class NoClassDefFound {
  public static void main(String[] args) {
    try {
      throw new NoClassDefFoundError("This is a simulated no class def found error.");
    } catch (InternalError e) {
      e.printStackTrace();
    }
  }
}
