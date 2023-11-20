from abc import ABC, property, abstractmethod

class __CONNECTION__(ABC):
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
    def get_connection(self):


    @abstractmethod
    def get_cursor(self):
        pass
