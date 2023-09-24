1. Create python virtual env
python3 -m venv dbt-demo
dbt-demo/bin/activate

https://docs.getdbt.com/docs/supported-data-platforms

dbt --version 

dbt init dbt_revenue_tracker

(Don't see the one you want? https://docs.getdbt.com/docs/available-adapters)

Enter a number:

Press ctl + c

* readme describes the purpose of the project
* dbt_project file
* profile file
    * cd ~
    * cd .dbt
        * touch profiles.yml

* Let's create a database 
    * 

```dbt_project.yml
# This setting configures which "profile" dbt uses for this project.
profile: 'dbt_revenue_tracker'
```
* DBT debug 
    * Then we see that the connection passed

* Then from there, let's try to seed the database 
    * So move the cities.csv file over to the seed file
    * It will create public.cities in the 

* And we can reference the dbt seed file just like a normal model

https://medium.com/@jewelski/configure-my-dbt-core-side-project-using-my-local-postgres-database-f31c998ab6f3

* Then we can 

https://docs.getdbt.com/docs/core/connect-data-platform/profiles.yml