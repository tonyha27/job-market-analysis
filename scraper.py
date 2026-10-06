import time 
from selenium import webdriver 
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait

def scrape_linkedin(num_jobs, delay, testing):
    
    '''Gathers jobs as a dataframe, scraped from LinkedIn'''

    try:
        # Initializing the webdriver.

        options = webdriver.ChromeOptions()
        if not testing:
            options.add_argument("--headless")
            options.add_argument("--no-sandbox")
            options.add_argument("--disable-dev-shm-usage")
            options.add_argument("--disable-gpu")

        driver = webdriver.Chrome(options=options)

        driver.set_window_size(1920, 1080)

        print("Set up Chrome", flush=True)

        # We start at the homepage since the site may force us to go there anyways.
        driver.get("https://www.linkedin.com/")

        print("Loaded page", flush=True)

        jobs = [] # We store our job listings here. It will be a list of dictionaries.

        time.sleep(delay) # The waiting time (in seconds) between requests. Ensure it is high enough to load pages. 

        # Click on "Jobs" button.
        driver.find_elements(By.XPATH, "//icon[@class='top-nav-link__icon flex h-3 w-3 flex-shrink-0 justify-center lazy-loaded']")[3].click()

        print("Clicked jobs button", flush=True)
        
        # Wait until the sign-in popup appears then clear it. If it doesn't appear after some time then continue on. 
        try:
            WebDriverWait(driver, 5).until(lambda d: d.find_element(By.XPATH, "//*[contains(text(), 'Sign in to view more jobs')]").is_displayed()) 
            time.sleep(delay)
            ActionChains(driver).send_keys(Keys.ESCAPE).perform() 
            print("Closed pop-up", flush=True)
            time.sleep(delay)
        except TimeoutException: 
            print("Pop-up did not appear", flush=True)
            pass
        
        # Input the value in the "keyword" variable inside in job search box.
        job_search_box = driver.find_element(By.XPATH, "//input[@aria-label='Search job titles or companies']")

        job_search_box.clear()

        time.sleep(delay)

        job_search_box.send_keys("Data OR Analyst")

        print("Inputted keyword", flush=True)

        time.sleep(delay)

        # Clear the location search box and input "Australia" then hit enter.
        location_search_box = driver.find_element(By.XPATH, "//input[@aria-label='Location']")
        location_search_box.clear()
        time.sleep(delay)
        location_search_box.send_keys("Australia")
        time.sleep(delay)
        location_search_box.send_keys(Keys.ENTER)
        time.sleep(delay) 

        print("Inputted location and press Enter", flush=True)

        # Scroll to the bottom of the page until it no longer loads.
        current_height = driver.execute_script("return document.body.scrollHeight") # Get current height of page.
        while True:
            driver.execute_script("window.scrollTo(0, document.body.scrollHeight)") # Scroll to the bottom to load.
            time.sleep(delay)
            new_height = driver.execute_script("return document.body.scrollHeight")
            if new_height == current_height: # Only possible when the page no longer loads, i.e., we have reached the end.
                break
            current_height = new_height

        # Click "See more jobs". Sometimes when clicking the button the page does not load. If this happens above a threshold then we stop clicking.  
        while True:
            driver.find_element(By.XPATH, "//button[@aria-label='See more jobs']").click() # Click the button.
            time.sleep(delay)
            new_height = driver.execute_script("return document.body.scrollHeight")
            if new_height == current_height:
                break
            current_height = new_height

        driver.execute_script("window.scrollTo(0, 0)")

        time.sleep(delay)

        # 'job_postings' contains all the jobs on the page.
        job_postings = driver.find_elements(By.XPATH, "//ul[@class='jobs-search__results-list']/*")
        
        # If fewer jobs are found than what is requested, tell the user. Otherwise take the first "num_jobs" from the page.
        if len(job_postings)<num_jobs:
            print("The requested number of jobs is {0} but the search found {1} jobs. The scraper will therefore return only {1} jobs.".format(num_jobs, len(job_postings)))
        else:
            job_postings = job_postings[:num_jobs]

        print("Scraping jobs...", flush=True)

        for job_posting in job_postings: # Going through each job on the page.

            print(f"Scraping job number {len(jobs)+1}", flush=True)

            # Wait until the sign-in popup appears then clear it. If it doesn't appear after some time then continue on. 
            if driver.find_element(By.XPATH, "//*[contains(text(), 'Sign in to view more jobs')]").is_displayed():
                time.sleep(delay)
                ActionChains(driver).send_keys(Keys.ESCAPE).perform() 
                time.sleep(delay)

            job_posting.click() # Click the job listing to open its contents. 

            time.sleep(delay)

            # Collect information on the job title, location, and description. These should always be available under each job.
            date = driver.find_element(By.XPATH, "//span[contains(@class, 'posted-time-ago__text')]").text
            title = driver.find_element(By.XPATH, "//h2[@class='top-card-layout__title font-sans text-lg papabear:text-xl font-bold leading-open text-color-text mb-0 topcard__title']").text
            company = driver.find_element(By.XPATH, "//a[@class='topcard__org-name-link topcard__flavor--black-link']").text
            location = driver.find_element(By.XPATH, "//span[@class='topcard__flavor topcard__flavor--bullet']").text
            industry = driver.find_element(By.XPATH, "//li[@class='description__job-criteria-item' and contains(., 'Industries')]").find_element(By.XPATH, './span').text
            employment_type = driver.find_element(By.XPATH, "//li[@class='description__job-criteria-item' and contains(., 'Employment type')]").find_element(By.XPATH, './span').text
            description = driver.find_element(By.XPATH, "//div[@class='description__text description__text--rich']/section/div").text
            try:
                salary = driver.find_element(By.XPATH, "//div[@class='salary compensation__salary']").text
            except NoSuchElementException:
                salary = 'Unavailable'

            # Add the job to 'jobs'.
            jobs.append({"Date": date,
                        "Title": title,
                        "Company Name": company,
                        "Location": location,
                        "Industry": industry,
                        "Employment type": employment_type,
                        "Description": description,
                        "Salary": salary})

            print(f"Scraped job number {len(jobs)}", flush=True)

            # Printing for debugging.
            if testing:
                print("Progress: {}".format(str(len(jobs)) + "/" + str(len(job_postings))))
                print("Date: {}".format(date))
                print("Title: {}".format(title))
                print("Company: {}".format(company))
                print("Location: {}".format(location))
                print("Industry: {}".format(industry))
                print("Employment type: {}".format(employment_type))
                print("Description: {}".format(description[:50] + '...'))
                print("Salary: {}".format(salary))
                print()
            
        return jobs

    finally:
            if driver:
                driver.quit()

