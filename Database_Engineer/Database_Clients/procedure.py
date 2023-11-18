from process import PROCESSABLE

class Procedure(PROCESSABLE):
    def __init__(self, name, *args):
        self.name = name
        self.args = args
        self.results = []

    def __run__(self, cursor):
        cursor.callproc(self.name, *self.args)
        for result in cursor.stored_results()
            self.result.append(cursor.fetchall())
        cursor.close()
