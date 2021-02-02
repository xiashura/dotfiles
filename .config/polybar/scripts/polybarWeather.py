#!/bin/python

import sys
import requests
import json
import argparse

class Ids:
	pass
ids = Ids()
parser = argparse.ArgumentParser()
parser.add_argument(
    '-i',
    type=str,
    metavar='\tcityid: get your city id from the list at http://bulk.openweathermap.org/sample/',
    dest='city_id'
)
parser.add_argument(
    '-z',
    type=str,
    metavar='\tzipcode: is used with country_code',
    dest='zip_code'
)
parser.add_argument(
    '-c',
    type=str,
    metavar='\tcountrycode(lowerCase): tr,us,uk...',
    dest='country_code'
)
parser.add_argument(
    '-a',
    type=str,
    metavar='\tget your appid from: https://openweathermap.org/appid',
    dest='app_id'
)
parser.add_argument(
    '-t',
    type=str,
    metavar='\tOutput Type: Celcius, Fahrenheit, Kelvin',
    dest='o_type'
)
args = parser.parse_args(namespace=ids)

def correct_argument(string):
    if sys.version_info.major == 3:
        return string
    else:
        return string.encode('utf-8')

city_id_ = correct_argument(ids.city_id)
app_id_ = correct_argument(ids.app_id)
zip_code_ = correct_argument(ids.zip_code)
country_code_ = correct_argument(ids.country_code)
o_type_ = correct_argument(ids.o_type)

def getWeatherByCityID(c_id, a_id=app_id_):
	r = requests.get('http://api.openweathermap.org/data/2.5/weather?id='+ city_id_ + '&appid=' + app_id_)
	return r.json()

def getWeatherByZipCode(z_code, c_code, a_id=app_id_):
	r = requests.get('http://api.openweathermap.org/data/2.5/weather?zip='+ z_code + ',' + c_code + '&appid=' + app_id_)
	return r.json()

def degreeType(temp, d_type):
	if d_type == 'Celcius':
		temp -= 273
		return str(temp) + '°C'
	if d_type == 'Kelvin':
		return str(temp) + '°K'
	if d_type == 'Fahrenheit':
		temp = ((temp - 273.15)*1.8) + 32.00
		return "{0:.1f}".format(temp) + '°F'

if __name__ == "__main__":
	if app_id_ is not None:
		if city_id_ is not None:
			r = getWeatherByCityID(city_id_)
		elif zip_code_ is not None and country_code_ is not None:
			r = getWeatherByZipCode(zip_code_, country_code_)

	city = r['name']
	temp = int(r['main']['temp'])
	humidity = r['main']['humidity']
	weather = r['weather'][0]['description']
	if o_type_ is not None:
		print(weather + ' ' + degreeType(temp, o_type_))
	else:
		print(weather + ' ' + str(temp-273) + '°C')