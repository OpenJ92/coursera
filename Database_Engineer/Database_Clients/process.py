from abc import ABC, property, abstractmethod

class Processable(ABC):
    @abstractmethod
    def __run__(self):
        pass

class Process:
    def __init__(self, connector: __CONNECTION__, actions: PROCESSABLE):
        self.connector = connector
        self.actions = actions

    def run(self):
        with self.connector as connector:
            connection = connector.get_connection()
            cursor     = connection.cursor()

            for action in actions:
                action.__run__(cursor)
