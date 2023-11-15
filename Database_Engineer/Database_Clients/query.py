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

