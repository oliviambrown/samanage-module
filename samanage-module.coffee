#Name: samanage-module.coffee
#Author: Olivia Brown
#Date: April 21, 2017
#Language used: CoffeeScript
#Version: 1.0.0

#Goal Today: have all incidents display on widget

#variables needed for Samange API
subdomain = 'summitrdu'
username = 'obrown@summitrdu.com'
password = 'Marie22!'

#the styling variables 
#CHANGE IT ASAP
width = 'auto'
top = 'auto'
bottom = '80px' 
left = '1%'
right = 'auto'

#essential to ubersicht - shell command that's called every refresh
command: "curl -u '#{username}:#{password}' -H 'Accept: application/vnd.samanage.v1.1+xml' -X GET https://api.samanage.com/incidents.xml"

#refresh rate - essential to ubersicht
refreshFrequency: 1000 * 60 #every 60 seconds

#render method- essential to ubersicht - what draws to screen
#from ubersicht: 
# render gets called after the shell command has executed. The command's output
# is passed in as a string. Whatever it returns will get rendered as HTML.
render: (output) -> 
    """  """

#style method = essential to ubersicht - css
style: """ """


#boolean variable - shows the names for each category
showListNames: true

