from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.window import WindowType # For Selenium 4+

# Initialize a Chrome WebDriver (ensure you have chromedriver installed and in your PATH)
driver = webdriver.Chrome()

# Open a new window and switch control to it (Selenium 4+)
driver.switch_to.new_window(WindowType.WINDOW)

# Navigate to a URL in the new window
driver.get("https://www.google.com")

# Perform actions in the new window (e.g., search)
search_box = driver.find_element(By.NAME, "q")
search_box.send_keys("Python programming")
search_box.submit()

# You can then switch back to the original window if needed
# original_window_handle = driver.window_handles[0]
# driver.switch_to.window(original_window_handle)

# Close the browser when done
driver.quit()