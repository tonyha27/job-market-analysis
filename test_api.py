import requests

url = 'https://italic-feels-taxi-merchant.trycloudflare.com/scrape'

response = requests.post(url)

print(response.status_code)
print(response.json())