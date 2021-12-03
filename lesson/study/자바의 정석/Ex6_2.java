package ObjectOrientedProgramming;


class Ex6_2 {
	public static void main(String[] args) {
		Tv t1 = new Tv();		//Tv t1; t1 = new Tv();를 한 문장으로 가능
		Tv t2 = new Tv();
		System.out.println("t1의 channel값은 " + t1.channel + "입니다.");
		System.out.println("t2의 channel값은 " + t2.channel + "입니다.");
		
		t1.channel = 7; 		//channel 값을 7로 한다.
		System.out.println("t1의 channel값을 7로 변경했습니다.");
		
		System.out.println("t1의 channel값은 "+ t1.channel + " 입니다.");
		System.out.println("t2의 channel값은 " + t2.channel + " 입니다.");
		
		Tv tvArr[] = new Tv[3]; //길이가 3인 Tv타입 참조변수 배열
		/*객체 배열을 생성하는 것은, 그저 객체를 다루기 위한 참조변수들이 만들어 진 것일 뿐 
		 * 아직 객체가 저장되지 않았다. 
		 * 객체 배열을 생성해서 객체 배열의 각 요소에 저장하는 것을 잊으면 안 된다. 
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
	


