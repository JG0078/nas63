#!/usr/bin/python3
print('hello world')

import requests
import json
import pprint


response = requests.get('http://192.168.1.100:8989/api/v3/history?apikey=3e00873e2f8047a4a541d8d11b439330') 
#json_data = json.loads(response.text)
jsonResponse = response.json()

#pprint.pprint(json_data)

# change the JSON string into a JSON object
#jsonObject = json.loads(jsonResponse)

# print the keys and values
#for key in jsonResponse:
#  value = jsonResponse[key]
  
pprint.pprint(jsonResponse.records.data[0])
