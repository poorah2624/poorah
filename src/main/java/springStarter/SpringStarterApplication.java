package springStarter;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class SpringStarterApplication {
	
	
	public static void main(String[] args)
	{
		SpringApplication.run(SpringStarterApplication.class, args);
	}

}
