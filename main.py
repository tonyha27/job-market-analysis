# LAST MODIFIED: 9/11/2026 

import logging
import sys
from scraper import scrape_linkedin
from database import save_jobs

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s",
    stream=sys.stdout,
)

def main():

    logging.info("LinkedIn scraper started.")
    jobs = scrape_linkedin(1000, 3, False)
    logging.info("%d jobs scraped.", len(jobs))
    save_jobs(jobs)
    logging.info("Jobs saved to Azure SQL database.")

if __name__ == "__main__":
    try:
        main()
    except Exception:
        logging.exception("Scraper failed.")
        sys.exit(1)
