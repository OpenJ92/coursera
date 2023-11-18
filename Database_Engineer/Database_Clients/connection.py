from abc import ABC, property, abstractmethod
# Here, construct wrappers for db connections. They should implement
# __enter__ and __exit__ to work with with statements in the python
# language. These, with __Query__ objects, should compose with 
# process objects which handle the executeion of the 'raw' sql queries.

class __CONNECTION__(ABC):
    @abstractmethod
    def __enter__(self):
        pass

    @abstractmethod
    def __exit__(self):
        pass

    @abstractmethod
    def get_connection(self):
        pass
