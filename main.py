from database import DataBase
import sys
import numpy
import datetime

arr = []
FreeTerms = []
res = []

print('Enter the name of file: ', end=': ')
FileName = input()

try:
    file = open(FileName, 'r')
except IOError as error:
    print(str(error))
    sys.exit(5)
else:
    with file:
        for line in file:
            tmp = []
            for item in line.split():
                try:
                    tmp.append(float(item))
                except Exception:
                    sys.exit(2)
            FreeTerms.append(tmp.pop())
            arr.append(tmp)
            print(tmp)

try:
    res = numpy.linalg.solve(arr, FreeTerms)
    DataBase.callFunction("add_sys", str(arr), str(res))
    DataBase.callFunction("add_log", str(res), str(datetime.datetime.now().timestamp()), str(arr))

except Exception as error:
    DataBase.callFunction("add_log", str(error), str(datetime.datetime.now().timestamp()), str(arr))
    sys.exit(3)