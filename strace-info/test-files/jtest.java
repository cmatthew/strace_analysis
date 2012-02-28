/*
 * simple java program to test with strace
 */

import java.io.RandomAccessFile;
import java.io.IOException;

/* test class to capture an strace  */
public class jtest {
	public static void main(String[] args) throws IOException {

		RandomAccessFile file = null;

        try {
			file = new RandomAccessFile("test-files/scratch.txt", "rw");

            String s;
            while ((s = file.readLine()) != null) {
                System.out.println(s);
            }
			file.writeBytes("Java'ed!\n");
        } catch (IOException e) {
			System.out.println(e.getMessage());
            if (file != null) {
                file.close();
            }

        }

	}
}

