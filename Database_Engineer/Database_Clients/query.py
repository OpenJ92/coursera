from abc import ABC, property, abstractmethod

class __QUERY__(ABC):
    @abstractmethod
    def query():
        pass

class QueryFromFile(__Query__):
    def __init__(self, file):
        self.file = file

    def query(self):
        with open(self.file, 'r') as q:
            sql_query = q.read()
        return sql_query

class QueryFromString(__Query__):
    def __init__(self, string):
        self.string

    def query(self):
        return self.string


class __CONNECTION__(ABC):
    @abstractmethod
    def __enter__(self):
        pass

    @abstractmethod
    def __exit__(self):
        pass

# Next we want to make a class that takes a __Query__ and a 
# __Connection__ type form and carries out the __Query__ action
# over the __Connection__. We may want to have secondary set of 
# query classes which store thier results within class. That is
# to say that they communicate to the Process Class that they
# need to have their results stored somehow

# __PROCESS__(__CONNECTION__, [__QUERY__]) 
# A Process should act out what we've been doing in the lessons
# so far, making a connection to the db and executing the queries.
#
# One might imagine them being written as:
#
#   ConstructDatabaseProcess(mysql.connection, construction_queries)
#   PopulateDatabaseProcess(myql.connection, population_quereis)
#   AnalyzeDatabase....
