from abc import ABC, property, abstractmethod

from process import PROCESSABLE

class Procedure(ABC):
    def __init__(self, name, *args):
        self.name = name
        self.args = args
        self.results = []

    @abstractmethod
    def evaluate(self, cursor):
        pass


## We should note that we presume mysql cursor obj
## here in run and evaluate. Obviously, this being a
## mysql procedure, we would never execure it in a process
## having a __CONNECTION__ to a psql database. How can
## we express this within the code? Is there a way
## to extend MySQLProcedure class with a MySQL
## super containing generic names for the specific
## methods used here? ie. stored_results, fetchall
## and callproc? Cursors should be database specific
## as Procedures and Queries are... ? 
class MySQLProcedure(PROCESSABLE, Procedure):
    def __init__(self, name, *args):
        Procedure.__init__(name, args)

    def __run__(self, cursor):
        self.evaluate(cursor)
        for result in cursor.stored_results()
            self.result.append(cursor.fetchall())
        cursor.close()

    def evaluate(self, cursor):
        return cursor.callproc(self.name, *self.args)
