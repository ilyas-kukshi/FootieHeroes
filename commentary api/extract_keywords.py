
import pandas as pd
from rake_nltk import Rake
import nltk
nltk.download('stopwords')
nltk.download('punkt')
nltk.download('stopwords')


# Initialize RAKE with stopword list
stopwords = nltk.corpus.stopwords.words('english')

stopwords.extend(("player1", "player2"))

r = Rake( stopwords=stopwords, max_length=4)

df = pd.read_excel('commentary api/FHcomn.xlsx')
sentences = df['Sentences'].tolist()
final_keywords_list = []

for sentence in sentences:
    r.extract_keywords_from_text(sentence)
    keywords = r.get_ranked_phrases()

    keyword_string = ''
    for keyword in keywords:
        keyword_string += " " + keyword
        
    # print(keyword_string)
    final_keywords_list.append(keyword_string)

new_df = pd.DataFrame({'Sentences' : sentences, 'Keywords' : final_keywords_list})
new_df.to_excel('commentary api/FHcomn.xlsx', index=False)
    



