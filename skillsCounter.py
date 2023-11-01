import pandas as pd
import re
import matplotlib.pyplot as plt

# Read the CSV
columns_to_read = ["description"]
df = pd.read_csv('data/jobsNewYork.csv', usecols=columns_to_read)

#Total count
language_counts = {}

# List of programming languages
languages_to_count = ["typescript", "java", "python", "c++", "php", "ruby", "rust", "css", "html", "javascript", "cobol", "c", "swift", "c#", "kotlin", "golang", "r", "sql", "scala", "mongoose", "mongodb", "matlab", "dart", "assembly language", "objective-c", "visual basic"]


for index, row in df.iterrows():
    description = row["description"].lower() 
    for language in languages_to_count:
        count = len(re.findall(r'\b' + language + r'\b', description))
        if language in language_counts:
            language_counts[language] += count
        else:
            language_counts[language] = count

# Print the counts for each language
#for language, count in language_counts.items():
#    print(f"{language}: {count} times")

# IN Pandas
result_df = pd.DataFrame(language_counts.items(), columns=["Language", "Count"])
print(result_df)

#Bar graph
plt.figure(figsize=(12, 6))  # Adjust the figure size as needed
plt.bar(result_df["Language"], result_df["Count"])
plt.xlabel("Language")
plt.ylabel("Count")
plt.title("Programming Language")
plt.xticks(rotation=90)

plt.tight_layout()
plt.show()