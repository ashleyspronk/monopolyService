# CS 262 Monopoly Webservice

This is the data service application for the 
[CS 262 sample Monopoly project](https://github.com/calvin-cs262-organization/monopoly-project),
 which is deployed here:
          
- <monopoly2-fxgbgmenb8gfajcd.eastus2-01.azurewebsites.net/>

It has the following read data route URLs:
- `/` a hello message
- `/players` a list of players
- `/players/:id` a single player with the given ID

It is based on the standard Azure App Service tutorial for Node.js.

- <https://learn.microsoft.com/en-us/azure/app-service/quickstart-nodejs?tabs=linux&pivots=development-environment-cli>  

The database is relational with the schema specified in the `sql/` sub-directory
and is hosted on [Azure PostgreSQL](https://azure.microsoft.com/en-us/products/postgresql/).
The database server, user and password are stored as Azure application settings so that they 
aren&rsquo;t exposed in this (public) repo.

We implement this sample service as a separate repo to simplify Azure integration;
it&rsquo;s easier to auto-deploy a separate repo to Azure. For your team project&rsquo;s 
data service, configure your Azure App Service to auto-deploy from the master/main branch 
of your service repo. See the settings for this in the &ldquo;Deployment Center&rdquo; 
on your Azure service dashboard.
 
Homework 3:
DONE BY ASHLEY SPRONK AND ALISHA START
a) /, /players, /players/id, /properties/id
b)the POST /players is not idempotent
    the /, /players, /players/id, /properties GET functions are nullipotent
c)Yes, because it uses https and the four CRUD things: get, post, put, and delete
    it is also stateless
    it also uses transfer.JSON to transfer data
    it also has an explicit URI
d)no there is not