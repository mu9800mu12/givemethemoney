package ObjectOrientedProgramming;


class Ex6_2 {
	public static void main(String[] args) {
		Tv t1 = new Tv();		//Tv t1; t1 = new Tv();�� �� �������� ����
		Tv t2 = new Tv();
		System.out.println("t1�� channel���� " + t1.channel + "�Դϴ�.");
		System.out.println("t2�� channel���� " + t2.channel + "�Դϴ�.");
		
		t1.channel = 7; 		//channel ���� 7�� �Ѵ�.
		System.out.println("t1�� channel���� 7�� �����߽��ϴ�.");
		
		System.out.println("t1�� channel���� "+ t1.channel + " �Դϴ�.");
		System.out.println("t2�� channel���� " + t2.channel + " �Դϴ�.");
		
		Tv tvArr[] = new Tv[3]; //���̰� 3�� TvŸ�� �������� �迭
		/*��ü �迭�� �����ϴ� ����, ���� ��ü�� �ٷ�� ���� ������������ ����� �� ���� �� 
		 * ���� ��ü�� ������� �ʾҴ�. 
		 * ��ü �迭�� �����ؼ� ��ü �迭�� �� ��ҿ� �����ϴ� ���� ������ �� �ȴ�. 
		 */
		
		tvArr[0] = new Tv();
		tvArr[1] = new Tv();
		tvArr[2] = new Tv();
		
		Tv tvArr2[] = {new Tv(), new Tv(), new Tv()};
		
		Tv tvArr3[] = new Tv[100];
		for(int a = 0; a<tvArr3.length; a++) {
			tvArr3[a] = new Tv();
		}
		
		
		
		
	}
}
	


