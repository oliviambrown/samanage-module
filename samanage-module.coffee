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
render: (_) -> 
    """ <div class='to-do-wrap'>Loading...</div>  """

#style method = essential to ubersicht - css
style: """
	bottom: #{bottom}
	top: #{top}
	left: #{left}
	right: #{right}
	width: #{width}
	color: #fff
	background: rgba(#525252,0.9)
	font-family: Myriad Set Pro, Helvetica Neue
	font-size: 10pt
	border-radius: 3px

	.lists,.tasks
		margin: 0
		padding: 0

	.list,.task
			list-style: none

	.list:first-child .list-info
		border-top-left-radius: 3px
		border-top-right-radius: 3px

	.list-info
		background: rgba(0,0,0,0.2)
		position: relative
		font-weight: bold

	.list-name
		padding: 5px 10px
		margin: 0 40px 0 0
		overflow: hidden
		text-overflow: ellipsis
		position: relative
		white-space: nowrap
		opacity: 0.85

	.list-info.Open,.list-info.New
		background: #E82A2A

	.list-info.Pending
		background: #59BBE0

	.tasks-length
		position: absolute
		top: 0px
		right: 5px
		opacity: 0.85
		padding: 5px 5px

	.task
		margin: 0 10px
		padding: 5px 0 5px 20px
		white-space: nowrap
		overflow: hidden
		text-overflow: ellipsis
		position: relative
		opacity: 0.85
		a
			color: #fff
			text-decoration: none
			&:hover
				text-decoration: underline

	.task::after
		content: ""
		position: absolute
		width: 10px
		height: 10px
		background: rgba(0,0,0,0.3)
		-webkit-border-radius: 20px
		left: 0
		top: 8px

	.error
		padding: 5px
		background: rgba(0,0,0,0.3)
"""


#boolean variable - shows the names for each category
showListNames: true

showLists: []
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
            title: 'New',  
            state: 'new'
        },
        {
            title:'Resolved',
            state: 'resolved'
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
        if(!taskNumbers[m.state] || n < taskNumbers[m.state]) && m.state == t.state
            taskArr.push
                title: t.name
                id: t.id
            counter++;
    base[m.title] = taskArr
    
    @base = base
    
_render: () ->
    template = '<ul class = "lists">'
    listNameHtml = ''
    base = if @showLists.length then @showLists else Object.keys(@base)
    
    base.forEach(listName) =>
        task = @base[listName]
        n = task.length
    
    if n
        if @showListNames
            listNameHtml = '<div class = "list-info ' +listName +'">' + 
            '<div class = "list-name">' + listName + '</div>' +
            '<div class ="task-length">' + n + '</div>' + '</div>'
        
        tasksList = ''
        base.forEach(task) =>
            tasksList += '<li class="task"><a href=https://'+@subdomain+'.samananage.com/incidents/'+task.id+'">'+task.title+'</a></li>'
            
        str += '<li class="list">' + listNameHtml + '<ul class="tasks>' + tasksList + '</ul>' + '</li>'
        str += '</ul>'
        
        @content.html str
        
  update: (output, domEl) ->

  if !@content
    @content = $(domEl).find('.to-do-wrap')
  # @something = this.something
  
  @tasks = @fetchTask output
  @base = @taskBase @tasks
  @_render ''
  .bind(this)          
        
        

