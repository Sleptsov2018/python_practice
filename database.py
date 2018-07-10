from threading import Lock
import mysql.connector

class _DataBase:
    def __connect(self):
        self.__db = mysql.connector.connect(host='localhost', database='MainBase', user='root', password='')
        if self.__db.is_connected():
            self.__cursor = self.__db.cursor()
    def __init__(self):
        self.__connect()
        self._mutex = Lock()
    def callFunction(self, nameFunction: str, *args):
        self._mutex.acquire()
        result = None
        try:
            if not (self.__db.is_connected()):
                self.__connect()

            self.__cursor.callproc(nameFunction, args)
            result = []

            for item in self.__cursor.stored_results():
                for item2 in item.fetchall():
                    result.append(item2)

            self.__db.commit()

        finally:
            self._mutex.release()
        return result

DataBase = _DataBase()