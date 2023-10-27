from jobspy import scrape_jobs

jobs = scrape_jobs(
    site_name=["indeed"],
    search_term="computer science",
    location="Massachusetts",
    results_wanted=10,
    #offset=450,
    country_indeed='USA',  # only needed for indeed
    # proxy="socks5://jobspy:5a4vpWtj4EeJ2hoYzk@us.smartproxy.com:10001",
    #proxy="http://jobspy:5a4vpWtj4EeJ2hoYzk@us.smartproxy.com:10001",
    #proxy="https://jobspy:5a4vpWtj4EeJ2hoYzk@us.smartproxy.com:10001",
)
jobs.to_csv("jobs9.csv", index=False) # / to_xlsx