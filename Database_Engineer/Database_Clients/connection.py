from abc import ABC, property, abstractmethod

class Connector(ABC):
    @abstractmethod
    def __enter__(self):
        pass

    @abstractmethod
    def __exit__(self):
        # self.commit()? 
        pass

    @abstractmethod
    def get_connection(self):
        pass


    @abstractmethod
    def get_cursor(self):
        pass

class MySQLConnector(MySQL, Connector):
    def __init__(self, configuration):
        self.configuration = configuration

    def __enter__(self):
        pass

    def __exit__(self):
        pass

    def get_cursor(self):
        pass
