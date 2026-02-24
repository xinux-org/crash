public class UnsatisfiedLink {
  public static void main(String[] args) {
    try {
      throw new UnsatisfiedLinkError("This is a simulated unsatisfied link error.");
    } catch (InternalError e) {
      e.printStackTrace();
    }
  }
}
