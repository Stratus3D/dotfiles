from io import StringIO
import sys

import pandas as pd


for sheet_name in pd.ExcelFile(sys.argv[1]).sheet_names:
    output = StringIO()
    print('Sheet: %s' % sheet_name)
    pd.read_excel(sys.argv[1], sheet_name=sheet_name)\
      .to_csv(output,
              header=True,
              index=False)
    print(output.getvalue())