import pandas as pd
# write a function that takes csv as input and return json as output and saves it to a file
def csv_to_json(csv_file, json_file):
    # Read the CSV file
    df = pd.read_csv(csv_file)
    # Convert the DataFrame to JSON
    json_data = df.to_json(orient='records')  
    # Save the JSON data to a file
    with open(json_file, 'w') as f:
        f.write(json_data)
# example usage
csv_to_json(r'data\19964\CIE_CountryQuartileSummary.csv', r'data\19964\CIE_CountryQuartileSummary.json')