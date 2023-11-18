from process import PROCESSABLE

class Query(PROCESSABLE):
    @classmethod
    def FromFile(cls, file):
        with open(file, 'r') as q:
            query = q.read()
        return cls(query)

    @classmethod
    def FromString(cls, string):
        return cls(string)

    def __init__(self, query):
        self.query = query
        self.results = None

    def __run__(self, cursor):
        cursor.execute(self.query)
        self.result = cursor.fetchall()
        cursor.close()


# Next we want to make a class that takes a __Query__ and a 
# __Connection__ type form and carries out the __Query__ action
# over the __Connection__. We may want to have secondary set of 
# query classes which store thier results within class. That is
# to say that they communicate to the Process Class that they
# need to have their results stored somehow

# __PROCESS__(__CONNECTION__, [__QUERY__ | __PROCEDURE__]) 
# A Process should act out what we've been doing in the lessons
# so far, making a connection to the db and executing the queries.
#
# One might imagine them being written as:
#
#   ConstructDatabaseProcess(mysql.connection, construction_queries)
#   PopulateDatabaseProcess(myql.connection, population_quereis)
#   AnalyzeDatabase....
