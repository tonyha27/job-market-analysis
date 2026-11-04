
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
    logging.info("Starting LinkedIn scraper")

    jobs = scrape_linkedin(10, 3, False)

    logging.info("Scraped %d jobs", len(jobs))

    save_jobs(jobs)

    logging.info("Jobs saved to Azure SQL Database")


if __name__ == "__main__":
    try:
        main()
    except Exception:
        logging.exception("Scraper failed")
        sys.exit(1)
