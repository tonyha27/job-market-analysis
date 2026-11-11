# LAST MODIFIED: 9/11/2026

import time
from selenium import webdriver # Allows Python to control web brosers programmatically.
from selenium.common.exceptions import NoSuchElementException # In case a piece of information is not available in a job listing. 
from selenium.common.exceptions import TimeoutException # Deal with pop-ups that may appear during scraping. 
from selenium.webdriver.common.action_chains import ActionChains # Allows multiple mouse and keyboard interactions to be combined in a sequence.
from selenium.webdriver.common.by import By # Locate browser elements using their XPATH.
from selenium.webdriver.common.keys import Keys # Allow keyboard interactions.
from selenium.webdriver.support.ui import WebDriverWait # Make Python wait until a specific condition is met. Used here to wait until the sign-in pop-up is clicked.  

# This function scrapes jobs from LinkedIn. The arguments and their descriptions are as follows.
# num_jobs: The number of jobs to scrape.
# delay: The delay in seconds between clicks. 
# debugging: A flag for debugging purposes.
def scrape_linkedin(num_jobs, delay, debugging):

    # Use try...finally to quit the driver session whether it suceeded or failed. This is to free up resources. 
    try:  

        # Configure the webdriver.
        options = webdriver.ChromeOptions()
        if not debugging:
            # Useful when running the program in cloud environments. 
            options.add_argument("--headless")
            options.add_argument("--no-sandbox")
            options.add_argument("--disable-dev-shm-usage")
            options.add_argument("--disable-gpu")
        driver = webdriver.Chrome(options=options)
        driver.set_window_size(1920, 1080)

        print("Chrome driver configured.", flush=True)

        # Go the the LinkedIn homepage and wait for it to load.
        driver.get("https://www.linkedin.com/") 
        time.sleep(10)

        print("LinkedIn page loaded.", flush=True)

        # Store our job listings as a list of dictionaries. 
        jobs = [] 

        # Click on the "Jobs" button.
        driver.find_elements(By.XPATH, "//icon[@class='top-nav-link__icon flex h-3 w-3 flex-shrink-0 justify-center lazy-loaded']")[3].click()

        print("Job button clicked", flush=True)
        
        # Wait until the sign-in popup appears then clear it. If it doesn't appear after some time then continue on. 
        try:
            WebDriverWait(driver, 300).until(lambda d: d.find_element(By.XPATH, "//*[contains(text(), 'Sign in to view more jobs')]").is_displayed()) 
            time.sleep(delay)
            ActionChains(driver).send_keys(Keys.ESCAPE).perform() 
            print("Closed pop-up", flush=True)
            time.sleep(delay)
        except TimeoutException: 
            print("Sign-in pop-up did not appear. Scraper will continue anyways.", flush=True)
            pass
        
        # Clear the job search box and input the text "Data OR Analyst"
        job_search_box = driver.find_element(By.XPATH, "//input[@aria-label='Search job titles or companies']")
        job_search_box.clear()
        time.sleep(delay)
        job_search_box.send_keys("Data OR Analyst")
        print("Keywords entered into job search field.", flush=True)
        time.sleep(delay)

        # Clear the location search box and input the text "Australia" then hit "ENTER" to load results.
        location_search_box = driver.find_element(By.XPATH, "//input[@aria-label='Location']")
        location_search_box.clear()
        time.sleep(delay)
        location_search_box.send_keys("Australia")
        time.sleep(delay)
        location_search_box.send_keys(Keys.ENTER)
        time.sleep(delay) 

        print("Location entered into location field. Results loaded.", flush=True)

        # Scroll to the bottom of the page until the text "See more jobs" appears.  
        current_height = driver.execute_script("return document.body.scrollHeight") # Get the current height of the page.
        while True:
            driver.execute_script("window.scrollTo(0, document.body.scrollHeight)") # Scroll to the bottom of the page and load new results.
            time.sleep(delay)
            new_height = driver.execute_script("return document.body.scrollHeight") # Get the new height of the page.
            if new_height == current_height: # When this happens the text "See more jobs" will have appeared, and we no longer need to scroll down.
                break
            current_height = new_height # Update the current height of the page. 

        print("Page scrolled down. \"See more jobs\" button appeared.", flush=True)

        # Keep clicking the "See more jobs" button until all jobs have been loaded.
        while True:
            driver.find_element(By.XPATH, "//button[@aria-label='See more jobs']").click() # Click the "See more jobs" button. 
            time.sleep(delay)
            new_height = driver.execute_script("return document.body.scrollHeight") 
            if new_height == current_height:
                break
            current_height = new_height

        print("All jobs loaded.", flush=True)

        # Scroll to the beginning of the page to start extracting information from job listings. 
        driver.execute_script("window.scrollTo(0, 0)") 
        time.sleep(delay)

        # Store all job listing elements in a list before processing them. 
        job_postings = driver.find_elements(By.XPATH, "//ul[@class='jobs-search__results-list']/*")
        
        # If the number of jobs is less than requested then notify the user.
        if len(job_postings) < num_jobs:
            print("The requested number of jobs is {0} but the search found {1} jobs. The scraper will therefore return only {1} jobs.".format(num_jobs, len(job_postings)))
        else:
            job_postings = job_postings[:num_jobs]

        print("Scraping jobs...", flush=True)

        # Loop through each individual job listing and extract the desired information.
        for job_posting in job_postings:

            # The sign-in popup may appear at this stage of the scraping. If so clear it. 
            if driver.find_element(By.XPATH, "//*[contains(text(), 'Sign in to view more jobs')]").is_displayed():
                time.sleep(delay)
                ActionChains(driver).send_keys(Keys.ESCAPE).perform() 
                time.sleep(delay)

            # Click on the job listing so we can scrape its information. 
            job_posting.click() 
            time.sleep(delay)

            # Collect information on the job listing. 
            date = driver.find_element(By.XPATH, "//span[contains(@class, 'posted-time-ago__text')]").text
            title = driver.find_element(By.XPATH, "//h2[@class='top-card-layout__title font-sans text-lg papabear:text-xl font-bold leading-open text-color-text mb-0 topcard__title']").text
            company = driver.find_element(By.XPATH, "//a[@class='topcard__org-name-link topcard__flavor--black-link']").text
            location = driver.find_element(By.XPATH, "//span[@class='topcard__flavor topcard__flavor--bullet']").text
            industry = driver.find_element(By.XPATH, "//li[@class='description__job-criteria-item' and contains(., 'Industries')]").find_element(By.XPATH, './span').text
            employment_type = driver.find_element(By.XPATH, "//li[@class='description__job-criteria-item' and contains(., 'Employment type')]").find_element(By.XPATH, './span').text
            seniority_level = driver.find_element(By.XPATH, "//li[@class='description__job-criteria-item' and contains(., 'Seniority level')]").find_element(By.XPATH, './span').text
            description = driver.find_element(By.XPATH, "//div[@class='description__text description__text--rich']/section/div").text
            try: 
                salary = driver.find_element(By.XPATH, "//div[@class='salary compensation__salary']").text
            except NoSuchElementException:
                salary = 'Unavailable'

            # Store the the information in a dicitonary and append it to our job list created towards the beginning. 
            jobs.append({"Date": date,
                        "Title": title,
                        "Company Name": company,
                        "Location": location,
                        "Industry": industry,
                        "Employment type": employment_type,
                        "Seniority level": seniority_level,
                        "Description": description,
                        "Salary": salary})
            
            print(f"Job number {len(jobs)} scraped.", flush=True)

            # Print for debugging purposes. 
            if debugging:
                print("Progress: {}".format(str(len(jobs)) + "/" + str(len(job_postings))))
                print("Date: {}".format(date))
                print("Title: {}".format(title))
                print("Company: {}".format(company))
                print("Location: {}".format(location))
                print("Industry: {}".format(industry))
                print("Employment type: {}".format(employment_type))
                print("Seniority level: {}".format(seniority_level))
                print("Description: {}".format(description[:50] + '...'))
                print("Salary: {}".format(salary))
            
        return jobs

    finally:
            if driver:
                driver.quit()