from flask import *
from flask_cors import CORS
import json
import requests
import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity
app = Flask(__name__)

# import firebase_admin
# from firebase_admin import credentials
# from firebase_admin import firestore

# # Use a service account.
# cred = credentials.Certificate(
#     'commentary api/footieheroes-firebase-adminsdk-bljkf-2865597fa6.json')

# firebaseApp = firebase_admin.initialize_app(cred)

# db = firestore.client()

df = pd.read_excel('commentary api/FHcomn.xlsx')
sentences = df['Sentences'].tolist()
dataset_keywords = df['Keywords'].tolist()


@app.route('/', methods=['POST'])
def getCommentary():
    similarities_dict = {}
    sentence_index = 0
    for keyword in dataset_keywords:

        client_keywords = set(request.json['keywords'].split())
        sentence_keywords = set(keyword.split())

        # Convert keyword sets to input arrays and compute cosine similarity
        keyword_array = list(client_keywords.union(sentence_keywords))
        # print(keyword_array)
        vector1 = [
            1 if keyword in client_keywords else 0 for keyword in keyword_array]
        vector2 = [
            1 if keyword in sentence_keywords else 0 for keyword in keyword_array]
        # print(vector1)
        # print(vector2)
        similarity = cosine_similarity([vector1], [vector2])
        similarity_value = similarity[0][0]

        similarities_dict.update({sentences[sentence_index]: similarity_value})
        sentence_index += 1

    # print(similarities_dict)
    sorted_similarities = dict(
        sorted(similarities_dict.items(), key=lambda x: x[1], reverse=True))
    similar_sentences_list = list(sorted_similarities.keys())

    return jsonify({'sentences': [s for s in similar_sentences_list[:10]]})


if __name__ == '__main__':
    app.run(port=7777)
CORS(app)


# def compute_similarity(client_keywords, sentence_keywords):

#     client_keywords = client_keywords.split()
#     sentence_keywords = sentence_keywords.split()

#     # Convert keyword sets to input arrays and compute cosine similarity
#     keyword_array = list(client_keywords.union(sentence_keywords))
#     # print(keyword_array)
#     vector1 = [1 if keyword in client_keywords else 0 for keyword in keyword_array]
#     vector2 = [
#         1 if keyword in sentence_keywords else 0 for keyword in keyword_array]
#     # print(vector1)
#     # print(vector2)
#     similarity = cosine_similarity([vector1], [vector2])
#     return similarity[0][0]
