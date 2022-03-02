import sys

import textract


print(textract.process(sys.argv[1]).decode('utf-8'))