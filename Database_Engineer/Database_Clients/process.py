from abc import ABC, property, abstractmethod

class PROCESSABLE(ABC):
    @abstractmethod
    def __run__(self):
        pass

class Process:
    def __init__(self, connection: __CONNECTION__, actions: PROCESSABLE):
        self.connection = connection
        self.actions = actions

    def run(self):
        with self.connection.get_connection() as connection:
            cursor = connection.cursor
            for action in actions:
                action.__run__(cursor)
