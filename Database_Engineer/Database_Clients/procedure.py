from abc import ABC, property, abstractmethod

from process import Processable

class Procedure(ABC):
    def __init__(self, name, *args):
        self.name = name
        self.args = args
        self.results = []

    @abstractmethod

    def call(self, cursor):
        pass

class MySQLProcedure(MySQL, Processable, Procedure):
    def __init__(self, name, *args):
        Procedure.__init__(name, args)

    def call(self, cursor):
        return cursor.callproc(self.name, *self.args)

    def __run__(self, cursor):
        self.call(cursor)

        for result in cursor.stored_results()
            self.result.append(cursor.fetchall())
        cursor.close()

class PSQLProcedure(PSQL, Processable, Procedure):
    pass
