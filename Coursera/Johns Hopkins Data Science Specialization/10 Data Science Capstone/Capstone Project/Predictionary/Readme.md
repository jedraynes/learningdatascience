# Predictionary

---

Hello! This app is my submission for the [Data Science Capstone](https://www.coursera.org/learn/data-science-project?specialization=jhu-data-science), the final course in the [Johns Hopkins University Data Science Specialization offered by Coursera](https://www.coursera.org/specializations/jhu-data-science). 

The app takes a user's inputted text string and uses an n-gram dictionary to predict what the next word in the string will be. The corpora used as the basis for the dictionary is found [here](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip) and is made up of a collection of tweets, blog posts, and news articles aggregated into three separate text files.

After using exploring the dataset, I used NLP techniques and the methodology of the [Stupid Back Off algorithm](https://www.aclweb.org/anthology/D07-1090.pdf) to create a score for each probable word. The model uses n-grams to predict the next word in the sentence. Please note that profane words were intentionally **not** filtered from the results. Enjoy!

---
[![image](https://img.shields.io/badge/Personal%20Site-%20-informational?style=flat-square&logo=appveyor)](https://www.jedraynes.com/)
[![image](https://img.shields.io/badge/LinkedIn-%20-informational?style=flat-square&logo=appveyor)](https://www.linkedin.com/in/jedraynes/)

jedraynes