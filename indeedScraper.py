from jobspy import scrape_jobs

jobs = scrape_jobs(
    site_name=["indeed"],
    search_term="computer science",
    location="New York",
    results_wanted=50,
    offset=2450,
    country_indeed='USA',
    #proxy="socks5://jobspy:5a4vpWtj4EeJ2hoYzk@us.smartproxy.com:10001",
    #proxy="http://jobspy:5a4vpWtj4EeJ2hoYzk@us.smartproxy.com:10001",
    #proxy="https://jobspy:5a4vpWtj4EeJ2hoYzk@us.smartproxy.com:10001",
    #proxy="http://jobspy:5a4vpWtj8EeJ2hoYzk@ca.smartproxy.com:20001",
)
#40
jobs.to_csv("jobs.csv", index=False) # / to_xlsx
print("Done")