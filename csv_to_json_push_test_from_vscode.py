# code to convert csv to json
import pandas as pd
def csv_to_json(csv_file, json_file):
    df = pd.read_csv(csv_file)
    json_data = df.to_json(orient='records')  
    with open(json_file, 'w') as f:
        f.write(json_data)
# example usage
csv_to_json(r'data\19964\CIE_CountryQuartileSummary.csv', r'data\19964\CIE_CountryQuartileSummary.json')