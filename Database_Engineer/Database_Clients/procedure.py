from process import PROCESSABLE

class Procedure(PROCESSABLE):
    def __init__(self, name, *args):
        self.name = name
        self.args = args

    def __run__(self, cursor):
        cursor.execute.callproc(self.name, *self.args)
