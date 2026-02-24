public class Assertion {
  // To get this error you should use it by this command:
  // ava -ea Assertion.java # Enables assertion
  public static void main(String[] args) {
    int number = -5;

    // This assertion checks if the number is non-negative.
    // If false, it throws an AssertionError.
    assert (number >= 0) : "number is negative: " + number;

    System.out.println("The number is " + number);
  }
}
