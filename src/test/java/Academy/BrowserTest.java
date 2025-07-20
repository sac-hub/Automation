package Academy;

import static org.junit.Assert.assertEquals;

import org.junit.Assert;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;




public class BrowserTest {

	
	@Test
	public void getData()
	{
		System.out.println("Hello Guys UPDATED 12345678910");
		System.setProperty("webdriver.chrome.driver", "chromedriver.exe");
		ChromeOptions options = new ChromeOptions();
		options.addArguments("--start-maximized");

		WebDriver driver = new ChromeDriver(options);
		driver.get("https://simonwebapp.azurewebsites.net/webapp/");
		/*driver.get("http://localhost:8080/webapp/");*/
		String text =driver.findElement(By.cssSelector("h1")).getText();
		System.out.println(text);
		Assert.assertTrue(text.equalsIgnoreCase("Simon's Web page For Demonstration"));
		driver.close();
			
	}
}
