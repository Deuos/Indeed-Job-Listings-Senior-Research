import pandas as pd
from wordcloud import WordCloud
import matplotlib.pyplot as plt

# Read the CSV
columns_to_read = ["description"]
df = pd.read_csv('cleanedData\Connecticutcleaned.csv', usecols=columns_to_read)

# Combine all descriptions into a single text
text = " ".join(df["description"])

# Create a WordCloud object
wordcloud = WordCloud(width=800, height=400, max_words=200, background_color="white").generate(text)

# Display the word cloud using matplotlib
plt.figure(figsize=(10, 5))
plt.imshow(wordcloud, interpolation="bilinear")
plt.axis("off")
#Save to file
plt.savefig("wordcloud/connecticutWordCloud.png")
plt.show()
