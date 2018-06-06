import os
import datetime
import requests
import time

timestamp = datetime.datetime.now().time()
start = datetime.time(7, 01)
end = datetime.time(23, 30)
time_in_range = (start <= timestamp <= end)
SetModeOut = '/usr/local/bin/gpio mode 25 out'
SantaOff = '/usr/local/bin/gpio write 25 0'
SantaOn = '/usr/local/bin/gpio  write 25 1'

r = requests.get("http://api.wunderground.com/api/a43bf628ddbc159e/conditions/q/                                                                                        pws:KMNROGER2.json")
data = r.json()
KMNROGER2_current = data['current_observation']
windspeed = KMNROGER2_current['wind_mph']
windgust = KMNROGER2_current['wind_gust_mph']
print(windspeed)
print(windgust)
print(KMNROGER2_current)
if time_in_range == True:
  print('right timing')
  if windspeed < 15:
    print('Wind is not too strong now')
    if windgust < 15:
    os.system(SetModeOut)
    os.system(SantaOn)
    print('Perfect Time and Weather')
  print(windspeed)
  print(time_in_range)
    else:
      os.system(SetModeOut)
      os.system(SantaOff)
      print('Gusts are too stong')
  else:
    os.system(SetModeOut)
    os.system(SantaOff)
    print('Too Windy')
else:
  os.system(SetModeOut)
  os.system(SantaOff)
  print('Its the wrong time for this')
  print(windspeed)
  print(time_in_range)
