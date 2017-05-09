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
command: "curl -u #{username}:#{password} -H 'Accept: application/vnd.samanage.v1.1+json' -H 'Content-Type: application/json' -X GET https://api.samanage.com/incidents.json"

#refresh rate - essential to ubersicht
refreshFrequency: 1000 * 60 #every 60 seconds

#render method- essential to ubersicht - what draws to screen
#from ubersicht: 
# render gets called after the shell command has executed. The command's output
# is passed in as a string. Whatever it returns will get rendered as HTML.
render: (output) -> 
    """  """

#style method = essential to ubersicht - css
style: """

"""


#boolean variable - shows the names for each category
showListNames: true

#shows certain amount of tasks
taskNumbers:
    'new': 10
    'resolved': 10
    
#method to change json into javascript object
fetchTask: (output) ->
    json = JSON.parse(ouput)
    json.result

#function to manipulate the json turned js objects

#multidimensional array - holds the info both the tasksarrays for each state
taskBase: (tasks) ->
    base = {};

#list object to hold the different states, new and resolved for placeholders
    manager = [
        {
            state: 'New',  
            status: 'new'
        },
        {
            state:'Resolved',
            status: 'resolved'
        }]
    
    #taskNumbers = this.taskNumbers
    taskNumbers = @taskNumbers
    
#applies
manager.forEach (m) -> 
    #create an array for each state
    taskArr = []
    counter = 0
    task.forEach (t) ->
        #if 
        if(!taskNumbers[m.status] || n < taskNumbers[m.status]) && m.status == t.status
            taskArr.push
                title: t.name
                id: t.id
            counter++
    base[m.title] = taskArr
    
    @base = base
    
_render: () ->
    template = '<ul class = "lists">'
    listNameHtml = ''
    tree = if @showListNames.length then @showListNames else Object.keys(@tree)
    
    tree.forEach(listName) =->
        tasks = @tree[listName]
        n = tasks.length
    
    if n
        if @showListNames
            listNameHtml = '<div class = "list-info ' +listName +'">' + 
            '<div class = "list-name">' + listName + '</div>' +
            '<div class ="task-length">' + n + '</div>' + '</div>'
        
        tasksList = ''
        tasksforEach(task) =>
            tasksList += '<li class="task"><a href=https://'+@subdomain+'.samananage.com/'+task.id+'">'+task.title+'</a></li>' 
        

