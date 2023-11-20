from abc import ABC, property, abstractmethod

from process import Processable

class Query(ABC):
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

    @abstractmethod
    def execute(self, cursor):
        pass


class MySQLQuery(MySQL, Processable, Query)
    def __init__(self, query):
        Query.__init__(query)
    
    def execute(self, cursor):
        return cursor.execute(self.query)


    def __run__(self, cursor):
        self.execute(cursor)
        self.result = cursor.fetchall()
        cursor.close()


class PSQLQuery(PSQL, Processable, Query):
    pass
