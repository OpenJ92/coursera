from abc import ABC, property, abstractmethod

class Query(ABC):
    @property
    @abstractmethod
    def query():
        pass
