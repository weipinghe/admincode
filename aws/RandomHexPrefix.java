// Written by Weiping He
// 2017/09/12
//
// AWS recommend using a hexadecimal hash as the prefix for S3 better performance
// https://aws.amazon.com/blogs/aws/amazon-s3-performance-tips-tricks-seattle-hiring-event/
//
// A four character hex hash partition set in a bucket or sub-bucket namespace could theoretically
// grow to support millions of operations per second and over a trillion unique keys.
// examplebucket/animations/232a-2013-26-05-15-00-00/cust1234234/animation1.obj
// examplebucket/animations/7b54-2013-26-05-15-00-00/cust3857422/animation2.obj
// examplebucket/videos/8761-2013-26-05-15-00-00/cust1248473/video3.mpg
// examplebucket/videos/2e4f-2013-26-05-15-00-01/cust1248473/video4.mpg
//
import java.util.Random;

public class RandomHexPrefix{
	static char[] chars = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};

	static String randomString(int length) {
	    StringBuilder stringBuilder = new StringBuilder();
	    for (int i = 0; i < length; i++) {
	        stringBuilder.append(chars[new Random().nextInt(chars.length)]);
	    }
	    return stringBuilder.toString();
	}

	public static void main(String[] args) {
		System.out.println("examplebucket/videos/" + randomString(4) + "-2013-26-05-15-00-00/cust1248473/video2.mpg" );
		System.out.println("examplebucket/videos/" + randomString(4) + "-2013-26-05-15-00-00/cust1248473/video3.mpg" );
		System.out.println("examplebucket/videos/" + randomString(4) + "-2013-26-05-15-00-01/cust1248473/video4.mpg" );
	}
}
