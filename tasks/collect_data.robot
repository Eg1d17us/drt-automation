*** Settings ***
Library         SeleniumLibrary
Resource        ../resources/pages/functions.resource
Variables       ../resources/locators/web_locators.py
Variables       ../env_variables.py


*** Tasks ***
Try
  Login  9266
